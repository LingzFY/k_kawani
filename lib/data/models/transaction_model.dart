// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:k_kawani/data/models/transaction_file_model.dart';
import 'package:k_kawani/data/models/transaction_item_model.dart';

class TransactionOrderModel {
  String? Id; // For order detail
  String? TrxNo; // For order detail
  String? Description; // For order detail
  double? SubTotal; // For order detail
  double? Tax; // For order detail
  double? TotalPrice; // For order detail
  String? Status; // For order detail
  String? CreateBy; // For order detail
  String? CreateDate; // For order detail
  String? UpdateBy; // For order detail
  String? UpdateDate; // For order detail
  String? IdTransaction; // For transaction
  double? DineOption; // For transaction & order detail
  double? TotalPayment; // For transaction
  double? PaymentMethodId; // For transaction
  String? PaymentRefference; // For transaction
  TransactionFileModel? PaymentFile; // For transaction
  List<TransactionItemModel> Items; // For transaction & order detail

  TransactionOrderModel({
    this.Id,
    this.TrxNo,
    this.Description,
    this.SubTotal,
    this.Tax,
    this.TotalPrice,
    this.Status,
    this.CreateBy,
    this.CreateDate,
    this.UpdateBy,
    this.UpdateDate,
    this.IdTransaction,
    this.TotalPayment,
    this.PaymentMethodId,
    this.PaymentRefference,
    this.PaymentFile,
    this.DineOption,
    required this.Items,
  });

  static final empty = TransactionOrderModel(
    Id: '',
    TrxNo: '',
    Description: '',
    SubTotal: 0,
    Tax: 0,
    TotalPrice: 0,
    Status: '',
    CreateBy: '',
    CreateDate: '',
    UpdateBy: '',
    UpdateDate: '',
    IdTransaction: '',
    DineOption: 0,
    TotalPayment: 0,
    PaymentMethodId: 0,
    PaymentRefference: '',
    PaymentFile: TransactionFileModel.empty,
    Items: [],
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'TrxNo': TrxNo,
      'Description': Description,
      'SubTotal': SubTotal,
      'Tax': Tax,
      'TotalPrice': TotalPrice,
      'Status': Status,
      'CreateBy': CreateBy,
      'CreateDate': CreateDate,
      'UpdateBy': UpdateBy,
      'UpdateDate': UpdateDate,
      'IdTransaction': IdTransaction,
      'TotalPayment': TotalPayment,
      'PaymentMethodId': PaymentMethodId,
      'PaymentRefference': PaymentRefference,
      'PaymentFile': PaymentFile?.toMap(),
      'DineOption': DineOption,
      'Items': Items.map((x) => x.toMap()).toList(),
    };
  }

  factory TransactionOrderModel.fromMap(Map<String, dynamic> map) {
    return TransactionOrderModel(
      Id: map['Id'] != null ? map['Id'] as String : null,
      TrxNo: map['TrxNo'] != null ? map['TrxNo'] as String : null,
      Description:
          map['Description'] != null ? map['Description'] as String : null,
      SubTotal: map['SubTotal'] != null ? map['SubTotal'] as double : null,
      Tax: map['Tax'] != null ? map['Tax'] as double : null,
      TotalPrice:
          map['TotalPrice'] != null ? map['TotalPrice'] as double : null,
      Status: map['Status'] != null ? map['Status'] as String : null,
      CreateBy: map['CreateBy'] != null ? map['CreateBy'] as String : null,
      CreateDate:
          map['CreateDate'] != null ? map['CreateDate'] as String : null,
      UpdateBy: map['UpdateBy'] != null ? map['UpdateBy'] as String : null,
      UpdateDate:
          map['UpdateDate'] != null ? map['UpdateDate'] as String : null,
      IdTransaction:
          map['IdTransaction'] != null ? map['IdTransaction'] as String : null,
      TotalPayment:
          map['TotalPayment'] != null ? map['TotalPayment'] as double : null,
      PaymentMethodId: map['PaymentMethodId'] != null
          ? map['PaymentMethodId'] as double
          : null,
      PaymentRefference: map['PaymentRefference'] != null
          ? map['PaymentRefference'] as String
          : null,
      PaymentFile: map['PaymentFile'] != null
          ? TransactionFileModel.fromMap(
              map['PaymentFile'] as Map<String, dynamic>)
          : null,
      DineOption:
          map['DineOption'] != null ? map['DineOption'] as double : null,
      Items: List<TransactionItemModel>.from(
        (map['Items'] as List<int>).map<TransactionItemModel>(
          (x) => TransactionItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionOrderModel.fromJson(String source) =>
      TransactionOrderModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
