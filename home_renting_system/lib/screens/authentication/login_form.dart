import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home/router.dart';
import 'package:go_router/go_router.dart';
import '../../generated/l10n.dart'; // Make sure your generated localization file is imported
import '../../main.dart';
import 'package:provider/provider.dart';
import 'package:home_renting_system/providers/user_provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _loading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    if (mounted) setState(() => _loading = true);

    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final uid = userCredential.user!.uid;

      // ✅ Fetch role via provider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final role = await userProvider.fetchUserRole(uid) ?? 'unknown';

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).loggedInAs(role))),
      );

      // ✅ Navigate based on role
      if (role == 'student') {
        context.go('/student');
      } else if (role == 'landlord') {
        context.go('/landlord');
      } else {
        context.go('/unauthorized');
      }

    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${S.of(context).loginError} ${e.message}")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).somethingWentWrong)),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            S.of(context).login,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration(S.of(context).yourEmail),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).pleaseEnterEmail;
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return S.of(context).enterValidEmail;
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: _passwordController,
              style: const TextStyle(color: Colors.white),
              obscureText: _obscurePassword,
              decoration: _inputDecoration(S.of(context).yourPassword),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).pleaseEnterPassword;
                }
                if (value.length < 8) {
                  return S.of(context).min8Chars;
                }
                if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  return S.of(context).mustContainUppercase;
                }
                if (!RegExp(r'[0-9]').hasMatch(value)) {
                  return S.of(context).mustContainNumber;
                }
                if (!RegExp(r'[!@#\$&*~.]').hasMatch(value)) {
                  return S.of(context).mustContainSpecialChar;
                }
                if (RegExp(r'\s').hasMatch(value)) {
                  return S.of(context).mustNotContainSpaces;
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loading ? null : _login,
            child: _loading ? const CircularProgressIndicator() : Text(S.of(context).login),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => MyApp.of(context)?.setLocale(const Locale('fr')),
                child: const Text('FR'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => MyApp.of(context)?.setLocale(const Locale('de')),
                child: const Text('DE'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => MyApp.of(context)?.setLocale(const Locale('en')),
                child: const Text('EN'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.black54,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
