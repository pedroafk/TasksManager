import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoriesLoading());
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId == null) {
          emit(CategoriesLoaded([]));
          return;
        }

        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('categories')
            .get();
        final categories = snapshot.docs
            .map((doc) => {'id': doc.id, 'name': doc['name'] as String})
            .toList();
        emit(CategoriesLoaded(categories));
      } catch (e) {
        emit(CategoriesError(e.toString()));
      }
    });

    on<AddCategory>((event, emit) async {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId == null) {
          emit(CategoriesError('User not authenticated'));
          return;
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('categories')
            .add({'name': event.name});
        add(LoadCategories());
      } catch (e) {
        emit(CategoriesError(e.toString()));
      }
    });

    on<EditCategory>((event, emit) async {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId == null) {
          emit(CategoriesError('User not authenticated'));
          return;
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('categories')
            .doc(event.id)
            .update({'name': event.name});
        add(LoadCategories());
      } catch (e) {
        emit(CategoriesError(e.toString()));
      }
    });

    on<DeleteCategory>((event, emit) async {
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId == null) {
          emit(CategoriesError('User not authenticated'));
          return;
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('categories')
            .doc(event.id)
            .delete();
        add(LoadCategories());
      } catch (e) {
        emit(CategoriesError(e.toString()));
      }
    });
  }
}
