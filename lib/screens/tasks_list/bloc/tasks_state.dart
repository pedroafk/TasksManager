part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final List<TaskModel> tasks;
  const TasksLoaded(this.tasks);
}

class TasksError extends TasksState {
  final String message;
  const TasksError(this.message);
}
