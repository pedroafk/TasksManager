import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks_manager/screens/tasks_list/model/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final String userId;
  List<TaskModel> _allTasks = [];

  TasksBloc(this.userId) : super(TasksLoading()) {
    on<LoadTasks>((event, emit) async {
      emit(TasksLoading());
      try {
        if (userId.isEmpty) {
          _allTasks = [];
          emit(TasksLoaded(_allTasks));
          return;
        }

        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .get();
        _allTasks = snapshot.docs
            .map((doc) => TaskModel.fromMap(doc.id, doc.data()))
            .toList();
        emit(TasksLoaded(_allTasks));
      } catch (e) {
        emit(TasksError(e.toString()));
      }
    });

    on<FilterTasks>((event, emit) {
      final filtered = _allTasks
          .where(
            (task) =>
                task.title.toLowerCase().contains(event.filter.toLowerCase()) ||
                task.description.toLowerCase().contains(
                  event.filter.toLowerCase(),
                ) ||
                task.categoryId.toLowerCase().contains(
                  event.filter.toLowerCase(),
                ) ||
                task.status.toLowerCase().contains(event.filter.toLowerCase()),
          )
          .toList();
      emit(TasksLoaded(filtered));
    });

    on<AddTask>((event, emit) async {
      try {
        if (userId.isEmpty) {
          emit(TasksError('User not authenticated'));
          return;
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .add(event.task.toMap());
        add(LoadTasks());
      } catch (e) {
        emit(TasksError(e.toString()));
      }
    });

    on<UpdateTask>((event, emit) async {
      try {
        if (userId.isEmpty) {
          emit(TasksError('User not authenticated'));
          return;
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .doc(event.task.id)
            .update(event.task.toMap());
        add(LoadTasks());
      } catch (e) {
        emit(TasksError(e.toString()));
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        if (userId.isEmpty) {
          emit(TasksError('User not authenticated'));
          return;
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('tasks')
            .doc(event.taskId)
            .delete();
        add(LoadTasks());
      } catch (e) {
        emit(TasksError(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(LoggingOut());
      _allTasks = [];
      await FirebaseAuth.instance.signOut();
      emit(LoggedOut());
    });

    on<ClearTasks>((event, emit) {
      _allTasks = [];
      emit(TasksLoaded(_allTasks));
    });
  }
}
