// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:k_kawani/data/models/payment_method_model.dart';

class PaymentMethodListModel {
  final int? Count;
  final int? Filtered;
  final List<PaymentMethodModel> Items;
  final int? Code;
  final bool? Successed;
  final String? Message;
  final String? Description;

  const PaymentMethodListModel({
    required this.Count,
    required this.Filtered,
    required this.Items,
    required this.Code,
    required this.Successed,
    required this.Message,
    required this.Description,
  });

  static const empty = PaymentMethodListModel(
    Count: 0,
    Filtered: 0,
    Items: [],
    Code: 0,
    Successed: false,
    Message: 'Message',
    Description: 'Description',
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Count': Count,
      'Filtered': Filtered,
      'Items': Items.map((x) => x.toMap()).toList(),
      'Code': Code,
      'Successed': Successed,
      'Message': Message,
      'Description': Description,
    };
  }

  factory PaymentMethodListModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodListModel(
      Count: map['Count'] != null ? map['Count'] as int : null,
      Filtered: map['Filtered'] != null ? map['Filtered'] as int : null,
      Items: List<PaymentMethodModel>.from((map['List'] as List).map<PaymentMethodModel>((x) => PaymentMethodModel.fromMap(x as Map<String,dynamic>),),),
      Code: map['Code'] != null ? map['Code'] as int : null,
      Successed: map['Successed'] != null ? map['Successed'] as bool : null,
      Message: map['Message'] != null ? map['Message'] as String : null,
      Description: map['Description'] != null ? map['Description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodListModel.fromJson(String source) => PaymentMethodListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
