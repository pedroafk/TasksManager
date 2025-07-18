import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/register_bloc.dart';

class RegisterEmailField extends StatelessWidget {
  const RegisterEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'E-mail',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) =>
          context.read<RegisterBloc>().add(RegisterEmailChanged(value)),
      validator: (value) => value != null && value.contains('@')
          ? null
          : 'Enter a valid email address.',
    );
  }
}
