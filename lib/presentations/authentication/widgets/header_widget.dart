import 'package:flutter/material.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/logo.png",
          height: 160,
        ),
        const SizedBox(height: 16),
        Text(
          "Welcome Back",
          style: appTheme.textTheme.titleLarge,
        ),
        const Text(
          "Enter your credential to login",
        ),
      ],
    );
  }
}