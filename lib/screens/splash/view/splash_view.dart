import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasks_manager/screens/splash/bloc/splash_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(CheckAuthEvent()),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            Navigator.pushReplacementNamed(context, '/tasks_list');
          } else if (state is SplashUnauthenticated) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  'assets/logo/logo_slogan.svg',
                  height: 63,
                  width: 278,
                ),
                const SizedBox(height: 25),
                const Text(
                  'Tasks Manager',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                    letterSpacing: 2,
                    color: Color.fromARGB(255, 0, 0, 0),
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black26,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (state is SplashLoading || state is SplashInitial)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }
}
