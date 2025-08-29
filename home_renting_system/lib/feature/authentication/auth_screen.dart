import 'package:flutter/material.dart'; // Import Flutter's material design package

// This is the main StatefulWidget for the Login screen
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.title = 'Authentication Page'}); // Constructor with optional title

  final String title; // Title of the page, shown in the AppBar

  @override
  State<AuthScreen> createState() => _AuthScreenState(); // Creates the state for this widget
}

// This is the state class for AuthScreen
class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the basic visual layout structure
      appBar: AppBar(
        // AppBar is the top bar of the screen
        title: Text(widget.title), // Displays the title passed to the widget
      ),
      body: const Center(
        // Center aligns its child in the middle of the screen
        child: _isLogin ? LoginForm() : RegisterForm(), // Empty placeholder, does nothing
      ),
      // If you want to add a button or action later, you can add it here
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // TODO: Add action here
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
