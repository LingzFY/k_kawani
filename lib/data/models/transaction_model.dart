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
  double? Code;

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
    this.DineOption,
    this.TotalPayment,
    this.PaymentMethodId,
    this.PaymentRefference,
    this.PaymentFile,
    required this.Items,
    this.Code,
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
    Code: 0,
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
      'DineOption': DineOption,
      'TotalPayment': TotalPayment,
      'PaymentMethodId': PaymentMethodId,
      'PaymentRefference': PaymentRefference,
      'PaymentFile': PaymentFile?.toMap(),
      'Items': Items.map((x) => x.toMap()).toList(),
      'Code': Code,
    };
  }

  factory TransactionOrderModel.fromMapList(Map<String, dynamic> map) {
    return TransactionOrderModel(
      Id: map['Id'] != null ? map['Id'] as String : null,
      TrxNo: map['TrxNo'] != null ? map['TrxNo'] as String : null,
      Description: map['Description'] != null ? map['Description'] as String : null,
      SubTotal: map['SubTotal'] != null ? map['SubTotal'] as double : null,
      Tax: map['Tax'] != null ? map['Tax'] as double : null,
      TotalPrice: map['TotalPrice'] != null ? map['TotalPrice'] as double : null,
      Status: map['Status'] != null ? map['Status'] as String : null,
      CreateBy: map['CreateBy'] != null ? map['CreateBy'] as String : null,
      CreateDate: map['CreateDate'] != null ? map['CreateDate'] as String : null,
      UpdateBy: map['UpdateBy'] != null ? map['UpdateBy'] as String : null,
      UpdateDate: map['UpdateDate'] != null ? map['UpdateDate'] as String : null,
      IdTransaction: map['Id'] != null ? map['Id'] as String : null,
      DineOption: map['DineOption'] != null ? (map['DineOption'] == 'DINE_IN' ? 0 : 1) as double : null,
      TotalPayment: map['TotalPayment'] != null ? map['TotalPayment'] as double : null,
      PaymentMethodId: map['PaymentMethodId'] != null ? map['PaymentMethodId'] as double : null,
      PaymentRefference: map['PaymentRefference'] != null ? map['PaymentRefference'] as String : null,
      PaymentFile: map['PaymentFile'] != null ? TransactionFileModel.fromMap(map['PaymentFile'] as Map<String,dynamic>) : null,
      Items: [],
      Code: map['Code'] != null ? map['Code'] as double : null,
    );
  }

  factory TransactionOrderModel.fromMapDetail(Map<String, dynamic> map) {
    return TransactionOrderModel(
      Id: map['Data']['Id'] != null ? map['Data']['Id'] as String : null,
      TrxNo: map['Data']['TrxNo'] != null ? map['Data']['TrxNo'] as String : null,
      Description: map['Data']['Description'] != null ? map['Data']['Description'] as String : null,
      SubTotal: map['Data']['SubTotal'] != null ? map['Data']['SubTotal'] as double : null,
      Tax: map['Data']['Tax'] != null ? map['Data']['Tax'] as double : null,
      TotalPrice: map['Data']['TotalPrice'] != null ? map['Data']['TotalPrice'] as double : null,
      Status: map['Data']['Status'] != null ? map['Data']['Status'] as String : null,
      CreateBy: map['Data']['CreateBy'] != null ? map['Data']['CreateBy'] as String : null,
      CreateDate: map['Data']['CreateDate'] != null ? map['Data']['CreateDate'] as String : null,
      UpdateBy: map['Data']['UpdateBy'] != null ? map['Data']['UpdateBy'] as String : null,
      UpdateDate: map['Data']['UpdateDate'] != null ? map['Data']['UpdateDate'] as String : null,
      IdTransaction: map['Data']['Id'] != null ? map['Data']['Id'] as String : null,
      DineOption: map['Data']['DineOption'] != null ? (map['Data']['DineOption'] == 'DINE_IN' ? 0 : 1) as double : null,
      TotalPayment: map['Data']['TotalPayment'] != null ? map['Data']['TotalPayment'] as double : null,
      PaymentMethodId: map['Data']['PaymentMethodId'] != null ? map['Data']['PaymentMethodId'] as double : null,
      PaymentRefference: map['Data']['PaymentRefference'] != null ? map['Data']['PaymentRefference'] as String : null,
      PaymentFile: map['Data']['PaymentFile'] != null ? TransactionFileModel.fromMap(map['Data']['PaymentFile'] as Map<String,dynamic>) : null,
      Items: List<TransactionItemModel>.from((map['Data']['Items'] as List).map<TransactionItemModel>((x) => TransactionItemModel.fromMap(x as Map<String,dynamic>),),),
      Code: map['Code'] != null ? map['Code'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionOrderModel.fromJsonList(String source) =>
      TransactionOrderModel.fromMapList(
          json.decode(source) as Map<String, dynamic>);
  
  factory TransactionOrderModel.fromJsonDetail(String source) =>
      TransactionOrderModel.fromMapDetail(
          json.decode(source) as Map<String, dynamic>);
}
