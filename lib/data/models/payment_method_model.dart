import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class PaymentMethodModel {
  final int? Id;
  final String? ImageUrl;
  final String? Name;
  final String? Reference;
  final String? Tipe;
  final bool? Active;
  final String? CreateBy;
  final String? CreateDate;
  final String? UpdateBy;
  final String? UpdateDate;
  
  PaymentMethodModel({
    this.Id,
    this.ImageUrl,
    this.Name,
    this.Tipe,
    this.Reference,
    this.Active,
    this.CreateBy,
    this.CreateDate,
    this.UpdateBy,
    this.UpdateDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'ImageUrl': ImageUrl,
      'Name': Name,
      'Tipe': Tipe,
      'Reference': Reference,
      'Active': Active,
      'CreateBy': CreateBy,
      'CreateDate': CreateDate,
      'UpdateBy': UpdateBy,
      'UpdateDate': UpdateDate,
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      Id: map['Id'] != null ? map['Id'] as int : null,
      ImageUrl: map['ImageUrl'] != null ? map['ImageUrl'] as String : null,
      Name: map['Name'] != null ? map['Name'] as String : null,
      Tipe: map['Tipe'] != null ? map['Tipe'] as String : null,
      Reference: map['Reference'] != null ? map['Reference'] as String : null,
      Active: map['Active'] != null ? map['Active'] as bool : null,
      CreateBy: map['CreateBy'] != null ? map['CreateBy'] as String : null,
      CreateDate: map['CreateDate'] != null ? map['CreateDate'] as String : null,
      UpdateBy: map['UpdateBy'] != null ? map['UpdateBy'] as String : null,
      UpdateDate: map['UpdateDate'] != null ? map['UpdateDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodModel.fromJson(String source) => PaymentMethodModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
