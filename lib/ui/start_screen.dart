import 'package:flutter/material.dart';
import 'package:photo_sharing_app/ui/new_post_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewPostScreen()));
          },
          child: Text(
            'Start',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(
              Color(0xFF7B2CBF),
            ),
            foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            elevation: WidgetStatePropertyAll(6),
            shadowColor: WidgetStatePropertyAll(Colors.purple.shade200),
          ),
        ),
      ),
    );
  }
}
