import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inve_app/main.dart';

class ItemManagerPage extends StatefulWidget {
  const ItemManagerPage({super.key});

  @override
  State<ItemManagerPage> createState() => _ItemManagerPageState();
}

class _ItemManagerPageState extends State<ItemManagerPage> {
  List items = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  int? editId;
  String message = '';
  bool isError = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      final res = await http.get(Uri.parse('http://100.70.131.12:5000/items'));
      if (res.statusCode == 200) {
        setState(() {
          items = json.decode(res.body);
        });
      } else {
        setMessage('حدث خطأ أثناء جلب البيانات', true);
      }
    } catch (e) {
      setMessage('حدث خطأ أثناء جلب البيانات', true);
    }
  }

  void setMessage(String msg, bool error) {
    setState(() {
      message = msg;
      isError = error;
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        message = '';
      });
    });
  }

  void resetForm() {
    nameController.clear();
    unitPriceController.clear();
    editId = null;
  }

  Future<void> handleSubmit() async {
    String name = nameController.text.trim();
    String unitPrice = unitPriceController.text.trim();

    if (name.isEmpty || unitPrice.isEmpty) {
      setMessage('الرجاء ملء جميع الحقول', true);
      return;
    }

    try {
      if (editId == null) {
        await http.post(
          Uri.parse('http://100.70.131.12:5000/items'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'name': name, 'unit_price': double.parse(unitPrice)}),
        );
        setMessage('تمت الإضافة بنجاح', false);
      } else {
        await http.put(
          Uri.parse('http://100.70.131.12:5000/items/$editId'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'name': name, 'unit_price': double.parse(unitPrice)}),
        );
        setMessage('تم التحديث بنجاح', false);
      }
      resetForm();
      fetchItems();
    } catch (e) {
      setMessage('حدث خطأ في العملية', true);
    }
  }

  Future<void> handleDelete(int id) async {
    bool confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من حذف هذا الصنف؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('إلغاء')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('حذف')),
        ],
      ),
    );

    if (!confirm) return;

    try {
      await http.delete(Uri.parse('http://100.70.131.12:5000/items/$id'));
      setMessage('تم الحذف بنجاح', false);
      fetchItems();
      if (editId == id) resetForm();
    } catch (e) {
      setMessage('حدث خطأ أثناء الحذف', true);
    }
  }

  void handleEdit(Map item) {
    nameController.text = item['name'];
    unitPriceController.text = item['unit_price'].toString();
    editId = item['id'];
    setState(() {
      message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    List filteredItems = items.where((item) =>
        item['name'].toLowerCase().contains(searchController.text.trim().toLowerCase())).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('إدارة الأصناف'),
          centerTitle: true,
            actions: [
    IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'تسجيل خروج',
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      },
    ),
  ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (message.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isError ? Colors.red[200] : Colors.green[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                      child: Text(
                    message,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'ابحث باسم الصنف...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'اسم الصنف',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: unitPriceController,
                      decoration: InputDecoration(
                        hintText: 'سعر الوحدة',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: Text(editId == null ? 'إضافة' : 'تحديث'),
                  ),
                  if (editId != null)
                    TextButton(onPressed: resetForm, child: const Text('إلغاء')),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                 return Card(
  margin: const EdgeInsets.symmetric(vertical: 6),
  child: Padding(
    padding: const EdgeInsets.all(12),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            item['name'],
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis, // يقص الاسم لو طويل
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            double.parse(item['unit_price'].toString()).toStringAsFixed(2),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis, // يقص السعر لو حصل ضغط
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // لو الأيقونات ضغطت خليها تتزحزح
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 20,
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => handleEdit(item),
                  tooltip: 'تعديل',
                ),
                IconButton(
                  iconSize: 20,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => handleDelete(item['id']),
                  tooltip: 'حذف',
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
