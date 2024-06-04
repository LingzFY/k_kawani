import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class TransactionIdModel {
  final String? Id;
  final String? TrxNo;
  final int? Code;
  final bool? Successed;
  final String? Message;
  final String? Description;
  
  const TransactionIdModel({
    this.Id,
    this.TrxNo,
    this.Code,
    this.Successed,
    this.Message,
    this.Description,
  });

  static const empty = TransactionIdModel(
    Id: '',
    TrxNo: '',
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'TrxNo': TrxNo,
      'Code': Code,
      'Successed': Successed,
      'Message': Message,
      'Description': Description,
    };
  }

  factory TransactionIdModel.fromMap(Map<String, dynamic> map) {
    return TransactionIdModel(
      Id: map["Data"]['Id'] != null ? map["Data"]['Id'] as String : null,
      TrxNo: map["Data"]['TrxNo'] != null ? map["Data"]['TrxNo'] as String : null,
      Code: map['Code'] != null ? map['Code'] as int : null,
      Successed: map['Successed'] != null ? map['Successed'] as bool : null,
      Message: map['Message'] != null ? map['Message'] as String : null,
      Description: map['Description'] != null ? map['Description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionIdModel.fromJson(String source) => TransactionIdModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
