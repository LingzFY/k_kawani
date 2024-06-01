import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
class ProductModel {
  final String? Id;
  final bool? Active;
  // final String? Category;
  final String? Name;
  final String? ImageUrl;
  final double? Price;
  final double? Hpp;
  final String? Description;
  final String? CreateBy;
  final String? CreateDate;
  final String? UpdateBy;
  final String? UpdateDate;
  
  ProductModel({
    this.Id,
    this.Active,
    // this.Category,
    this.Name,
    this.ImageUrl,
    this.Price,
    this.Hpp,
    this.Description,
    this.CreateBy,
    this.CreateDate,
    this.UpdateBy,
    this.UpdateDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Active': Active,
      // 'Category': Category,
      'Name': Name,
      'ImageUrl': ImageUrl,
      'Price': Price,
      'Hpp': Hpp,
      'Description': Description,
      'CreateBy': CreateBy,
      'CreateDate': CreateDate,
      'UpdateBy': UpdateBy,
      'UpdateDate': UpdateDate,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      Id: map['Id'] != null ? map['Id'] as String : null,
      Active: map['Active'] != null ? map['Active'] as bool : null,
      // Category: map['Category'] != null ? map['Category'] as String : null,
      Name: map['Name'] != null ? map['Name'] as String : null,
      ImageUrl: map['ImageUrl'] != null ? map['ImageUrl'] as String : null,
      Price: map['Price'] != null ? map['Price'] as double : null,
      Hpp: map['Hpp'] != null ? map['Hpp'] as double : null,
      Description: map['Description'] != null ? map['Description'] as String : null,
      CreateBy: map['CreateBy'] != null ? map['CreateBy'] as String : null,
      CreateDate: map['CreateDate'] != null ? map['CreateDate'] as String : null,
      UpdateBy: map['UpdateBy'] != null ? map['UpdateBy'] as String : null,
      UpdateDate: map['UpdateDate'] != null ? map['UpdateDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
