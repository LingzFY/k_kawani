import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:k_kawani/data/bloc/order_bloc/transaction_bloc.dart';
import 'package:k_kawani/data/models/transaction_model.dart';
import 'package:k_kawani/helpers/show_alert_dialog.dart';
import 'package:k_kawani/presentations/authentication/login_screen.dart';
import 'package:k_kawani/providers/repository.dart';
import 'package:k_kawani/providers/services.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class HoldOrderScreenLandscape extends StatelessWidget {
  const HoldOrderScreenLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          const Spacer(),
          Container(
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
            child: RepositoryProvider(
              create: (context) => PosRepository(service: PosService()),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => TransactionBloc(
                      posRepository: context.read<PosRepository>(),
                    )..add(
                        GetOrderList(
                          parameter: 'HOLD',
                        ),
                      ),
                  ),
                ],
                child: BlocConsumer<TransactionBloc, TransactionState>(
                  listener: (context, state) {
                    if (state.status.isOk) {
                      Navigator.pop(context);
                    } else if (state.status.isLoading) {
                      showAlertDialog(context, Icons.timer_outlined,
                          Colors.blue, 'Loading', 'Please wait...', []);
                    } else if (state.status.isError) {
                      Navigator.pop(context);
                      showAlertDialog(
                        context,
                        Icons.info_outline_rounded,
                        Colors.red,
                        'Something Was Wrong!',
                        'Try again later...',
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
                        'Payment must not be less than the price amount...',
                        [
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    } else if (state.status.isUnauthorized) {
                      Navigator.pop(context);
                      showAlertDialog(
                        context,
                        Icons.info_outline_rounded,
                        Colors.orangeAccent,
                        'Unauthorized!',
                        'Authorization has been denied for this request.',
                        [
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    debugPrint(state.toString());
                    return Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 40.0,
                              child: IconButton(
                                onPressed: () => Navigator.pop(context, ''),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                ),
                                icon: const Icon(
                                  CupertinoIcons.arrow_left,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  'Order List',
                                  style: AppTextStylesBlack.headline6,
                                ),
                                Text(
                                  'status: HOLD',
                                  style: AppTextStylesBlack.body2,
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(),
                        const SizedBox(height: 16.0),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => OrderItemWidget(
                              key: ValueKey(
                                  state.transactionOrderList.Items[index].Id),
                              order: state.transactionOrderList.Items[index],
                              callback:
                                  (TransactionOrderModel orderSelected) {
                                    Navigator.pop(context, orderSelected.Id!);
                                  },
                            ),
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (_, __) => const SizedBox(
                              height: 24.0,
                            ),
                            itemCount: state.transactionOrderList.Items.length,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef OrderClicked = Function(TransactionOrderModel orderSelected);

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    super.key,
    required this.order,
    required this.callback,
  });

  final TransactionOrderModel order;
  final OrderClicked callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(),
                  color: Colors.black,
                ),
                child: Text(
                  'Order ID: #${order.TrxNo!}',
                  style: AppTextStylesWhite.body1,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    'Date :',
                    style: AppTextStylesBlack.body2,
                  ),
                  Text(
                    (order.UpdateDate != null)
                        ? order.UpdateDate!
                        : order.CreateDate!,
                    style: AppTextStylesBlack.body2,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              Text(
                'Cashier       :',
                style: AppTextStylesBlack.body2,
              ),
              Text(
                (order.UpdateBy != null) ? order.UpdateBy! : order.CreateBy!,
                style: AppTextStylesBlack.body2,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                'Total Price   :',
                style: AppTextStylesBlack.body2,
              ),
              Text(
                NumberFormat.simpleCurrency(locale: "id-ID")
                    .format(order.TotalPrice),
                style: AppTextStylesBlack.body2,
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey.shade50,
            ),
            child: Text(
              (order.Description == null || order.Description! == '')
                  ? '-'
                  : order.Description!,
              style: AppTextStylesBlack.body2,
            ),
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            height: 40.0,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => callback(order),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                "Open",
                style: AppTextStylesWhite.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
