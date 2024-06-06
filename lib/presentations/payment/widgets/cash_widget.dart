import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:k_kawani/data/bloc/payment_bloc/payment_bloc.dart';
import 'package:k_kawani/data/models/payment_method_list_model.dart';
import 'package:k_kawani/data/models/transaction_model.dart';

class CashWidget extends StatefulWidget {
  const CashWidget({
    super.key,
    required this.transactionOrder,
    required this.paymentMethodList,
    required this.paymentMethodName,
  });
  final TransactionOrderModel transactionOrder;
  final PaymentMethodListModel paymentMethodList;
  final String paymentMethodName;

  @override
  State<CashWidget> createState() => _CashWidgetState();
}

class OrderModel {}

class _CashWidgetState extends State<CashWidget> {
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController totalPaymentController = TextEditingController();
  TextEditingController changeController = TextEditingController();

  double totalPayment = 0;

  @override
  void dispose() {
    totalPaymentController.dispose();
    totalPriceController.dispose();
    changeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    totalPriceController.text = NumberFormat.simpleCurrency(locale: "id-ID")
        .format(widget.transactionOrder.TotalPrice);
    changeController.text =
        NumberFormat.simpleCurrency(locale: "id-ID").format(0);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Price *',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: const InputDecoration(border: InputBorder.none),
              controller: totalPriceController,
              enabled: false,
              readOnly: true,
            ),
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Payment *',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '0',
              ),
              autofocus: true,
              controller: totalPaymentController,
              onChanged: (value) {
                context.read<PaymentBloc>().add(
                      SetTotalPayment(
                        totalPayment: totalPayment =
                            (value.isEmpty) ? 0 : double.parse(value),
                      ),
                    );

                setState(() {
                  totalPayment = (value.isEmpty) ? 0 : double.parse(value);
                  double change = 0;
                  if (double.parse(value) >
                      widget.transactionOrder.TotalPrice!) {
                    change = totalPayment - widget.transactionOrder.TotalPrice!;
                    changeController.text =
                        NumberFormat.simpleCurrency(locale: "id-ID")
                            .format(change);
                  } else {
                    changeController.text =
                        NumberFormat.simpleCurrency(locale: "id-ID").format(0);
                  }
                });
              },
            ),
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Change *',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: const InputDecoration(border: InputBorder.none),
              controller: changeController,
              enabled: false,
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }
}
