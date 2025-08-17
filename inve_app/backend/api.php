<?php
header("Content-Type: application/json");

// --------------------
// اتصال قاعدة البيانات
// --------------------
$host = "sql309.infinityfree.com";
$user = "if0_39725112";
$pass = "********";
$dbname = "if0_39725112_inventory_db";

$conn = new mysqli($host, $user, $pass, $dbname);
if ($conn->connect_error) {
    die(json_encode(array("error" => "فشل الاتصال بقاعدة البيانات")));
}

// --------------------
// تحديد نوع الطلب
// --------------------
$method = $_SERVER['REQUEST_METHOD'];
$search = isset($_GET['search']) ? $_GET['search'] : '';

$data = json_decode(file_get_contents("php://input"), true);

// --------------------
// تحديد الطلب (request) من URL
// --------------------
$request = isset($_GET['request']) ? $_GET['request'] : '';

// --------------------
// إدارة الأصناف
// --------------------
if ($request === 'items') {
    if ($method === 'GET') {
        $search = isset($_GET['search']) ? $_GET['search'] : '';
        $stmt = $conn->prepare("
            SELECT 
                i.id, i.name, i.unit_price,
                IFNULL(SUM(CASE WHEN t.type='add' THEN t.quantity ELSE 0 END),0) -
                IFNULL(SUM(CASE WHEN t.type='withdraw' THEN t.quantity ELSE 0 END),0) AS net_quantity
            FROM items i
            LEFT JOIN transactions t ON i.id = t.item_id
            WHERE i.name LIKE ?
            GROUP BY i.id, i.name, i.unit_price
            ORDER BY i.name ASC
        ");
        $like = "%".$search."%";
        $stmt->bind_param("s", $like);
        $stmt->execute();
        $result = $stmt->get_result();
        $rows = array();
        while ($row = $result->fetch_assoc()) { $rows[] = $row; }
        echo json_encode($rows);
    }

    if ($method === 'POST') {
        $name = isset($data['name']) ? $data['name'] : '';
        $unit_price = isset($data['unit_price']) ? $data['unit_price'] : 0;
        if (!$name || !$unit_price) {
            echo json_encode(array("error" => "الاسم والسعر مطلوبين"));
            exit;
        }
        $stmt = $conn->prepare("INSERT INTO items (name, unit_price) VALUES (?, ?)");
        $stmt->bind_param("sd", $name, $unit_price);
        if ($stmt->execute()) {
            echo json_encode(array("message" => "تم إضافة الصنف", "itemId" => $stmt->insert_id));
        } else {
            echo json_encode(array("error" => $stmt->error));
        }
    }
}

// --------------------
// إدارة المعاملات
// --------------------
if ($request === 'transactions') {
    if ($method === 'GET') {
        $item_id = isset($_GET['item_id']) ? $_GET['item_id'] : null;
        if (!$item_id) { echo json_encode(array("error"=>"معرف الصنف مطلوب")); exit; }
        $stmt = $conn->prepare("SELECT id, type, quantity, created_at FROM transactions WHERE item_id=? ORDER BY created_at DESC");
        $stmt->bind_param("i", $item_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $rows = array();
        while ($row = $result->fetch_assoc()) { $rows[] = $row; }
        echo json_encode($rows);
    }

    if ($method === 'POST') {
        $item_id = isset($data['item_id']) ? $data['item_id'] : 0;
        $type = isset($data['type']) ? $data['type'] : '';
        $quantity = isset($data['quantity']) ? $data['quantity'] : 0;
        if (!$item_id || !in_array($type,array('add','withdraw')) || !$quantity || $quantity<=0) {
            echo json_encode(array("error"=>"بيانات غير صحيحة"));
            exit;
        }
        $stmt = $conn->prepare("INSERT INTO transactions (item_id, type, quantity) VALUES (?, ?, ?)");
        $stmt->bind_param("isi", $item_id, $type, $quantity);
        if ($stmt->execute()) {
            echo json_encode(array("message"=>"تمت الإضافة","transactionId"=>$stmt->insert_id));
        } else { echo json_encode(array("error"=>$stmt->error)); }
    }

    if ($method === 'PUT') {
        parse_str(file_get_contents("php://input"), $put_data);
        $id = isset($put_data['id']) ? $put_data['id'] : 0;
        $type = isset($put_data['type']) ? $put_data['type'] : '';
        $quantity = isset($put_data['quantity']) ? $put_data['quantity'] : 0;
        if (!$id || !in_array($type,array('add','withdraw')) || !$quantity || $quantity<=0) {
            echo json_encode(array("error"=>"بيانات غير صحيحة"));
            exit;
        }
        $stmt = $conn->prepare("UPDATE transactions SET type=?, quantity=? WHERE id=?");
        $stmt->bind_param("sii", $type, $quantity, $id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) echo json_encode(array("error"=>"العملية غير موجودة"));
        else echo json_encode(array("message"=>"تم التحديث"));
    }

    if ($method === 'DELETE') {
        $id = isset($_GET['id']) ? $_GET['id'] : 0;
        if (!$id) { echo json_encode(array("error"=>"معرف العملية مطلوب")); exit; }
        $stmt = $conn->prepare("DELETE FROM transactions WHERE id=?");
        $stmt->bind_param("i",$id);
        $stmt->execute();
        if ($stmt->affected_rows === 0) echo json_encode(array("error"=>"العملية غير موجودة"));
        else echo json_encode(array("message"=>"تم الحذف"));
    }
}

// --------------------
// تسجيل مستخدم / تسجيل دخول
// --------------------
if ($request === 'auth') {
    $action = isset($data['action']) ? $data['action'] : '';
    if ($action==='register') {
        $email = isset($data['email']) ? $data['email'] : '';
        $username = isset($data['username']) ? $data['username'] : '';
        $password = isset($data['password']) ? $data['password'] : '';
        $role = (isset($data['role']) && $data['role']==='admin') ? 'admin' : 'user';
        if (!$email || !$username || !$password) { echo json_encode(array("error"=>"جميع الحقول مطلوبة")); exit; }
        $hashed = password_hash($password,PASSWORD_BCRYPT);
        $stmt = $conn->prepare("INSERT INTO users (email, username, password, role) VALUES (?,?,?,?)");
        $stmt->bind_param("ssss",$email,$username,$hashed,$role);
        if($stmt->execute()) echo json_encode(array("success"=>true,"message"=>"تم إنشاء المستخدم بنجاح"));
        else echo json_encode(array("error"=>$stmt->error));
    }

    if ($action==='login') {
        $username = isset($data['username']) ? $data['username'] : '';
        $password = isset($data['password']) ? $data['password'] : '';
        if (!$username || !$password) { echo json_encode(array("error"=>"الرجاء إدخال اسم المستخدم وكلمة المرور")); exit; }
        $stmt = $conn->prepare("SELECT id, username, role, password FROM users WHERE username=? LIMIT 1");
        $stmt->bind_param("s",$username);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();
        if(!$user || !password_verify($password,$user['password'])) echo json_encode(array("success"=>false,"error"=>"بيانات غير صحيحة"));
        else {
            unset($user['password']);
            echo json_encode(array("success"=>true,"user"=>$user));
        }
    }
}

$conn->close();
?>
