import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckAuthEvent>((event, emit) async {
      emit(SplashLoading());
      await Future.delayed(const Duration(seconds: 3));
      final user = FirebaseAuth.instance.currentUser;
      try {
        await user?.reload();
      } catch (_) {
        debugPrint('Error reloading user');
      }
      if (FirebaseAuth.instance.currentUser != null) {
        emit(SplashAuthenticated());
      } else {
        emit(SplashUnauthenticated());
      }
    });
  }
}
