import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}

// ==================== 1. صفحة تسجيل الدخول ====================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<String> validSecretCodes = [
    "KING-2026",
    "SAUD-7911-2026-KNG",
    "ADD-2669-0330-FWR",
    "KNG-VIP-1001",
    "KNG-BARBER-1002",
  ];

  void _login() {
    String enteredPhone = phoneController.text.trim();
    String enteredPassword = passwordController.text.trim();

    if (enteredPhone.isEmpty || enteredPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال رقم الهاتف والرمز السري')),
      );
      return;
    }

    if (validSecretCodes.contains(enteredPassword) || enteredPassword == "1234") {
      String defaultName = (enteredPhone == "07805567911") ? "سعود فيصل" : "حلاق الملوك VIP";

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => KingsBarbershopApp(
            initialName: defaultName,
            initialPhone: enteredPhone,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرمز السري غير صحيح!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F17),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              color: const Color(0xFF161E2E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFD4AF37),
                      ),
                      child: const Icon(Icons.content_cut_rounded, size: 42, color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "تسجيل الدخول - حلاقة الملوك VIP",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 28),
                    TextField(
                      controller: phoneController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "رقم الهاتف",
                        labelStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(Icons.phone_android, color: Color(0xFFD4AF37)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFD4AF37)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "الرمز السري",
                        labelStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFD4AF37)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFD4AF37)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: _login,
                        child: const Text(
                          "تسجيل الدخول",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
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

// ==================== 2. الواجهة الرئيسية ====================
class KingsBarbershopApp extends StatefulWidget {
  final String initialName;
  final String initialPhone;

  const KingsBarbershopApp({
    super.key,
    required this.initialName,
    required this.initialPhone,
  });

  @override
  State<KingsBarbershopApp> createState() => _KingsBarbershopAppState();
}

class _KingsBarbershopAppState extends State<KingsBarbershopApp> {
  int _currentIndex = 0;
  bool isDarkMode = true;

  late String userName;
  late String userPhone;

  List<Map<String, dynamic>> solfaGroups = [];
  List<Map<String, dynamic>> dailyIncomes = [];
  List<Map<String, dynamic>> bookings = [];

  @override
  void initState() {
    super.initState();
    userName = widget.initialName;
    userPhone = widget.initialPhone;
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = isDarkMode ? const Color(0xFF0B0F17) : const Color(0xFFF1F5F9);
    Color cardColor = isDarkMode ? const Color(0xFF161E2E) : Colors.white;
    Color textColor = isDarkMode ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text("حلاقة الملوك VIP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: isDarkMode ? "الوضع الشمسي" : "الوضع الداكن",
            icon: Icon(
              isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: isDarkMode ? const Color(0xFFFFD700) : Colors.white,
            ),
            onPressed: () => setState(() => isDarkMode = !isDarkMode),
          )
        ],
      ),
      backgroundColor: bgColor,
      body: _buildCurrentPage(cardColor, textColor),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFD4AF37),
        unselectedItemColor: Colors.grey,
        backgroundColor: isDarkMode ? const Color(0xFF161E2E) : Colors.white,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'السُلف'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'الحجز'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الحساب والمالية'),
        ],
      ),
    );
  }

  Widget _buildCurrentPage(Color cardColor, Color textColor) {
    switch (_currentIndex) {
      case 0:
        return _buildSolfaPage(cardColor, textColor);
      case 1:
        return _buildBookingPage(cardColor, textColor);
      case 2:
        return _buildAccountPage(cardColor, textColor);
      default:
        return _buildSolfaPage(cardColor, textColor);
    }
  }

  // ================= 1. قسم السُلف مع جدول تم/لم يتم الدفع =================
  Widget _buildSolfaPage(Color cardColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("قسم السُلف", style: TextStyle(fontSize: 20, color: textColor, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                onPressed: _showCreateSolfaFolderDialog,
                icon: const Icon(Icons.create_new_folder, color: Colors.black),
                label: const Text("إنشاء ملف سُلفة", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: solfaGroups.isEmpty
                ? const Center(
                    child: Text(
                      "لا توجد ملفات سُلف حالياً.\nاضغط على (إنشاء ملف سُلفة) للبدء.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: solfaGroups.length,
                    itemBuilder: (context, index) {
                      final group = solfaGroups[index];
                      final members = group['members'] as List;

                      return Card(
                        color: cardColor,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ExpansionTile(
                          iconColor: const Color(0xFFD4AF37),
                          title: Text("📁 ${group['title']}", style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18)),
                          subtitle: Text("المبلغ الإجمالي: ${group['amount']} د.ع | المشتركين: ${members.length}", style: const TextStyle(color: Colors.grey)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                                      onPressed: () => _showAddMemberDialog(group),
                                      icon: const Icon(Icons.person_add, color: Colors.black, size: 18),
                                      label: const Text("إضافة مشترك", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  members.isEmpty
                                      ? const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text("لا يوجد مشتركون في هذه السُلفة بعد.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                            headingRowColor: WidgetStateProperty.all(const Color(0xFF1E293B)),
                                            columns: const [
                                              DataColumn(label: Text("اسم المشترك", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold))),
                                              DataColumn(label: Text("رقم الهاتف", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold))),
                                              DataColumn(label: Text("حالة الدفع", style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold))),
                                            ],
                                            rows: members.map<DataRow>((m) {
                                              bool paid = m['paid'] ?? false;
                                              return DataRow(
                                                cells: [
                                                  DataCell(Text(m['name'], style: TextStyle(color: textColor, fontWeight: FontWeight.bold))),
                                                  DataCell(Text(m['phone'], style: const TextStyle(color: Colors.grey))),
                                                  DataCell(
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          m['paid'] = !paid;
                                                        });
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                        decoration: BoxDecoration(
                                                          color: paid ? Colors.green.withOpacity(0.2) : Colors.redAccent.withOpacity(0.2),
                                                          border: Border.all(color: paid ? Colors.green : Colors.redAccent),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Text(
                                                          paid ? "تم الدفع ✅" : "لم يتم الدفع ❌",
                                                          style: TextStyle(
                                                            color: paid ? Colors.green : Colors.redAccent,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  // نافذة إنشاء ملف سُلفة جديد
  void _showCreateSolfaFolderDialog() {
    final titleCtrl = TextEditingController();
    final amountCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("إنشاء ملف سُلفة جديد"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: "اسم السُلفة (مثال: سُلفة تشرين)")),
            TextField(controller: amountCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "المبلغ الإجمالي")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("إلغاء")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
            onPressed: () {
              if (titleCtrl.text.isNotEmpty) {
                setState(() {
                  solfaGroups.add({
                    "title": titleCtrl.text,
                    "amount": double.tryParse(amountCtrl.text) ?? 0,
                    "members": []
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text("حفظ الملف", style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }

  // نافذة إضافة مشترك (اسم ورقم هاتف فقط بدون خيار الدفع)
  void _showAddMemberDialog(Map<String, dynamic> group) {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("إضافة مشترك - ${group['title']}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "اسم المشترك")),
            TextField(controller: phoneCtrl, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "رقم الهاتف")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("إلغاء")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                setState(() {
                  (group['members'] as List).add({
                    "name": nameCtrl.text,
                    "phone": phoneCtrl.text,
                    "paid": false, // القيمة الافتراضية عند الإضافة هي "لم يتم الدفع"
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text("إضافة المشترك", style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }

  // ================= 2. قسم الحجز والجدول =================
  Widget _buildBookingPage(Color cardColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("جدول الحجوزات", style: TextStyle(fontSize: 20, color: textColor, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                onPressed: _showAddBookingDialog,
                icon: const Icon(Icons.person_add_alt_1, color: Colors.black),
                label: const Text("إضافة زبون", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: bookings.isEmpty
                ? const Center(
                    child: Text(
                      "لا توجد حجوزات حتي الآن.\nاضغط على زر (إضافة زبون) لتسجيل حجز جديد.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final item = bookings[index];
                      return Card(
                        color: cardColor,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item['name'], style: TextStyle(fontSize: 18, color: textColor, fontWeight: FontWeight.bold)),
                                  Text(item['status'], style: TextStyle(color: _getStatusColor(item['status']), fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text("📱 الهاتف: ${item['phone']}", style: const TextStyle(color: Colors.grey)),
                              Text("⏰ الوقت: ${item['time']}", style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                              const Divider(color: Colors.grey),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.check_circle, color: Colors.green),
                                    onPressed: () => setState(() => item['status'] = "تمت الحلاقة"),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.access_time_filled, color: Colors.orange),
                                    onPressed: () => setState(() => item['status'] = "تأجلت"),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.cancel, color: Colors.red),
                                    onPressed: () => setState(() => item['status'] = "تم الرفض"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status == "تمت الحلاقة") return Colors.green;
    if (status == "تأجلت") return Colors.orange;
    if (status == "تم الرفض") return Colors.red;
    return Colors.blue;
  }

  void _showAddBookingDialog() {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final timeCtrl = TextEditingController(text: "5-30 العصر");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("إضافة زبون جديد"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "اسم الزبون")),
            TextField(controller: phoneCtrl, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "رقم هاتف الزبون")),
            TextField(controller: timeCtrl, decoration: const InputDecoration(labelText: "الوقت (مثال: 5-30 العصر)")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("إلغاء")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                setState(() {
                  bookings.add({
                    "name": nameCtrl.text,
                    "phone": phoneCtrl.text,
                    "time": timeCtrl.text,
                    "status": "قيد الانتظار"
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text("حفظ الحجز", style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }

  // ================= 3. قسم الحساب والمالية =================
  Widget _buildAccountPage(Color cardColor, Color textColor) {
    double totalIncome = dailyIncomes.fold(0, (sum, item) => sum + (item['amount'] as double));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xFFD4AF37),
                    child: Icon(Icons.person, size: 40, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(userName, style: TextStyle(fontSize: 20, color: textColor, fontWeight: FontWeight.bold)),
                  Text(userPhone, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: _showEditAccountDialog,
                        child: const Text("تعديل الاسم/الهاتف", style: TextStyle(color: Color(0xFFD4AF37))),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text("تسجيل الخروج", style: TextStyle(color: Colors.white)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      const Text("الحجوزات", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text("${bookings.length}", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      const Text("السُلف", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text("${solfaGroups.length}", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      const Text("إجمالي الدخل", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text("${totalIncome.toStringAsFixed(0)}", style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => _openFinancialFileModal(cardColor, textColor),
              icon: const Icon(Icons.folder_special, color: Colors.black, size: 28),
              label: const Text(
                "ملف المالية والتقارير",
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openFinancialFileModal(Color cardColor, Color textColor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          double total = dailyIncomes.fold(0, (sum, item) => sum + (item['amount'] as double));

          return Container(
            padding: const EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("📁 ملف المالية اليومية", style: TextStyle(fontSize: 20, color: textColor, fontWeight: FontWeight.bold)),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                      onPressed: () => _showAddIncomeDialog(setModalState),
                      icon: const Icon(Icons.add, color: Colors.black, size: 20),
                      label: const Text("إضافة دخلك المالي", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const Divider(color: Colors.grey),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("المجموع الإجمالي للدخل:", style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("${total.toStringAsFixed(0)} د.ع", style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text("سجل الدخل المالي المضاف:", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: dailyIncomes.isEmpty
                      ? const Center(
                          child: Text("لا يوجد دخل مالي مضاف حالياً.\nاضغط على زر (إضافة دخلك المالي) للتسجيل.",
                              textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                        )
                      : ListView.builder(
                          itemCount: dailyIncomes.length,
                          itemBuilder: (context, idx) {
                            final item = dailyIncomes[idx];
                            return Card(
                              color: isDarkMode ? const Color(0xFF0B0F17) : const Color(0xFFF8FAFC),
                              child: ListTile(
                                leading: const Icon(Icons.monetization_on, color: Colors.green),
                                title: Text("${item['day']} - ${item['date']}", style: TextStyle(color: textColor)),
                                trailing: Text("${item['amount']} د.ع", style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEditAccountDialog() {
    final nameCtrl = TextEditingController(text: userName);
    final phoneCtrl = TextEditingController(text: userPhone);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("تعديل الحساب"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "تغيير اسم المستخدم")),
            TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: "تعديل رقم الهاتف")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("إلغاء")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = nameCtrl.text;
                userPhone = phoneCtrl.text;
              });
              Navigator.pop(ctx);
            },
            child: const Text("حفظ"),
          )
        ],
      ),
    );
  }

  void _showAddIncomeDialog(StateSetter updateModalState) {
    final amountCtrl = TextEditingController();
    final dayCtrl = TextEditingController(text: "اليوم");
    final dateCtrl = TextEditingController(text: "2026-10-01");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("إضافة دخلك المالي"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: dayCtrl, decoration: const InputDecoration(labelText: "اليوم (مثال: الخميس)")),
            TextField(controller: dateCtrl, decoration: const InputDecoration(labelText: "التاريخ (مثال: 2026-10-01)")),
            TextField(controller: amountCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "الدخل المالي (د.ع)")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("إلغاء")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
            onPressed: () {
              double val = double.tryParse(amountCtrl.text) ?? 0;
              if (val > 0) {
                setState(() {
                  dailyIncomes.insert(0, {
                    "day": dayCtrl.text,
                    "date": dateCtrl.text,
                    "amount": val,
                  });
                });
                updateModalState(() {});
                Navigator.pop(ctx);
              }
            },
            child: const Text("تسجيل", style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}
