import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favour_adminpanel/features/shop/categories/model/category_model.dart';

import '../../../../utilis/formatters/fformaters.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  int? productsCount;
  DateTime? createdAt;
  DateTime? updatedAt;

  //Not Mapped
  List<CategoryModel>? brandCategories;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured = false,
    this.productsCount,
    this.createdAt,
    this.updatedAt,
  });

  static BrandModel empty() =>
      BrandModel(
          id: "",
          image: "", name: "");

  String get formattedDate => fFormatter.formatDate(createdAt);

  String get formmatedUpdatedAtDate => fFormatter.formatDate(updatedAt);

  /// Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      "Id": id,
      "Name": name,
      "Image": image,
      "ProductCount": productsCount = 0,
      "IsFeatured": isFeatured,
      "CreatedAt": createdAt,
      "UpdatedAt": updatedAt = DateTime.now(),
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();

    return BrandModel(
      id: data["Id"] ?? "",
      image: data["Image"] ?? "",
      name: data["Name"] ?? "",
      isFeatured: data["IsFeatured"] ?? false,
      productsCount: int.parse((data["ProductsCount"] ?? 0).toString()),
      createdAt: data.containsKey("CreatedAt")
          ? (data["CreatedAt"] as Timestamp).toDate()
          : null,
      updatedAt: data.containsKey("UpdatedAt")
          ? (data["UpdatedAt"] as Timestamp).toDate()
          : null,
    );
  }

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return BrandModel(
        id: document.id,
        image: data["Image"] ?? "",
        name: data["Name"] ?? "",
        isFeatured: data["IsFeatured"] ?? false,
        productsCount: int.parse((data["ProductsCount"] ?? 0).toString()),
        createdAt: data.containsKey("CreatedAt")
            ? (data["CreatedAt"] as Timestamp).toDate()
            : null,
        updatedAt: data.containsKey("UpdatedAt")
            ? (data["UpdatedAt"] as Timestamp).toDate()
            : null,
      );
    } else {
      return BrandModel.empty();
    }
  }
}
