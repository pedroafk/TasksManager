import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(error: 'Invalid email or password.'));
      }
    });
  }
}
