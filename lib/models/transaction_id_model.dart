import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class TransactionIdModel {
  final String? Id;
  final String? TrxNo;
  
  const TransactionIdModel({
    this.Id,
    this.TrxNo,
  });

  static const empty = TransactionIdModel(
    Id: '',
    TrxNo: '',
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'TrxNo': TrxNo,
    };
  }

  factory TransactionIdModel.fromMap(Map<String, dynamic> map) {
    return TransactionIdModel(
      Id: map["Data"]['Id'] != null ? map["Data"]['Id'] as String : null,
      TrxNo: map["Data"]['TrxNo'] != null ? map["Data"]['TrxNo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionIdModel.fromJson(String source) => TransactionIdModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
