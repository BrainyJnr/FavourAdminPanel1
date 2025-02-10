import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageUrl;
  String? id;
  //String? name;
 // bool? isFeatured;

   String targetScreen;
  bool active;

  BannerModel({
    // this.name,
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
     //this.isFeatured,
     this.id,
  });


  Map<String, dynamic> toJson() {
    return {
      "ImageUrl": imageUrl,
      "TargetScreen": targetScreen,
      "Active": active,
     // "Name": name,
     // "IsFeatured": isFeatured,
    };
  }

//  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     return BannerModel(
//       id: document.id,
//
//       imageUrl: data["ImageUrl"] ?? "",
//       targetScreen: data["TargetScreen"] ?? "",
//       active: data["Active"] ?? false,
//     );
//   }}

  factory BannerModel.fromSnapshot(
      DocumentSnapshot snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;

// Map JSON Record to the Model
      return BannerModel(
        id: snapshot.id,
        imageUrl: data["ImageUrl"] ?? "",
        targetScreen: data["TargetScreen"] ?? "",
        active: data["Active"] ?? false,
      );
    }
}