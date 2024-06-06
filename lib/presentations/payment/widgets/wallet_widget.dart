// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:k_kawani/data/bloc/payment_bloc/payment_bloc.dart';
import 'package:k_kawani/data/models/payment_method_list_model.dart';
import 'package:k_kawani/data/models/payment_method_model.dart';
import 'package:k_kawani/data/models/transaction_file_model.dart';
import 'package:k_kawani/data/models/transaction_model.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({
    super.key,
    required this.transactionOrder,
    required this.paymentMethodList,
    required this.paymentMethodName,
  });
  final TransactionOrderModel transactionOrder;
  final PaymentMethodListModel paymentMethodList;
  final String paymentMethodName;

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  PaymentMethodModel? paymentMethodValue;
  TransactionFileModel transactionFileModel = TransactionFileModel.empty;
  String? fileName;
  String? fileBase64;

  getImageorVideoFromGallery() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();
    if (filePickerResult != null) {
      fileName = filePickerResult.files[0].name;
      fileBase64 = base64Encode(filePickerResult.files[0].bytes!.toList());
      transactionFileModel.Filename = fileName;
      transactionFileModel.Base64 = fileBase64;
      context.read<PaymentBloc>().add(
            SetPaymentFile(
              transactionFile: transactionFileModel,
            ),
          );
    } else {
      fileName = null;
      fileBase64 = null;
      transactionFileModel.Filename = fileName;
      transactionFileModel.Base64 = fileBase64;
      context.read<PaymentBloc>().add(
            SetPaymentFile(
              transactionFile: transactionFileModel,
            ),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    // paymentMethodValue = widget.paymentMethodList.Items
    //     .firstWhere((element) => element.Tipe == widget.paymentMethodName);
    transactionFileModel = TransactionFileModel();
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Input note...',
              ),
              controller: TextEditingController(
                text: NumberFormat.simpleCurrency(locale: "id-ID").format(
                  widget.transactionOrder.TotalPrice,
                ),
              ),
              enabled: false,
              readOnly: true,
              onChanged: (value) {},
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
          DropdownButton<PaymentMethodModel>(
            value: paymentMethodValue,
            elevation: 16,
            style: AppTextStylesBlack.button,
            underline: Container(),
            dropdownColor: Colors.white,
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
            hint: Text(
              'Select Payment',
              style: AppTextStylesBlack.button,
            ),
            onChanged: (PaymentMethodModel? value) {
              // This is called when the user selects an item.
              setState(() {
                paymentMethodValue = value!;
              });
              context.read<PaymentBloc>().add(
                    SetPayment(
                      paymentMethodId: double.parse(value!.Id.toString()),
                      paymentRefference: value.Reference.toString(),
                    ),
                  );
            },
            items: widget.paymentMethodList.Items
                .where((element) => element.Tipe == widget.paymentMethodName)
                .map<DropdownMenuItem<PaymentMethodModel>>(
              (PaymentMethodModel paymentMethod) {
                return DropdownMenuItem<PaymentMethodModel>(
                  value: paymentMethod,
                  child: Text(
                    '${paymentMethod.Name!} (${paymentMethod.Reference!})',
                    style: AppTextStylesBlack.button,
                  ),
                );
              },
            ).toList(),
            selectedItemBuilder: (BuildContext context) => widget
                .paymentMethodList.Items
                .where((element) => element.Tipe == widget.paymentMethodName)
                .map(
              (PaymentMethodModel paymentMethod) {
                return DropdownMenuItem<PaymentMethodModel>(
                  value: paymentMethod,
                  child: Text(
                    '${paymentMethod.Name!} (${paymentMethod.Reference!})',
                    style: AppTextStylesOrange.button,
                  ),
                );
              },
            ).toList(),
          ),
          if (paymentMethodValue != null)
            const SizedBox(height: 24.0),
          if (paymentMethodValue != null)
            Center(
              child: Image.network(
                paymentMethodValue!.ImageUrl!,
                height: 128,
                width: 128,
              ),
            ),
          const SizedBox(height: 24.0),
          const Text(
            'Upload Image *',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              SizedBox(
                height: 48.0,
                child: ElevatedButton(
                  onPressed: () {
                    getImageorVideoFromGallery();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    "Upload Image",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24.0),
              Text(
                fileName == null ? 'Upload payment proof...' : fileName!,
                style: AppTextStylesBlack.body2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
