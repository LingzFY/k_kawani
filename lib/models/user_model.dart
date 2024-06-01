import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class UserModel {
  final String? Id;
  final String? IdApplication;
  final String? Username;
  final String? FullName;
  final String? Mail;
  final String? Phone;

  UserModel({
    this.Id,
    this.IdApplication,
    this.Username,
    this.FullName,
    this.Mail,
    this.Phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'IdApplication': IdApplication,
      'Username': Username,
      'FullName': FullName,
      'Mail': Mail,
      'Phone': Phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      Id: map['Id'] != null ? map['Id'] as String : null,
      IdApplication:
          map['IdApplication'] != null ? map['IdApplication'] as String : null,
      Username: map['Username'] != null ? map['Username'] as String : null,
      FullName: map['FullName'] != null ? map['FullName'] as String : null,
      Mail: map['Mail'] != null ? map['Mail'] as String : null,
      Phone: map['Phone'] != null ? map['Phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AuthRequestModel {
  String IdApplication;
  String Username;
  String Password;

  AuthRequestModel({
    required this.IdApplication,
    required this.Username,
    required this.Password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'IdApplication': IdApplication,
      'Username': Username,
      'Password': Password,
    };
  }

  factory AuthRequestModel.fromMap(Map<String, dynamic> map) {
    return AuthRequestModel(
      IdApplication: map['IdApplication'] as String,
      Username: map['Username'] as String,
      Password: map['Password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRequestModel.fromJson(String source) =>
      AuthRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AuthResponseModel {
  final UserModel userModel;
  final String ExpiredAt;
  final String RawToken;
  final String RefreshToken;

  AuthResponseModel({
    required this.userModel,
    required this.ExpiredAt,
    required this.RawToken,
    required this.RefreshToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userModel': userModel.toMap(),
      'ExpiredAt': ExpiredAt,
      'RawToken': RawToken,
      'RefreshToken': RefreshToken,
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      userModel: UserModel.fromMap(map['Data']['userModel'] as Map<String,dynamic>),
      ExpiredAt: map['Data']['ExpiredAt'] as String,
      RawToken: map['Data']['RawToken'] as String,
      RefreshToken: map['Data']['RefreshToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromJson(String source) => AuthResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
