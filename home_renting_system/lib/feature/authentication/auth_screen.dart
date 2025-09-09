import 'package:flutter/material.dart';
import 'login_form.dart';
import 'register_form.dart';
import '../../generated/l10n.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.title = 'Authentication Page'});

  final String title;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            _isLogin ? LoginForm() : RegisterForm(),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin ? S.of(context).goToRegister : S.of(context).goToLogin),
            ),
          ]
        )
      ),
    );
  }
}
