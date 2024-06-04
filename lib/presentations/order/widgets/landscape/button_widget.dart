import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/bloc/order_bloc/transaction_bloc.dart';
import 'package:k_kawani/helpers/show_alert_dialog.dart';
import 'package:k_kawani/presentations/payment/payment_screen_landscape.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class ButtonWidgetLandscape extends StatelessWidget {
  const ButtonWidgetLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              height: 40.0,
              width: 104.0,
              child: ElevatedButton(
                onPressed: () {
                  if (state.transactionOrder.Items.isNotEmpty &&
                      state.transactionOrder.Status != 'HOLD') {
                    // debugPrint(state.transactionOrder.toJson());
                    context.read<TransactionBloc>().add(
                          HoldTransaction(
                            transactionOrder: state.transactionOrder,
                          ),
                        );
                  } else {
                    showAlertDialog(
                      context,
                      Icons.info_outline_rounded,
                      Colors.orangeAccent,
                      'No Item Added!',
                      'Please add item first....',
                      [
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Hold",
                  style: AppTextStylesWhite.button,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: SizedBox(
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (state.transactionOrder.Items.isNotEmpty) {
                      // debugPrint(state.transactionOrder.toJson());
                      showDialog(
                        context: context,
                        builder: (context) => PaymentScreenLandscape(
                          transactionOrder: state.transactionOrder,
                        ),
                      ).then(
                        (value) => value ? context.read<TransactionBloc>().add(
                              GetTransactionId(),
                            ) : '',
                      );
                    } else {
                      showAlertDialog(
                        context,
                        Icons.info_outline_rounded,
                        Colors.orangeAccent,
                        'No Item Added!',
                        'Please add item first....',
                        [
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    "Payment",
                    style: AppTextStylesWhite.button,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
