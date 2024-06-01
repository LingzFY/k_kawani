import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

class CategoryModel {
  final String Id;
  final bool? Active;
  final String? ImageUrl;
  final String? Name;
  final String? CreateBy;
  final String? CreateDate;
  final String? UpdateBy;
  final String? UpdateDate;
  final int? Items;

  const CategoryModel({
    required this.Id,
    this.Active,
    this.ImageUrl,
    this.Name,
    this.CreateBy,
    this.CreateDate,
    this.UpdateBy,
    this.UpdateDate,
    this.Items,
  });

  static const empty = CategoryModel(
    Id: '',
    Active: true,
    ImageUrl: '',
    Name: '',
    CreateBy: '',
    CreateDate: '',
    UpdateBy: '',
    UpdateDate: '',
    Items: 0,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Active': Active,
      'ImageUrl': ImageUrl,
      'Name': Name,
      'CreateBy': CreateBy,
      'CreateDate': CreateDate,
      'UpdateBy': UpdateBy,
      'UpdateDate': UpdateDate,
      'Items': Items,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      Id: map['Id'] as String,
      Active: map['Active'] != null ? map['Active'] as bool : null,
      ImageUrl: map['ImageUrl'] != null ? map['ImageUrl'] as String : null,
      Name: map['Name'] != null ? map['Name'] as String : null,
      CreateBy: map['CreateBy'] != null ? map['CreateBy'] as String : null,
      CreateDate:
          map['CreateDate'] != null ? map['CreateDate'] as String : null,
      UpdateBy: map['UpdateBy'] != null ? map['UpdateBy'] as String : null,
      UpdateDate:
          map['UpdateDate'] != null ? map['UpdateDate'] as String : null,
      Items: map['Items'] != null ? map['Items'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
