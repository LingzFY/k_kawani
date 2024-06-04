// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:k_kawani/data/models/product_model.dart';

class TransactionItemModel {
  final String? idItem;
  final String? Id;
  double? Qty;
  String? Notes;
  String? Description;
  final ProductModel? Product;

  TransactionItemModel({
    this.idItem,
    this.Id,
    this.Qty,
    this.Notes,
    this.Description,
    this.Product,
  });

  static final empty = TransactionItemModel();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idItem': idItem,
      'Id': Id,
      'Qty': Qty,
      'Notes': Notes,
      'Description': Description,
      'Product': Product?.toMap(),
    };
  }

  factory TransactionItemModel.fromMap(Map<String, dynamic> map) {
    return TransactionItemModel(
      idItem: map['Id'] != null ? map['Id'] as String : null,
      Id: map['Id'] != null ? map['Id'] as String : null,
      Qty: map['Qty'] != null ? map['Qty'] as double : null,
      Notes: map['Notes'] != null ? map['Notes'] as String : null,
      Description: map['Notes'] != null ? map['Notes'] as String : null,
      Product: map['Product'] != null
          ? ProductModel.fromMap(map['Product'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionItemModel.fromJson(String source) =>
      TransactionItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
