import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/register_bloc.dart';

class RegisterPasswordField extends StatelessWidget {
  const RegisterPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Senha',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      onChanged: (value) =>
          context.read<RegisterBloc>().add(RegisterPasswordChanged(value)),
      validator: (value) => value != null && value.length >= 6
          ? null
          : 'Senha mínima de 6 caracteres',
    );
  }
}
