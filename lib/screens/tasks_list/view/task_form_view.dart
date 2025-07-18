import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_manager/screens/tasks_list/view/category_manager_view.dart';

class TaskFormView extends StatefulWidget {
  const TaskFormView({super.key});

  @override
  State<TaskFormView> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends State<TaskFormView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _dueDate;
  String? _selectedCategoryId;
  String _selectedStatus = 'To do';

  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _titleController.addListener(() => setState(() {}));
    _descController.addListener(() => setState(() {}));
  }

  Future<void> _loadCategories() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('categories')
        .get();
    setState(() {
      _categories = snapshot.docs
          .map((doc) => {'id': doc.id, 'name': doc['name']})
          .toList();
    });
  }

  Future<void> _saveTask() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .add({
          'title': _titleController.text,
          'description': _descController.text,
          'dueDate': _dueDate,
          'categoryId': _selectedCategoryId,
          'status': _selectedStatus,
        });
  }

  bool get _isFormValid =>
      _titleController.text.isNotEmpty &&
      _dueDate != null &&
      _selectedCategoryId != null &&
      _selectedStatus.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Tarefa'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o título' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _dueDate == null
                      ? 'Data de vencimento'
                      : 'Vence em: ${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => _dueDate = picked);
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategoryId,
                      decoration: const InputDecoration(
                        labelText: 'Categoria',
                        border: OutlineInputBorder(),
                      ),
                      items: _categories
                          .map(
                            (cat) => DropdownMenuItem<String>(
                              value: cat['id'] as String,
                              child: Text(cat['name'] as String),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _selectedCategoryId = v),
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
                      await _loadCategories();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'To do', child: Text('To do')),
                  DropdownMenuItem(
                    value: 'In Progress',
                    child: Text('In Progress'),
                  ),
                  DropdownMenuItem(value: 'Done', child: Text('Done')),
                ],
                onChanged: (v) => setState(() => _selectedStatus = v!),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _isFormValid
                      ? () async {
                          if (_formKey.currentState!.validate() &&
                              _dueDate != null) {
                            await _saveTask();
                            if (context.mounted) Navigator.pop(context);
                          } else if (_dueDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Selecione a data de vencimento'),
                              ),
                            );
                          }
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
