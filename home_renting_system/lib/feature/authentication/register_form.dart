import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import '../../main.dart'; // Needed for MyApp.of(context)?.setLocale
import '../../generated/l10n.dart'; // Your generated localization file
import 'package:provider/provider.dart';
import 'package:home_renting_system/providers/user_provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _obscurePassword = true;
  String _role = "student";
  bool _loading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text.trim() != _confirmController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).passwordsDoNotMatch)),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save extra info in Firestore

      await userProvider.saveUser(
        uid: userCredential.user!.uid,
        email: _emailController.text.trim(),
        role: _role,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).registeredAs(_role))),
      );

      // Navigate using GoRouter
      if (_role == "student") {
        context.go('/student-home');
      } else if (_role == "landlord") {
        context.go('/landlord-home');
      }

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ ${e.message}")),
      );
    } finally {
      setState(() => _loading = false);
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
            S.of(context).register,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          _buildInput(S.of(context).yourEmail, _emailController, false),
          const SizedBox(height: 16),
          _buildInput(S.of(context).yourPassword, _passwordController, true),
          const SizedBox(height: 16),
          _buildInput(S.of(context).confirmYourPassword, _confirmController, true),
          const SizedBox(height: 16),
          _buildRoleSelector(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loading ? null : _register,
            child: _loading ? const CircularProgressIndicator() : Text(S.of(context).register),
          ),
          const SizedBox(height: 20),
          // Language switcher buttons
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

  Widget _buildInput(String label, TextEditingController controller, bool obscure) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        obscureText: obscure ? _obscurePassword : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black54,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (label == S.of(context).yourEmail) return S.of(context).enterEmail;
            if (label == S.of(context).yourPassword) return S.of(context).enterPassword;
            if (label == S.of(context).confirmYourPassword) return S.of(context).enterConfirmPassword;
          }

          if (label == S.of(context).yourEmail) {
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value?.trim() ?? '')) return S.of(context).enterValidEmail;
          }

          if (label == S.of(context).yourPassword && label != S.of(context).confirmYourPassword) {
            final pwd = value ?? '';
            if (pwd.length < 8) return S.of(context).min8Chars;
            if (!RegExp(r'[A-Z]').hasMatch(pwd)) return S.of(context).mustContainUppercase;
            if (!RegExp(r'[0-9]').hasMatch(pwd)) return S.of(context).mustContainNumber;
            if (!RegExp(r'[!@#\$&*~.]').hasMatch(pwd)) return S.of(context).mustContainSpecialChar;
            if (RegExp(r'\s').hasMatch(pwd)) return S.of(context).mustNotContainSpaces;
          }

          return null;
        },
      ),
    );
  }

  Widget _buildRoleSelector() {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: Text(S.of(context).student, style: const TextStyle(color: Colors.white)),
            value: "student",
            groupValue: _role,
            activeColor: Colors.white,
            onChanged: (value) => setState(() => _role = value!),
          ),
          RadioListTile<String>(
            title: Text(S.of(context).landlord, style: const TextStyle(color: Colors.white)),
            value: "landlord",
            groupValue: _role,
            activeColor: Colors.white,
            onChanged: (value) => setState(() => _role = value!),
          ),
        ],
      ),
    );
  }
}
