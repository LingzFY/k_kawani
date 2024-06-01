import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class TransactionFileModel {
  String? Filename;
  String? MimeType;
  String? Base64;

  TransactionFileModel({
    this.Filename,
    this.MimeType,
    this.Base64,
  });

  static final empty = TransactionFileModel(
    Filename: '',
    MimeType: '',
    Base64: '',
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Filename': Filename,
      'MimeType': MimeType,
      'Base64': Base64,
    };
  }

  factory TransactionFileModel.fromMap(Map<String, dynamic> map) {
    return TransactionFileModel(
      Filename: map['Filename'] != null ? map['Filename'] as String : null,
      MimeType: map['MimeType'] != null ? map['MimeType'] as String : null,
      Base64: map['Base64'] != null ? map['Base64'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionFileModel.fromJson(String source) =>
      TransactionFileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
