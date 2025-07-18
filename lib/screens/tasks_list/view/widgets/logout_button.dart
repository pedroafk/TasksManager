import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onConfirmLogout;
  const LogoutButton({super.key, required this.onConfirmLogout});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Sair',
      onPressed: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Sair'),
            content: const Text('Tem certeza que deseja sair?'),
            actions: [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text('Sim'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        );
        if (confirmed == true) {
          onConfirmLogout();
        }
      },
    );
  }
}
