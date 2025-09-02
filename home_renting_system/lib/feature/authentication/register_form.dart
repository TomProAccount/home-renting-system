import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        const SnackBar(content: Text("❌ Passwords don’t match")),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save extra info in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': _emailController.text.trim(),
        'role': _role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Registered as $_role")),
      );

      // Optional: navigate to home screen
      // Navigator.pushReplacement(...);

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
          const Text(
            "Register",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          _buildInput("Your Email", _emailController, false),
          const SizedBox(height: 16),
          _buildInput("Your Password", _passwordController, true),
          const SizedBox(height: 16),
          _buildInput("Confirm Your Password", _confirmController, true),
          const SizedBox(height: 16),
          _buildRoleSelector(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loading ? null : _register,
            child: _loading ? const CircularProgressIndicator() : const Text("Register"),
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
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
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
            title: const Text("Student", style: TextStyle(color: Colors.white)),
            value: "student",
            groupValue: _role,
            activeColor: Colors.white,
            onChanged: (value) => setState(() => _role = value!),
          ),
          RadioListTile<String>(
            title: const Text("Landlord", style: TextStyle(color: Colors.white)),
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
