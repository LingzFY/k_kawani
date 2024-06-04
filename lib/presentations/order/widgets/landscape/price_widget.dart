import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:k_kawani/data/bloc/order_bloc/transaction_bloc.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class PriceWidgetLandscape extends StatelessWidget {
  const PriceWidgetLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Subtotal",
                    style: AppTextStylesBlack.body2,
                  ),
                  const Spacer(),
                  Text(
                    NumberFormat.simpleCurrency(locale: "id-ID").format(state.transactionOrder.TotalPrice),
                    style: AppTextStylesBlack.body2,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    "Total Price",
                    style: AppTextStylesBlack.headline5,
                  ),
                  const Spacer(),
                  Text(
                    NumberFormat.simpleCurrency(locale: "id-ID").format(state.transactionOrder.TotalPrice),
                    style: AppTextStylesBlack.headline5,
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}
