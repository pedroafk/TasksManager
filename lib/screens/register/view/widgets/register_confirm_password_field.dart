import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/register_bloc.dart';

class RegisterConfirmPasswordField extends StatelessWidget {
  const RegisterConfirmPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Confirm Password',
        prefixIcon: Icon(Icons.lock_outline),
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      onChanged: (value) => context.read<RegisterBloc>().add(
        RegisterConfirmPasswordChanged(value),
      ),
      validator: (value) => value == context.read<RegisterBloc>().state.password
          ? null
          : 'Passwords do not match.',
    );
  }
}
