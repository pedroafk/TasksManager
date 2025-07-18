part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  const RegisterState({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isSubmitting,
    required this.isSuccess,
    this.error,
  });

  factory RegisterState.initial() => const RegisterState(
    email: '',
    password: '',
    confirmPassword: '',
    isSubmitting: false,
    isSuccess: false,
    error: null,
  );

  bool get isFormValid =>
      email.contains('@') &&
      password.length >= 6 &&
      password == confirmPassword;

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    confirmPassword,
    isSubmitting,
    isSuccess,
    error,
  ];
}
