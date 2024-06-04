// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:k_kawani/helpers/show_alert_dialog.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:k_kawani/data/bloc/auth_bloc/auth_bloc.dart';
// import 'package:k_kawani/helpers/show_alert_dialog.dart';
// import 'package:k_kawani/providers/repository.dart';
// import 'package:k_kawani/providers/services.dart';
import 'package:k_kawani/presentations/authentication/login_screen.dart';
import 'package:k_kawani/presentations/home_screen.dart';
import 'package:k_kawani/theme/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kedai Kawani',
      theme: appTheme,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isActive = prefs.getBool('isActive') ?? false;

    if (isActive) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      });
    } else if (!isActive) {
      Future.delayed(const Duration(seconds: 2), () {
        showAlertDialog(
          context,
          Icons.warning,
          Colors.orangeAccent,
          "Session End!",
          "Please re-login to continue...",
          [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Ok'),
            ),
          ],
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
