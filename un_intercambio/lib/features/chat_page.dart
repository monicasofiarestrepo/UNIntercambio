import 'package:flutter/material.dart';
import 'package:un_intercambio/features/widgets/bottom_nav_bar.dart';

class ChatPage extends StatelessWidget {
  final String title;
  
  const ChatPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"), 
                fit: BoxFit.contain,
              ),
            ),
          ),

          Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
