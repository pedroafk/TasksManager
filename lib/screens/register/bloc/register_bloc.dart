import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.initial()) {
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<RegisterConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });
    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, error: null));
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, error: e.toString()));
      }
    });
  }
}
