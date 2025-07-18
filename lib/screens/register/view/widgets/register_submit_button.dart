import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/register_bloc.dart';

class RegisterSubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const RegisterSubmitButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RegisterBloc>().state;
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.person_add),
        label: state.isSubmitting
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text('Cadastrar'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 18),
        ),
        onPressed: state.isFormValid && !state.isSubmitting
            ? () {
                if (formKey.currentState!.validate()) {
                  context.read<RegisterBloc>().add(RegisterSubmitted());
                }
              }
            : null,
      ),
    );
  }
}
