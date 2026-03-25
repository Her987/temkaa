
import 'dart:math';
import 'package:flutter/material.dart';

class IdCardScreen extends StatefulWidget {
  const IdCardScreen({super.key});

  @override
  State<IdCardScreen> createState() => _IdCardScreenState();
}

class _IdCardScreenState extends State<IdCardScreen> {

  final List<Map<String, dynamic>> services = [
    {"icon": Icons.help_outline, "title": "Санал асуулга"},
    {"icon": Icons.account_balance, "title": "“Чингис Хаан” Үндэсний Баялгийн Сан"},
    {"icon": Icons.security, "title": "Нийгмийн даатгалын мэдээлэл"},
    {"icon": Icons.account_balance_wallet, "title": "Зээлийн мэдээлэл"},
    {"icon": Icons.medical_services, "title": "Эрүүл мэндийн даатгал төлөлтийн мэдээлэл"},
    {"icon": Icons.badge, "title": "Иргэний бүртгэлийн мэдээлэл"},
    {"icon": Icons.location_on, "title": "Хаягийн өөрчлөлтийн мэдээлэл"},
  ];

  void openIdCard() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const IdCardBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: Image.asset("assets/logo.png", height: 28),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.blue, size: 28),
          SizedBox(width: 16),
          Icon(Icons.menu, color: Colors.blue, size: 28),
          SizedBox(width: 16),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Миний бичиг баримтууд",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 14),

            /// ID CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: openIdCard,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    "assets/id_zurag.jpg",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Төрд байгаа миний мэдээлэл",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                    border: Border.all(color: const Color(0xffBBD7F5)),
                  ),

                  child: Row(
                    children: [

                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffE9F3FF),
                              Color(0xffDCEBFF),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          services[i]["icon"],
                          color: const Color(0xff2F80ED),
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Text(
                          services[i]["title"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/// BOTTOM SHEET
class IdCardBottomSheet extends StatefulWidget {
  const IdCardBottomSheet({super.key});

  @override
  State<IdCardBottomSheet> createState() => _IdCardBottomSheetState();
}

class _IdCardBottomSheetState extends State<IdCardBottomSheet>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  bool isFront = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  void flipCard() {

    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    setState(() {
      isFront = !isFront;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(20),

      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),

      child: Column(
        children: [

          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            "Иргэний үнэмлэх",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          /// ЗАСАГДСАН CARD
          GestureDetector(
            onTap: flipCard,
            child: AspectRatio(
              aspectRatio: 1.6,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {

                  final angle = _controller.value * pi;

                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),

                    child: angle <= pi / 2
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              "assets/id_zurag.jpg",
                              fit: BoxFit.contain,
                            ),
                          )
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/id_back.jpg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
          ),

          const Spacer(),

          Row(
            children: [

              Expanded(
                child: SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Дахин захиалах",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              GestureDetector(
                onTap: flipCard,
                child: Container(
                  height: 55,
                  width: 85,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffEEF5FF),
                        Color(0xffE3EEFF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: const Color(0xff7AA7E8),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.sync_alt,
                    color: Color(0xff2F6BFF),
                    size: 28,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Хаах",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
