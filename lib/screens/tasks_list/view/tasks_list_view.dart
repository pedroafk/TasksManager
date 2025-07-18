import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_manager/screens/tasks_list/view/widgets/task_list_tile.dart';
import 'package:tasks_manager/screens/tasks_list/view/widgets/tasks_filter_field.dart';
import '../bloc/tasks_bloc.dart';
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
          title: const Text('Tasks List'),
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
                TasksFilterField(controller: _filterController),
                Expanded(
                  child: BlocBuilder<TasksBloc, TasksState>(
                    builder: (context, state) {
                      if (state is TasksLoading || state is TasksInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is TasksLoaded) {
                        if (state.tasks.isEmpty) {
                          return const Center(
                            child: Text('No tasks available.'),
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
                        child: Text('An error occurred while loading tasks.'),
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
