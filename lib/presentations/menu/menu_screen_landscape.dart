import 'package:flutter/material.dart';
import 'package:k_kawani/presentations/menu/widgets/landscape/category_widget.dart';
import 'package:k_kawani/presentations/menu/widgets/landscape/header_widget.dart';
import 'package:k_kawani/presentations/menu/widgets/landscape/product_widget.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class MenuScreenLandscape extends StatelessWidget {
  const MenuScreenLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderWidgetLandscape(),
          const SizedBox(height: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to Kedai Kawani",
                style: AppTextStylesBlack.headline5,
              ),
              Text(
                "Choose the Category",
                style: AppTextStylesBlack.body2,
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          const CategoryWidgetLandscape(),
          const SizedBox(height: 24.0),
          Text(
            "Menu List",
            style: AppTextStylesBlack.body1,
          ),
          const SizedBox(height: 24.0),
          const Expanded(
            child: ProductWidgetLandscape(),
          ),
        ],
      ),
    );
  }
}
