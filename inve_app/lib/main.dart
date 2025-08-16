import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'SearchItems.dart';   // صفحة البحث
import 'item.dart';          // صفحة الإضافة (ItemManagerPage)

const String API_BASE = 'http://100.70.131.12:5000';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
    );
  }
}

// ------------------ شاشة تسجيل الدخول ------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool loading = false;
  String? error;

  Future<void> _login() async {
    final u = _username.text.trim();
    final p = _password.text.trim();
    if (u.isEmpty || p.isEmpty) {
      setState(() => error = 'ادخل اسم المستخدم وكلمة المرور');
      return;
    }
    setState(() { loading = true; error = null; });

    try {
      final res = await http.post(
        Uri.parse('$API_BASE/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': u, 'password': p}),
      );

      if (res.statusCode == 200 || res.statusCode == 401) {
        final data = jsonDecode(res.body);
        if (data['success'] == true) {
          final role = data['user']['role'] as String;
          if (!mounted) return;
          if (role == 'admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AdminHomePage()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => SearchItemsScreen()),
            );
          }
        } else {
          setState(() => error = data['error']?.toString() ?? 'بيانات غير صحيحة');
        }
      } else {
        setState(() => error = 'فشل الاتصال (${res.statusCode})');
      }
    } catch (e) {
      setState(() => error = 'مشكلة في الاتصال: $e');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('تسجيل الدخول', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _username,
                      decoration: InputDecoration(
                        labelText: 'اسم المستخدم',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (error != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(error!, textAlign: TextAlign.center),
                      ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: loading ? null : _login,
                        child: loading
                            ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('دخول', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      ),
                      child: const Text('ما عندك حساب؟ تسجيل جديد'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------ صفحة الأدمن ------------------
class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentIndex = 0;

  final pages = [
    SearchItemsScreen(),
    ItemManagerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('نظام إدارة المخزون')),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'البحث'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'إضافة'),
          ],
        ),
      ),
    );
  }
}

// ------------------ شاشة تسجيل جديد ------------------
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  String role = 'user';
  bool loading = false;
  String? msg;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _register() async {
    final e = _email.text.trim();
    final u = _username.text.trim();
    final p = _password.text.trim();
    final cp = _confirmPassword.text.trim();

    if (e.isEmpty || u.isEmpty || p.isEmpty || cp.isEmpty) {
      setState(() => msg = 'جميع الحقول مطلوبة');
      return;
    }

    if (!_isValidEmail(e)) {
      setState(() => msg = 'صيغة الإيميل غير صحيحة');
      return;
    }

    if (p != cp) {
      setState(() => msg = 'كلمة المرور وتأكيدها غير متطابقين');
      return;
    }

    setState(() { loading = true; msg = null; });

    try {
      final res = await http.post(
        Uri.parse('$API_BASE/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': e, 'username': u, 'password': p, 'role': role}),
      );

      if (res.statusCode == 200) {
        setState(() => msg = 'تم التسجيل بنجاح. ارجع لتسجيل الدخول.');
      } else if (res.statusCode == 409) {
        setState(() => msg = 'اسم المستخدم أو الإيميل موجود بالفعل');
      } else {
        setState(() => msg = 'فشل التسجيل (${res.statusCode})');
      }
    } catch (err) {
      setState(() => msg = 'مشكلة في الاتصال: $err');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('تسجيل جديد', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: 'الإيميل',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _username,
                      decoration: InputDecoration(
                        labelText: 'اسم المستخدم',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _confirmPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'تأكيد كلمة المرور',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (msg != null)
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(msg!, textAlign: TextAlign.center),
                      ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: loading ? null : _register,
                        child: loading
                            ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('تسجيل', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('رجوع لتسجيل الدخول'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
