import 'package:flutter/material.dart';

class LoginPasswordField extends StatelessWidget {
  final TextEditingController controller;
  const LoginPasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Senha',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      validator: (value) => value != null && value.length >= 6
          ? null
          : 'Senha mínima de 6 caracteres',
    );
  }
}
