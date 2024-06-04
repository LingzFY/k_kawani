import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/bloc/order_bloc/transaction_bloc.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class DineOptionWidgetLandscape extends StatelessWidget {
  const DineOptionWidgetLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dine option',
                style: AppTextStylesBlack.body1,
              ),
              Text(
                'Where you want to eat?',
                style: AppTextStylesBlack.caption,
              ),
            ],
          ),
          const Spacer(),
          const SizedBox(width: 24.0),
          InkWell(
            onTap: () => context.read<TransactionBloc>().add(
                  ChangeDineOption(dineOption: 0),
                ),
            child: AnimatedContainer(
              height: 40.0,
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                color: (state.transactionOrder.DineOption == 0)
                    ? Colors.orangeAccent
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'Dine In',
                  style: (state.transactionOrder.DineOption == 0)
                      ? AppTextStylesWhite.button
                      : AppTextStylesBlack.button,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          InkWell(
            onTap: () => context.read<TransactionBloc>().add(
                  ChangeDineOption(dineOption: 1),
                ),
            child: AnimatedContainer(
              height: 40.0,
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                color: (state.transactionOrder.DineOption == 1)
                    ? Colors.orangeAccent
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'Take Away',
                  style: (state.transactionOrder.DineOption == 1)
                      ? AppTextStylesWhite.button
                      : AppTextStylesBlack.button,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
