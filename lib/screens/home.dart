
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/user_model.dart';
import 'id_card.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> services = [
    {"icon": Icons.help_outline, "title": "Санал асуулга"},
    {"icon": Icons.account_balance, "title": "“Чингис Хаан” Үндэсний Баялгийн Сан"},
    {"icon": Icons.security, "title": "Нийгмийн даатгалын мэдээлэл"},
    {"icon": Icons.account_balance_wallet, "title": "Зээлийн мэдээлэл"},
    {"icon": Icons.medical_services, "title": "Эрүүл мэндийн даатгал төлөлтийн мэдээлэл"},
    {"icon": Icons.badge, "title": "Иргэний бүртгэлийн мэдээлэл"},
    {"icon": Icons.location_on, "title": "Хаягийн өөрчлөлтийн мэдээлэл"},
    {"icon": Icons.favorite, "title": "Гэрлэлтийн мэдээлэл"},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const IdCardScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset("assets/logo.png", height: 30),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.blue, size: 28),
          SizedBox(width: 16),
          Icon(Icons.menu, color: Colors.blue, size: 28),
          SizedBox(width: 16),
        ],
      ),

      /// BODY
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Миний бичиг баримтууд",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Төрд байгаа миний мэдээлэл",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// SERVICE LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: services.length,
              itemBuilder: (_, i) {
                return Container(
                  height: 70,
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: const Color(0xffBBD7F5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [

                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xffE9F3FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          services[i]["icon"],
                          color: const Color(0xff2F80ED),
                          size: 24,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Text(
                          services[i]["title"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff2D3A4A),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      /// QR BUTTON
      floatingActionButton: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [
              Color(0xff3DA0FF),
              Color(0xff1976D2),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 14,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
          size: 32,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /// BOTTOM NAV
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              _navItem(Icons.home, "Нүүр", 0),
              _navItem(Icons.grid_view, "Үйлчилгээ", 1),

              const SizedBox(width: 40),

              _navItem(Icons.chat_bubble_outline, "Чат", 2),
              _navItem(Icons.person_outline, "Профайл", 3),

            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            color: _selectedIndex == index ? Colors.blue : Colors.grey,
            size: 26,
          ),

          const SizedBox(height: 4),

          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

