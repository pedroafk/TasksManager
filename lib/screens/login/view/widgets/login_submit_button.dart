import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/login_bloc.dart';

class LoginSubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginSubmitButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state;
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: state is LoginLoading
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed:
                  (emailController.text.contains('@') &&
                      passwordController.text.length >= 6 &&
                      state is! LoginLoading)
                  ? () {
                      if (formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(
                          LoginSubmitted(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      }
                    }
                  : null,
            ),
    );
  }
}
