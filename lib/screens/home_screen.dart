import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatbotapp/reusable_widgets/appbar_widget.dart';
import 'package:flutterchatbotapp/reusable_widgets/chatbot_widget.dart';
import 'package:flutterchatbotapp/screens/chatbot_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_Widget(
        title:
            "Welcome ${FirebaseAuth.instance.currentUser!.displayName.toString()}",
        enableBack: false,
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/background_image.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                child: Text(
                  'Start Chatbot',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black.withOpacity(0.5),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatbotScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// sahil@example.com
// sahil@123