import 'package:flutter/material.dart';

class CategoryListTile extends StatelessWidget {
  final Map<String, dynamic> category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CategoryListTile({
    super.key,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category['name']),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
          IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
        ],
      ),
    );
  }
}
