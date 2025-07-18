import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_manager/screens/tasks_list/bloc/categories_bloc.dart';
import 'package:tasks_manager/screens/tasks_list/view/category_manager_view.dart';

class TaskCategoryDropdown extends StatelessWidget {
  final String? selectedCategoryId;
  final ValueChanged<String?> onChanged;

  const TaskCategoryDropdown({
    super.key,
    required this.selectedCategoryId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoaded) {
          final categories = state.categories;
          return Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedCategoryId,
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                  ),
                  items: categories
                      .map(
                        (cat) => DropdownMenuItem<String>(
                          value: cat['id'] as String,
                          child: Text(cat['name'] as String),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                  validator: (v) =>
                      v == null ? 'Selecione uma categoria' : null,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Gerenciar categorias',
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoryManagerView(),
                    ),
                  );
                },
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
