import 'package:flutter/material.dart';

class ResgiterForm extends StatefulWidget {
  const ResgiterForm({super.key});

  @override
  State<ResgiterForm> createState() => _ResgiterFormState();
}

class _ResgiterFormState extends State<ResgiterForm> {
  final _formKey = GlobalKey<FormState>(); // For validation

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email TextField
          // Password TextField
          // Resgiter Button
        ],
      ),
    );
  }
}
