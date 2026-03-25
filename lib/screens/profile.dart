import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'id_card.dart';

class ProfileScreen extends StatelessWidget {

  final UserModel user;

  const ProfileScreen({super.key, required this.user});

  void openIdCard(BuildContext context) {

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const IdCardScreen();
      },
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Миний бичиг баримт"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            GestureDetector(
              onTap: () => openIdCard(context),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/idcard.png",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}