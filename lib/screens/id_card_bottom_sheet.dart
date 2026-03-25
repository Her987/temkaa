import 'dart:math';
import 'package:flutter/material.dart';

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
      height: MediaQuery.of(context).size.height * 0.80,
      padding: const EdgeInsets.all(20),

      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),

      child: Column(
        children: [

          /// drag bar
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
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          /// CARD
          GestureDetector(
            onTap: flipCard,

            child: SizedBox(
              height: 220,
              width: double.infinity,

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
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/id_zurag.jpg",
                              fit: BoxFit.cover,
                            ),
                          )
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                "assets/id_back.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// BUTTON ROW (яг зураг шиг)
          Row(
            children: [

              Expanded(
                child: SizedBox(
                  height: 55,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),

                    onPressed: () {},

                    child: const Text(
                      "Дахин захиалах",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// flip button
              SizedBox(
                height: 55,
                width: 55,

                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: flipCard,

                  child: const Icon(Icons.sync),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// close
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },

            child: const Text(
              "Хаах",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}