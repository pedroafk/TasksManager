import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onConfirmLogout;
  const LogoutButton({super.key, required this.onConfirmLogout});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Logout',
      onPressed: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text('Logout'),
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
