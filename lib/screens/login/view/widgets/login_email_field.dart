import 'package:flutter/material.dart';

class LoginEmailField extends StatelessWidget {
  final TextEditingController controller;
  const LoginEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'E-mail',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => value != null && value.contains('@')
          ? null
          : 'Enter a valid email address.',
    );
  }
}
