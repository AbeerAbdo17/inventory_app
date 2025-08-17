const dotenv = require('dotenv');
dotenv.config({ path: './config.env' });

console.log('DB_NAME:', process.env.DB_NAME); // السطر للتحقق من قراءة .env

const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
const bcrypt = require('bcrypt');

const app = express();
app.use(cors());
app.use(express.json());

const dbConfig = {
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
};


// --------------------
// إضافة صنف جديد
// --------------------
app.post('/items', async (req, res) => {
  const { name, unit_price } = req.body;
  if (!name || !unit_price) return res.status(400).json({ error: 'الاسم والسعر مطلوبين' });

  try {
    const connection = await mysql.createConnection(dbConfig);
    const [result] = await connection.execute(
      'INSERT INTO items (name, unit_price) VALUES (?, ?)',
      [name, unit_price]
    );
    await connection.end();
    res.json({ message: 'تم إضافة الصنف', itemId: result.insertId });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'حدث خطأ في السيرفر' });
  }
});

// --------------------
// جلب الأصناف مع حساب الكمية الصافية
// --------------------
app.get('/items', async (req, res) => {
  const search = req.query.search || '';
  try {
    const connection = await mysql.createConnection(dbConfig);
    const [rows] = await connection.execute(`
      SELECT 
        i.id,
        i.name,
        i.unit_price,
        IFNULL(SUM(CASE WHEN t.type='add' THEN t.quantity ELSE 0 END),0) -
        IFNULL(SUM(CASE WHEN t.type='withdraw' THEN t.quantity ELSE 0 END),0) AS net_quantity
      FROM items i
      LEFT JOIN transactions t ON i.id = t.item_id
      WHERE i.name LIKE ?
      GROUP BY i.id, i.name, i.unit_price
      ORDER BY i.name ASC
    `, [`%${search}%`]);

    await connection.end();
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'خطأ في السيرفر' });
  }
});

// --------------------
// جلب العمليات لصنف معين
// --------------------
app.get('/items/:id/transactions', async (req, res) => {
  const itemId = req.params.id;
  try {
    const connection = await mysql.createConnection(dbConfig);
    const [rows] = await connection.execute(
      'SELECT id, type, quantity, created_at FROM transactions WHERE item_id = ? ORDER BY created_at DESC',
      [itemId]
    );
    await connection.end();
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: 'خطأ في السيرفر' });
  }
});

// --------------------
// إضافة عملية (سحب أو إضافة)
// --------------------
app.post('/transactions', async (req, res) => {
  const { item_id, type, quantity } = req.body;
  if (!item_id || !['add','withdraw'].includes(type) || !quantity || quantity <= 0) {
    return res.status(400).json({ error: 'بيانات غير صحيحة' });
  }

  try {
    const connection = await mysql.createConnection(dbConfig);
    const [result] = await connection.execute(
      'INSERT INTO transactions (item_id, type, quantity) VALUES (?, ?, ?)',
      [item_id, type, quantity]
    );
    await connection.end();
    res.json({ message: 'تمت الإضافة', transactionId: result.insertId });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'خطأ في السيرفر' });
  }
});

// --------------------
// تعديل عملية
// --------------------
app.put('/transactions/:id', async (req, res) => {
  const id = req.params.id;
  const { type, quantity } = req.body;

  if (!['add','withdraw'].includes(type) || !quantity || quantity <= 0) {
    return res.status(400).json({ error: 'بيانات غير صحيحة' });
  }

  try {
    const connection = await mysql.createConnection(dbConfig);
    const [result] = await connection.execute(
      'UPDATE transactions SET type=?, quantity=? WHERE id=?',
      [type, quantity, id]
    );
    await connection.end();

    if (result.affectedRows === 0) return res.status(404).json({ error: 'العملية غير موجودة' });

    res.json({ message: 'تم التحديث' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'خطأ في السيرفر' });
  }
});

// --------------------
// حذف عملية
// --------------------
app.delete('/transactions/:id', async (req, res) => {
  const id = req.params.id;
  try {
    const connection = await mysql.createConnection(dbConfig);
    const [result] = await connection.execute('DELETE FROM transactions WHERE id=?', [id]);
    await connection.end();

    if (result.affectedRows === 0) return res.status(404).json({ error: 'العملية غير موجودة' });

    res.json({ message: 'تم الحذف' });
  } catch (error) {
    res.status(500).json({ error: 'خطأ في السيرفر' });
  }
});

app.put('/items/:id', async (req, res) => {
  const id = req.params.id;
  const { name, unit_price } = req.body;
  if (!name || !unit_price) return res.status(400).json({ error: 'الاسم والسعر مطلوبين' });

  try {
    const connection = await mysql.createConnection(dbConfig);
    const [result] = await connection.execute(
      'UPDATE items SET name=?, unit_price=? WHERE id=?',
      [name, unit_price, id]
    );
    await connection.end();

    if (result.affectedRows === 0) return res.status(404).json({ error: 'الصنف غير موجود' });

    res.json({ message: 'تم التحديث' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'حدث خطأ في السيرفر' });
  }
});

app.delete('/items/:id', async (req, res) => {
  const id = req.params.id;
  try {
    const connection = await mysql.createConnection(dbConfig);
    const [result] = await connection.execute('DELETE FROM items WHERE id=?', [id]);
    await connection.end();

    if (result.affectedRows === 0) return res.status(404).json({ error: 'الصنف غير موجود' });

    res.json({ message: 'تم الحذف' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'حدث خطأ في السيرفر' });
  }
});

// --------------------
// Register (تسجيل مستخدم جديد)
// --------------------
app.post('/register', async (req, res) => {
  const { email, username, password, role } = req.body;
  if (!email || !username || !password) {
    return res.status(400).json({ error: 'جميع الحقول مطلوبة' });
  }

  const userRole = role === 'admin' ? 'admin' : 'user';

  try {
    const hashedPassword = await bcrypt.hash(password, 10); // تشفير كلمة المرور
    const connection = await mysql.createConnection(dbConfig);
    await connection.execute(
      'INSERT INTO users (email, username, password, role) VALUES (?, ?, ?, ?)',
      [email, username, hashedPassword, userRole]
    );
    await connection.end();

    res.json({ success: true, message: 'تم إنشاء المستخدم بنجاح' });
  } catch (err) {
    if (err && err.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({ error: 'الإيميل أو اسم المستخدم مستخدم بالفعل' });
    }
    console.error(err);
    res.status(500).json({ error: 'خطأ في السيرفر' });
  }
});


// --------------------
// Login (تسجيل الدخول)
// --------------------
app.post('/login', async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ error: 'الرجاء إدخال اسم المستخدم وكلمة المرور' });
  }
  try {
    const connection = await mysql.createConnection(dbConfig);
    const [rows] = await connection.execute(
      'SELECT id, username, role, password FROM users WHERE username = ? LIMIT 1',
      [username]
    );
    await connection.end();

    if (!rows || rows.length === 0) {
      return res.status(401).json({ success: false, error: 'بيانات غير صحيحة' });
    }

    const user = rows[0];

    const match = await bcrypt.compare(password, user.password); // التحقق من كلمة المرور
    if (!match) {
      return res.status(401).json({ success: false, error: 'كلمة المرور خاطئة' });
    }

    delete user.password; // نحذف الـ password قبل الإرسال للعميل
    res.json({ success: true, message: 'تم تسجيل الدخول', user });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'خطأ في السيرفر' });
  }
});

// --------------------
// تشغيل السيرفر
// --------------------

const PORT = process.env.PORT || 5000;

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});