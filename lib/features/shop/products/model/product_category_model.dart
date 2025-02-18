import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  final String id;
  final String productId;
  final String categoryId;

  ProductCategoryModel ({
    required this.id,
    required this.productId,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "id": id,
      "categoryId": categoryId,
    };
  }

  factory ProductCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductCategoryModel(
      id: data ["id"] as String,
      productId: data ["productId"] as String,
      categoryId: data["categoryId"] as String,
    );
  }

}