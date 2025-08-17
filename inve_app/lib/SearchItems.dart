import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:inve_app/main.dart' show LoginPage;

void main() {
  runApp(MaterialApp(
    home: SearchItemsScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

const API_BASE = 'http://100.70.131.12:5000';

class SearchItemsScreen extends StatefulWidget {
  @override
  _SearchItemsScreenState createState() => _SearchItemsScreenState();
}

class _SearchItemsScreenState extends State<SearchItemsScreen> {
  TextEditingController searchController = TextEditingController();
  List items = [];
  bool loadingItems = false;
  String error = '';
  Map? selectedItem;

  void fetchItems(String term) async {
    if (term.isEmpty) {
      setState(() {
        items = [];
        error = '';
      });
      return;
    }
    setState(() => loadingItems = true);
    try {
      var res = await Dio().get('$API_BASE/items', queryParameters: {'search': term});
      setState(() => items = res.data ?? []);
    } catch (e) {
      setState(() => error = 'حدث خطأ أثناء البحث');
    } finally {
      setState(() => loadingItems = false);
    }
  }

  void openItem(Map item) {
    setState(() {
      selectedItem = item;
    });
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: TransactionsPopup(
          item: item,
          onNetQuantityChange: (newNet) {
            setState(() {
              items = items.map((it) => it['id'] == item['id'] ? {...it, 'net_quantity': newNet} : it).toList();
            });
          },
        ),
      ),
    ).then((_) => setState(() => selectedItem = null));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('بحث وإدارة الأصناف'),
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
              // البحث
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'ابحث باسم الصنف...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      fetchItems('');
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (val) => Future.delayed(
                    const Duration(milliseconds: 300),
                    () => fetchItems(val.trim())),
              ),
              const SizedBox(height: 16),
              if (loadingItems) const LinearProgressIndicator(),
              if (error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(error, style: const TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 8),
              // قائمة الأصناف
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    var item = items[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        title: Text(
                          item['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(
                            'الكمية الصافية: ${item['net_quantity'] ?? 0}'),
                        trailing: Text('سعر الوحدة: ${item['unit_price']}'),
                        onTap: () => openItem(item),
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

// ---------------- Popup Transactions ----------------
class TransactionsPopup extends StatefulWidget {
  final Map item;
  final Function(int) onNetQuantityChange;

  TransactionsPopup({required this.item, required this.onNetQuantityChange});

  @override
  _TransactionsPopupState createState() => _TransactionsPopupState();
}

class _TransactionsPopupState extends State<TransactionsPopup> {
  List transactions = [];
  int? editId;
  String editType = 'add';
  String editQuantity = '';
  String newType = 'add';
  String newQuantity = '';
  String message = '';
  bool isError = false;
  int netQuantity = 0;

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  void loadTransactions() async {
    try {
      var res = await Dio().get('$API_BASE/items/${widget.item['id']}/transactions');
      transactions = res.data ?? [];
      netQuantity = transactions.fold<int>(
        0,
        (sum, tx) {
          final qty = int.tryParse(tx['quantity'].toString()) ?? 0;
          return tx['type'] == 'add' ? sum + qty : sum - qty;
        },
      );
      widget.onNetQuantityChange(netQuantity);
      setState(() {});
    } catch (e) {
      setState(() {
        message = 'حدث خطأ أثناء جلب العمليات';
        isError = true;
      });
    }
  }

  void saveEdit(int id) async {
    int qty = int.tryParse(editQuantity) ?? 0;
    if (qty <= 0) {
      setState(() {
        message = 'الكمية يجب أن تكون رقم أكبر من صفر';
        isError = true;
      });
      return;
    }
    try {
      await Dio().put('$API_BASE/transactions/$id', data: {'type': editType, 'quantity': qty});
      editId = null;
      loadTransactions();
    } catch (e) {
      setState(() {
        message = 'حدث خطأ أثناء التحديث';
        isError = true;
      });
    }
  }

  void deleteTx(int id) async {
    bool confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من الحذف؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('إلغاء')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('حذف')),
        ],
      ),
    ) ?? false;
    if (!confirm) return;
    try {
      await Dio().delete('$API_BASE/transactions/$id');
      loadTransactions();
    } catch (e) {
      setState(() {
        message = 'حدث خطأ أثناء الحذف';
        isError = true;
      });
    }
  }

  void addTransaction() async {
    int qty = int.tryParse(newQuantity) ?? 0;
    if (qty <= 0) {
      setState(() {
        message = 'الكمية يجب أن تكون رقم أكبر من صفر';
        isError = true;
      });
      return;
    }
    try {
      await Dio().post('$API_BASE/transactions', data: {'item_id': widget.item['id'], 'type': newType, 'quantity': qty});
      newQuantity = '';
      loadTransactions();
    } catch (e) {
      setState(() {
        message = 'حدث خطأ أثناء الإضافة';
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: 450,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('تفاصيل الصنف: ${widget.item['name']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
            const SizedBox(height: 8),
            Text('سعر الوحدة: ${widget.item['unit_price']}'),
            if (message.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: isError ? Colors.red[100] : Colors.green[100],
                padding: const EdgeInsets.all(8),
                child: Center(child: Text(message)),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var tx in transactions)
                      Card(
                        child: ListTile(
                          title: editId == tx['id']
                              ? DropdownButton<String>(
                                  value: editType,
                                  items: const [
                                    DropdownMenuItem(value: 'add', child: Text('إضافة')),
                                    DropdownMenuItem(value: 'withdraw', child: Text('سحب')),
                                  ],
                                  onChanged: (val) => setState(() => editType = val!),
                                )
                              : Text(tx['type'] == 'add' ? 'إضافة' : 'سحب'),
                          subtitle: editId == tx['id']
                              ? TextField(
                                  keyboardType: TextInputType.number,
                                  controller: TextEditingController(text: editQuantity),
                                  onChanged: (val) => editQuantity = val,
                                )
                              : Text('الكمية: ${tx['quantity']} - ${tx['created_at'] ?? '—'}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: editId == tx['id']
                                ? [
                                    IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => saveEdit(tx['id'])),
                                    IconButton(icon: const Icon(Icons.close, color: Colors.grey), onPressed: () => setState(() => editId = null)),
                                  ]
                                : [
                                    IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () {
                                      setState(() {
                                        editId = tx['id'];
                                        editType = tx['type'];
                                        editQuantity = tx['quantity'].toString();
                                      });
                                    }),
                                    IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => deleteTx(tx['id'])),
                                  ],
                          ),
                        ),
                      ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropdownButton<String>(
                          value: newType,
                          items: const [
                            DropdownMenuItem(value: 'add', child: Text('إضافة')),
                            DropdownMenuItem(value: 'withdraw', child: Text('سحب')),
                          ],
                          onChanged: (val) => setState(() => newType = val!),
                        ),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: TextEditingController(text: newQuantity),
                            onChanged: (val) => newQuantity = val,
                            decoration: const InputDecoration(hintText: 'الكمية'),
                          ),
                        ),
                        ElevatedButton(onPressed: addTransaction, child: const Text('إضافة العملية')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('الكمية الحالية: $netQuantity'),
          ],
        ),
      ),
    );
  }
}
