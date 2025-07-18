part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TasksEvent {}

class AddTask extends TasksEvent {
  final TaskModel task;
  const AddTask(this.task);
}

class UpdateTask extends TasksEvent {
  final TaskModel task;
  const UpdateTask(this.task);
}

class DeleteTask extends TasksEvent {
  final String taskId;
  const DeleteTask(this.taskId);
}

class FilterTasks extends TasksEvent {
  final String filter;
  const FilterTasks(this.filter);
}
