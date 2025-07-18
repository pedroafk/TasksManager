import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_manager/screens/tasks_list/model/task_model.dart';
import 'package:tasks_manager/screens/tasks_list/bloc/tasks_bloc.dart';
import 'widgets/task_title_field.dart';
import 'widgets/task_description_field.dart';
import 'widgets/task_due_date_tile.dart';
import 'widgets/task_category_dropdown.dart';
import 'widgets/task_status_dropdown.dart';
import 'widgets/task_save_button.dart';

class TaskFormView extends StatefulWidget {
  final TaskModel? task;
  const TaskFormView({super.key, this.task});

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

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
      _dueDate = widget.task!.dueDate;
      _selectedCategoryId = widget.task!.categoryId;
      _selectedStatus = widget.task!.status;
    }
    _titleController.addListener(() => setState(() {}));
    _descController.addListener(() => setState(() {}));
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
        title: Text(widget.task == null ? 'New Task' : 'Edit Task'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: BlocListener<TasksBloc, TasksState>(
        listener: (context, state) {
          if (state is TasksError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TaskTitleField(controller: _titleController),
                const SizedBox(height: 16),
                TaskDescriptionField(controller: _descController),
                const SizedBox(height: 16),
                TaskDueDateTile(
                  dueDate: _dueDate,
                  onDatePicked: (picked) => setState(() => _dueDate = picked),
                ),
                const SizedBox(height: 16),
                TaskCategoryDropdown(
                  selectedCategoryId: _selectedCategoryId,
                  onChanged: (v) => setState(() => _selectedCategoryId = v),
                ),
                const SizedBox(height: 16),
                TaskStatusDropdown(
                  selectedStatus: _selectedStatus,
                  onChanged: (v) => setState(() => _selectedStatus = v!),
                ),
                const SizedBox(height: 24),
                BlocBuilder<TasksBloc, TasksState>(
                  builder: (context, state) {
                    final isLoading = state is TasksLoading;
                    return TaskSaveButton(
                      onPressed: (_isFormValid && !isLoading)
                          ? () async {
                              if (_formKey.currentState!.validate() &&
                                  _dueDate != null) {
                                final task = TaskModel(
                                  id: widget.task?.id ?? '',
                                  title: _titleController.text,
                                  description: _descController.text,
                                  dueDate: _dueDate!,
                                  categoryId: _selectedCategoryId!,
                                  status: _selectedStatus,
                                );
                                if (widget.task == null) {
                                  context.read<TasksBloc>().add(AddTask(task));
                                } else {
                                  context.read<TasksBloc>().add(
                                    UpdateTask(task),
                                  );
                                }
                                if (context.mounted) Navigator.pop(context);
                              } else if (_dueDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please select a due date.'),
                                  ),
                                );
                              }
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
