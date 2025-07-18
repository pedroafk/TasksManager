import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/categories_bloc.dart';
import 'widgets/category_add_field.dart';
import 'widgets/category_list_tile.dart';

class CategoryManagerView extends StatefulWidget {
  const CategoryManagerView({super.key});

  @override
  State<CategoryManagerView> createState() => _CategoryManagerViewState();
}

class _CategoryManagerViewState extends State<CategoryManagerView> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Categories')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CategoryAddField(
              controller: _controller,
              onAdd: () {
                if (_controller.text.trim().isNotEmpty) {
                  context.read<CategoriesBloc>().add(
                    AddCategory(_controller.text.trim()),
                  );
                  _controller.clear();
                }
              },
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CategoriesLoaded) {
                    if (state.categories.isEmpty) {
                      return const Center(
                        child: Text('No categories available.'),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final cat = state.categories[index];
                        return CategoryListTile(
                          category: cat,
                          onEdit: () async {
                            final newName = await showDialog<String>(
                              context: context,
                              builder: (context) {
                                final editController = TextEditingController(
                                  text: cat['name'],
                                );
                                return AlertDialog(
                                  title: const Text('Edit Category'),
                                  content: TextField(
                                    controller: editController,
                                    decoration: const InputDecoration(
                                      labelText: 'Category Name',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(
                                        context,
                                        editController.text,
                                      ),
                                      child: const Text('Save'),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (newName != null && newName.trim().isNotEmpty) {
                              // ignore: use_build_context_synchronously
                              context.read<CategoriesBloc>().add(
                                EditCategory(cat['id'], newName.trim()),
                              );
                            }
                          },
                          onDelete: () {
                            context.read<CategoriesBloc>().add(
                              DeleteCategory(cat['id']),
                            );
                          },
                        );
                      },
                    );
                  }
                  if (state is CategoriesError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
