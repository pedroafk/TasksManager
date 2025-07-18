import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_manager/screens/login/view/login_view.dart';
import 'package:tasks_manager/screens/register/view/register_view.dart';
import 'package:tasks_manager/screens/splash/view/splash_view.dart';
import 'package:tasks_manager/screens/tasks_list/view/tasks_list_view.dart';
import 'package:tasks_manager/screens/tasks_list/bloc/tasks_bloc.dart';
import 'package:tasks_manager/screens/tasks_list/bloc/categories_bloc.dart';
import 'package:tasks_manager/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeSystem();
  runApp(const TasksManager());
}

Future<void> _initializeSystem() async {
  await Firebase.initializeApp();
}

List<BlocProvider> buildProviders() {
  final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  return [
    BlocProvider<TasksBloc>(create: (_) => TasksBloc(userId)..add(LoadTasks())),
    BlocProvider<CategoriesBloc>(
      create: (_) => CategoriesBloc()..add(LoadCategories()),
    ),
  ];
}

class TasksManager extends StatelessWidget {
  const TasksManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: buildProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Tasks Manager",
        theme: AppTheme.theme,
        routes: {
          '/login': (_) => const LoginView(),
          '/register': (_) => const RegisterView(),
          '/tasks_list': (_) => const TasksListView(),
        },
        home: const SplashView(),
      ),
    );
  }
}
