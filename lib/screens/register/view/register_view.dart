import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_bloc.dart';
import 'widgets/register_email_field.dart';
import 'widgets/register_password_field.dart';
import 'widgets/register_confirm_password_field.dart';
import 'widgets/register_submit_button.dart';
import 'widgets/register_title.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration successful!')),
            );
          }
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.green[50],
            appBar: AppBar(
              title: const Text('Register'),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const RegisterTitle(),
                      const SizedBox(height: 32),
                      const RegisterEmailField(),
                      const SizedBox(height: 16),
                      const RegisterPasswordField(),
                      const SizedBox(height: 16),
                      const RegisterConfirmPasswordField(),
                      const SizedBox(height: 24),
                      RegisterSubmitButton(formKey: _formKey),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
