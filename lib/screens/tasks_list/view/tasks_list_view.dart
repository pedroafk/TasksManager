import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_manager/screens/tasks_list/view/widgets/task_list_tile.dart';
import '../bloc/tasks_bloc.dart';
import 'task_form_view.dart';
import 'widgets/logout_button.dart';
import 'widgets/add_task_button.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  final _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TasksBloc>().add(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state is LoggedOut) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Minhas Tarefas'),
          actions: [
            const AddTaskButton(),
            LogoutButton(
              onConfirmLogout: () {
                context.read<TasksBloc>().add(LogoutRequested());
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _filterController,
                    // TODO filtro
                    decoration: const InputDecoration(
                      labelText: 'Filtrar tarefas',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      context.read<TasksBloc>().add(FilterTasks(value));
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<TasksBloc, TasksState>(
                    builder: (context, state) {
                      if (state is TasksLoading || state is TasksInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is TasksLoaded) {
                        if (state.tasks.isEmpty) {
                          return const Center(
                            child: Text('Nenhuma tarefa encontrada.'),
                          );
                        }
                        return ListView.builder(
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            final task = state.tasks[index];
                            return TaskListTile(task: task);
                          },
                        );
                      }
                      return const Center(
                        child: Text('Erro ao carregar tarefas.'),
                      );
                    },
                  ),
                ),
              ],
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                if (state is LoggingOut) {
                  return Container(
                    color: Colors.black38,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
