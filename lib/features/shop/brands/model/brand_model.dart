import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favour_adminpanel/features/shop/categories/model/category_model.dart';

import '../../../../utilis/formatters/fformaters.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  int? productsCount;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Not Mapped
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

  static BrandModel empty() => BrandModel(
    id: "",
    image: "",
    name: "",
  );

  String get formattedDate => fFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => fFormatter.formatDate(updatedAt);

  /// Convert model to JSON structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Name": name,
      "Image": image,
      "ProductCount": productsCount ?? 0,
      "IsFeatured": isFeatured,
      "CreatedAt": createdAt?.toIso8601String(),
      "UpdatedAt": updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  /// Map JSON document snapshot from Firebase to BrandModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return BrandModel.empty();

    return BrandModel(
      id: document["Id"] ?? "",
      image: document["Image"] ?? "",
      name: document["Name"] ?? "",
      isFeatured: document["IsFeatured"] ?? false,
      productsCount: int.tryParse(document["ProductsCount"]?.toString() ?? "0"),
      createdAt: (document["CreatedAt"] != null && document["CreatedAt"] is Timestamp)
          ? (document["CreatedAt"] as Timestamp).toDate()
          : null,
      updatedAt: (document["UpdatedAt"] != null && document["UpdatedAt"] is Timestamp)
          ? (document["UpdatedAt"] as Timestamp).toDate()
          : null,
    );
  }

  /// Map Firestore document snapshot to BrandModel
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) return BrandModel.empty();

    return BrandModel(
      id: document.id,
      image: data["Image"] ?? "",
      name: data["Name"] ?? "",
      isFeatured: data["IsFeatured"] ?? false,
      productsCount: int.tryParse(data["ProductsCount"]?.toString() ?? "0"),
      createdAt: (data["CreatedAt"] != null && data["CreatedAt"] is Timestamp)
          ? (data["CreatedAt"] as Timestamp).toDate()
          : null,
      updatedAt: (data["UpdatedAt"] != null && data["UpdatedAt"] is Timestamp)
          ? (data["UpdatedAt"] as Timestamp).toDate()
          : null,
    );
  }
}
