import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_manager/screens/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeSystem();
  runApp(const TasksManager());
}

Future<void> _initializeSystem() async {
  await Firebase.initializeApp();
}

class TasksManager extends StatelessWidget {
  const TasksManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getBlocProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Tasks Manager",
        home: const Splash(),
      ),
    );
  }
}

List<BlocProvider> _getBlocProviders() {
  return [];
}
