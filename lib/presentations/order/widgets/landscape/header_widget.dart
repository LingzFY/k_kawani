import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/bloc/order_bloc/transaction_bloc.dart';
import 'package:k_kawani/helpers/show_alert_dialog.dart';
import 'package:k_kawani/presentations/hold_order/hold_order_screen_landscape.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class HeaderWidgetLandscape extends StatelessWidget {
  const HeaderWidgetLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
      return Row(
        children: [
          SizedBox(
            height: 40.0,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const HoldOrderScreenLandscape(),
                ).then((value) {
                  (value != '')
                      ? context.read<TransactionBloc>().add(GetOrder(
                            idTransaction: value,
                          ))
                      : null;
                });
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              icon: const Icon(
                CupertinoIcons.cart,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 24.0),
          const Spacer(),
          Column(
            children: [
              Text('Cart', style: AppTextStylesBlack.headline6),
              (state.status.isOk ||
                      state.status.isChangeOption ||
                      state.status.isClear ||
                      state.status.isRemove ||
                      state.status.isAdd ||
                      state.status.isIncrease ||
                      state.status.isDecrease ||
                      state.status.isAddNote||
                      state.status.isSelected)
                  ? Text(
                      'Transaction ID: #${state.transactionOrder.TrxNo}',
                      style: AppTextStylesBlack.body2,
                    )
                  : Container(
                      width: 150,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(50.0)),
                    ),
            ],
          ),
          const Spacer(),
          const SizedBox(width: 24.0),
          SizedBox(
            height: 40.0,
            child: IconButton(
              onPressed: () {
                showAlertDialog(
                  context,
                  Icons.warning,
                  Colors.orangeAccent,
                  "Refresh Transaction?",
                  "This action will clear all cart data...",
                  [
                    TextButton(
                      onPressed: () {
                        context.read<TransactionBloc>().add(
                              GetTransactionId(),
                            );
                        Navigator.pop(context);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('No'),
                    ),
                  ],
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              icon: const Icon(
                CupertinoIcons.refresh,
                color: Colors.red,
              ),
              // label: Text(
              //   'Reset',
              //   style: AppTextStylesRed.button,
              // ),
            ),
          ),
        ],
      );
    });
  }
}
