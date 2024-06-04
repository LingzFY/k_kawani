import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/bloc/order_bloc/transaction_bloc.dart';
import 'package:k_kawani/helpers/show_alert_dialog.dart';
import 'package:k_kawani/presentations/order/widgets/landscape/button_widget.dart';
import 'package:k_kawani/presentations/order/widgets/landscape/header_widget.dart';
import 'package:k_kawani/presentations/order/widgets/landscape/list_widget.dart';
import 'package:k_kawani/presentations/order/widgets/landscape/option_widget.dart';
import 'package:k_kawani/presentations/order/widgets/landscape/price_widget.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class OrderScreenLandscape extends StatelessWidget {
  const OrderScreenLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        // debugPrint(state.toString());
        if (state.status.isOk) {
          Navigator.pop(context);
        } else if (state.status.isLoading) {
          showAlertDialog(context, Icons.timer_outlined, Colors.blue, 'Loading',
              'Getting transaction id...', []);
        } else if (state.status.isHold) {
          Navigator.pop(context);
          showAlertDialog(
            context,
            Icons.check_circle_outline_outlined,
            Colors.green,
            'Ok!',
            'Order was held...',
            [
              TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<TransactionBloc>().add(GetTransactionId());
                  }),
            ],
          );
        } else if (state.status.isBadRequest) {
          Navigator.pop(context);
          showAlertDialog(
            context,
            Icons.info_outline_rounded,
            Colors.orangeAccent,
            'Bad Request!',
            'Something not right...',
            [
              TextButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        } else if (state.status.isForbidden) {
          Navigator.pop(context);
          showAlertDialog(
            context,
            Icons.info_outline_rounded,
            Colors.orangeAccent,
            'Forbidden!',
            'Something not right...',
            [
              TextButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(24.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderWidgetLandscape(),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            const DineOptionWidgetLandscape(),
            const SizedBox(height: 24.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product List',
                  style: AppTextStylesBlack.body1,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    showAlertDialog(
                      context,
                      Icons.warning,
                      Colors.orangeAccent,
                      "Clear Item List?",
                      "This action will clear cart list...",
                      [
                        TextButton(
                          onPressed: () {
                            context.read<TransactionBloc>().add(ClearAllItem());
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
                  child: Text(
                    'Clear All',
                    style: AppTextStylesRed.body2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Expanded(
              child: ListWidgetLandscape(),
            ),
            const SizedBox(height: 24.0),
            const PriceWidgetLandscape(),
            const SizedBox(height: 24.0),
            const ButtonWidgetLandscape(),
          ],
        ),
      ),
    );
  }
}
