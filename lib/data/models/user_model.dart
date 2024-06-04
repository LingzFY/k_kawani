import 'dart:convert';

import 'package:k_kawani/global_variable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class UserModel {
  String? Id;
  String? IdApplication;
  String? Username;
  String? FullName;
  String? Mail;
  String? Phone;

  UserModel({
    this.Id,
    this.IdApplication,
    this.Username,
    this.FullName,
    this.Mail,
    this.Phone,
  });

  static final empty = UserModel(
    FullName: '',
    Id: '',
    IdApplication: '',
    Mail: '',
    Phone: '',
    Username: '',
  );

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

  static final empty = AuthRequestModel(
    IdApplication: GlobalVariable.idApplication,
    Username: '',
    Password: '',
  );

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

class AuthResponseDataModel {
  String? Id;
  String? Username;
  String? Fullname;
  String? Mail;
  String? PhoneNumber;
  String? PhotoUrl;
  double? AccessFailedCount;
  String? LastChangePassword;
  String? LastLogin;
  String? ExpiredUser;
  String? ExpiredPassword;
  String? Status;
  bool? Active;
  bool? IsLockout;
  String? CreateBy;
  String? CreateDate;
  String? UpdateBy;
  String? UpdateDate;
  UserModel? User;
  String? ExpiredAt;
  String? RawToken;
  String? RefreshToken;

  AuthResponseDataModel({
    this.Id,
    this.Username,
    this.Fullname,
    this.Mail,
    this.PhoneNumber,
    this.PhotoUrl,
    this.AccessFailedCount,
    this.LastChangePassword,
    this.LastLogin,
    this.ExpiredUser,
    this.ExpiredPassword,
    this.Status,
    this.Active,
    this.IsLockout,
    this.CreateBy,
    this.CreateDate,
    this.UpdateBy,
    this.UpdateDate,
    this.User,
    this.ExpiredAt,
    this.RawToken,
    this.RefreshToken,
  });

  static final empty = AuthResponseDataModel(
    Id: '',
    Username: '',
    Fullname: '',
    Mail: '',
    PhoneNumber: '',
    PhotoUrl: '',
    AccessFailedCount: 0,
    LastChangePassword: '',
    LastLogin: '',
    ExpiredUser: '',
    ExpiredPassword: '',
    Status: '',
    Active: true,
    IsLockout: false,
    CreateBy: '',
    CreateDate: '',
    UpdateBy: '',
    UpdateDate: '',
    User: UserModel.empty,
    ExpiredAt: '',
    RawToken: '',
    RefreshToken: '',
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Username': Username,
      'Fullname': Fullname,
      'Mail': Mail,
      'PhoneNumber': PhoneNumber,
      'PhotoUrl': PhotoUrl,
      'AccessFailedCount': AccessFailedCount,
      'LastChangePassword': LastChangePassword,
      'LastLogin': LastLogin,
      'ExpiredUser': ExpiredUser,
      'ExpiredPassword': ExpiredPassword,
      'Status': Status,
      'Active': Active,
      'IsLockout': IsLockout,
      'CreateBy': CreateBy,
      'CreateDate': CreateDate,
      'UpdateBy': UpdateBy,
      'UpdateDate': UpdateDate,
      'User': User?.toMap(),
      'ExpiredAt': ExpiredAt,
      'RawToken': RawToken,
      'RefreshToken': RefreshToken,
    };
  }

  factory AuthResponseDataModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseDataModel(
      Id: map['Id'] != null ? map['Id'] as String : null,
      Username: map['Username'] != null ? map['Username'] as String : null,
      Fullname: map['Fullname'] != null ? map['Fullname'] as String : null,
      Mail: map['Mail'] != null ? map['Mail'] as String : null,
      PhoneNumber:
          map['PhoneNumber'] != null ? map['PhoneNumber'] as String : null,
      PhotoUrl: map['PhotoUrl'] != null ? map['PhotoUrl'] as String : null,
      AccessFailedCount: map['AccessFailedCount'] != null
          ? map['AccessFailedCount'] as double
          : null,
      LastChangePassword: map['LastChangePassword'] != null
          ? map['LastChangePassword'] as String
          : null,
      LastLogin: map['LastLogin'] != null ? map['LastLogin'] as String : null,
      ExpiredUser:
          map['ExpiredUser'] != null ? map['ExpiredUser'] as String : null,
      ExpiredPassword: map['ExpiredPassword'] != null
          ? map['ExpiredPassword'] as String
          : null,
      Status: map['Status'] != null ? map['Status'] as String : null,
      Active: map['Active'] != null ? map['Active'] as bool : null,
      IsLockout: map['IsLockout'] != null ? map['IsLockout'] as bool : null,
      CreateBy: map['CreateBy'] != null ? map['CreateBy'] as String : null,
      CreateDate:
          map['CreateDate'] != null ? map['CreateDate'] as String : null,
      UpdateBy: map['UpdateBy'] != null ? map['UpdateBy'] as String : null,
      UpdateDate:
          map['UpdateDate'] != null ? map['UpdateDate'] as String : null,
      User: map['User'] != null
          ? UserModel.fromMap(map['User'] as Map<String, dynamic>)
          : null,
      ExpiredAt: map['ExpiredAt'] != null ? map['ExpiredAt'] as String : null,
      RawToken: map['RawToken'] != null ? map['RawToken'] as String : null,
      RefreshToken:
          map['RefreshToken'] != null ? map['RefreshToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseDataModel.fromJson(String source) =>
      AuthResponseDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class AuthResponseModel {
  AuthResponseDataModel? Data;
  double? Code;
  bool? Succeeded;
  String? Message;
  String? Description;

  AuthResponseModel({
    this.Data,
    this.Code,
    this.Succeeded,
    this.Message,
    this.Description,
  });

  static final empty = AuthResponseModel();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Data': Data?.toMap(),
      'Code': Code,
      'Succeeded': Succeeded,
      'Message': Message,
      'Description': Description,
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      Data: map['Data'] != null
          ? AuthResponseDataModel.fromMap(map['Data'] as Map<String, dynamic>)
          : null,
      Code: map['Code'] != null ? map['Code'] as double : null,
      Succeeded: map['Succeeded'] != null ? map['Succeeded'] as bool : null,
      Message: map['Message'] != null ? map['Message'] as String : null,
      Description:
          map['Description'] != null ? map['Description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromJson(String source) =>
      AuthResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
