import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/bloc/auth_bloc/auth_bloc.dart';
import 'package:k_kawani/data/bloc/payment_bloc/payment_bloc.dart';
import 'package:k_kawani/data/models/transaction_file_model.dart';
import 'package:k_kawani/data/models/transaction_model.dart';
import 'package:k_kawani/helpers/show_alert_dialog.dart';
import 'package:k_kawani/presentations/authentication/login_screen.dart';
import 'package:k_kawani/presentations/payment/widgets/cash_widget.dart';
import 'package:k_kawani/presentations/payment/widgets/transfer_widget.dart';
import 'package:k_kawani/presentations/payment/widgets/wallet_widget.dart';
import 'package:k_kawani/providers/repository.dart';
import 'package:k_kawani/providers/services.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class PaymentScreenLandscape extends StatefulWidget {
  const PaymentScreenLandscape({
    super.key,
    required this.transactionOrder,
  });

  final TransactionOrderModel transactionOrder;

  @override
  State<PaymentScreenLandscape> createState() => _PaymentScreenLandscapeState();
}

class _PaymentScreenLandscapeState extends State<PaymentScreenLandscape> {
  String paymentMethodName = 'CASH';
  bool isPay = false;

  void payOrder(BuildContext context, PaymentState state) {
    showAlertDialog(
      context,
      Icons.question_mark_rounded,
      Colors.blueAccent,
      'Question',
      'Continue to process the payment?',
      [
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
            debugPrint(state.transactionOrder.toJson());
            context.read<PaymentBloc>().add(
                  PostPayment(
                    transactionOrder: state.transactionOrder,
                  ),
                );
          },
        ),
      ],
    );
  }

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
                    create: (context) => AuthBloc(
                      posRepository: context.read<PosRepository>(),
                    )..add(GetUser()),
                  ),
                  BlocProvider(
                    create: (context) => PaymentBloc(
                      posRepository: context.read<PosRepository>(),
                    )..add(GetPaymentMethod(
                        transactionOrder: widget.transactionOrder)),
                  ),
                ],
                child: BlocConsumer<PaymentBloc, PaymentState>(
                  listener: (context, state) {
                    debugPrint(state.toString());
                    debugPrint(state.transactionOrder.toString());
                    if (state.status.isOk) {
                      Navigator.pop(context);
                    } else if (state.status.isLoading) {
                      showAlertDialog(context, Icons.timer_outlined,
                          Colors.blue, 'Loading', 'Please wait...', []);
                    } else if (state.status.isPaid) {
                      isPay = true;
                      Navigator.pop(context, isPay);
                      showAlertDialog(
                        context,
                        Icons.check,
                        Colors.red,
                        'Payment Success!',
                        'Back to Menu...',
                        [
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.pop(context, isPay);
                              Navigator.pop(context, isPay);
                            },
                          ),
                        ],
                      );
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
                    return Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 40.0,
                              child: IconButton(
                                onPressed: () => Navigator.pop(context, isPay),
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
                                Text('Payment',
                                    style: AppTextStylesBlack.headline6),
                                Text(
                                  'Transaction ID: #${state.transactionOrder.TrxNo}',
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
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    paymentMethodName = 'CASH';
                                  });
                                  context.read<PaymentBloc>().add(
                                        SetPayment(
                                          paymentMethodId: 1,
                                          paymentRefference: '',
                                        ),
                                      );
                                  context.read<PaymentBloc>().add(
                                        SetPaymentFile(
                                          transactionFile:
                                              TransactionFileModel(),
                                        ),
                                      );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: (paymentMethodName == 'CASH')
                                        ? Colors.orange.shade100
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: (paymentMethodName == 'CASH')
                                          ? Colors.orangeAccent
                                          : Colors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.payments_rounded,
                                        color: (paymentMethodName == 'CASH')
                                            ? Colors.orangeAccent
                                            : Colors.grey,
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'Cash',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: (paymentMethodName == 'CASH')
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24.0),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    paymentMethodName = 'TRANSFER';
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: (paymentMethodName == 'TRANSFER')
                                        ? Colors.orange.shade100
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: (paymentMethodName == 'TRANSFER')
                                          ? Colors.orangeAccent
                                          : Colors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.payment_rounded,
                                        color: (paymentMethodName == 'TRANSFER')
                                            ? Colors.orangeAccent
                                            : Colors.grey,
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'Transfer',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color:
                                              (paymentMethodName == 'TRANSFER')
                                                  ? Colors.black
                                                  : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24.0),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    paymentMethodName = 'WALLET';
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: (paymentMethodName == 'WALLET')
                                        ? Colors.orange.shade100
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: (paymentMethodName == 'WALLET')
                                          ? Colors.orangeAccent
                                          : Colors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.wallet_rounded,
                                        color: (paymentMethodName == 'WALLET')
                                            ? Colors.orangeAccent
                                            : Colors.grey,
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'E-wallet',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: (paymentMethodName == 'WALLET')
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24.0),
                        (paymentMethodName == 'CASH')
                            ? Expanded(
                                child: CashWidget(
                                  transactionOrder: widget.transactionOrder,
                                  paymentMethodList: state.paymentMethodList,
                                  paymentMethodName: paymentMethodName,
                                ),
                              )
                            : (paymentMethodName == 'TRANSFER')
                                ? Expanded(
                                    child: TransferWidget(
                                      transactionOrder: state.transactionOrder,
                                      paymentMethodList:
                                          state.paymentMethodList,
                                      paymentMethodName: paymentMethodName,
                                    ),
                                  )
                                : (paymentMethodName == 'WALLET')
                                    ? Expanded(
                                        child: WalletWidget(
                                          transactionOrder:
                                              state.transactionOrder,
                                          paymentMethodList:
                                              state.paymentMethodList,
                                          paymentMethodName: paymentMethodName,
                                        ),
                                      )
                                    : const Expanded(
                                        child: SizedBox(),
                                      ),
                        const SizedBox(height: 24.0),
                        SizedBox(
                          height: 40.0,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (state.transactionOrder.PaymentMethodId != 1) {
                                if (state.transactionOrder.PaymentFile!
                                            .Filename ==
                                        null ||
                                    state.transactionOrder.PaymentFile!
                                        .Filename!.isEmpty) {
                                  showAlertDialog(
                                    context,
                                    Icons.info_outline_rounded,
                                    Colors.orangeAccent,
                                    'No Payment Proof!',
                                    'Payment proof has not been uploaded...',
                                    [
                                      TextButton(
                                        child: const Text('Ok'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  );
                                } else {
                                  payOrder(context, state);
                                }
                              } else {
                                payOrder(context, state);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
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
