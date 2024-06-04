import 'package:flutter/material.dart';
import 'package:k_kawani/theme/app_fonts.dart';

Future<void> showAlertDialog(
  BuildContext context,
  IconData icon,
  Color? colors,
  String title,
  String message,
  List<Widget> actionsWidget,
) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Icon(icon, size: 48),
        iconColor: colors,
        title: Text(title),
        titleTextStyle: AppTextStylesBlack.headline6,
        content: Text(message, textAlign: TextAlign.center,),
        contentTextStyle: AppTextStylesBlack.body2,
        actionsAlignment: MainAxisAlignment.center,
        actions: actionsWidget
      ),
    );
