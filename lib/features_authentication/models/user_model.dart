import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favour_adminpanel/features/shop/address/address_model.dart';
import 'package:favour_adminpanel/features/shop/orders/model/order_model.dart';
import '../../utilis/constants/enums.dart';
import '../../utilis/formatters/fformaters.dart';

class UserModel {
  // Keep those values final which you do not want to update
  final String? id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  AppRole role;
  String phoneNumber;
  String profilePicture;
  DateTime? createAt;
  DateTime? updatedAt;
  List<OrderModel>? orders;
  List<AddressModel>? addresses;

  /// Constructor for UserModel
  UserModel({
    this.id,
    this.firstName = "",
    this.lastName = "",
    this.username = "",
    required this.email,
    this.phoneNumber = "",
    this.profilePicture = "",
    this.role = AppRole.user,
    this.createAt,
    this.updatedAt,
    this.addresses = const [],  // Ensure addresses are initialized
  });

  /// ✅ `copyWith` method to update fields
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    AppRole? role,
    String? phoneNumber,
    String? profilePicture,
    DateTime? createAt,
    DateTime? updatedAt,
    List<OrderModel>? orders,
    List<AddressModel>? addresses,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      createAt: createAt ?? this.createAt,
      updatedAt: updatedAt ?? this.updatedAt,
      addresses: addresses ?? this.addresses, // ✅ Ensure addresses are copied
    );
  }

  /// Helper function to get the full name.
  String get fullName => "$firstName $lastName";

  /// Helper function to format date.
  String get formattedDate => fFormatter.formatDate(createAt);
  String get formattedUpdatedDate => fFormatter.formatDate(updatedAt);

  /// Helper function to format phone Number
  String get formattedPhoneNo => fFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    return "$firstName$lastName";
  }

  /// Static function to create an empty user model
  static UserModel empty() => UserModel(email: "");

  /// Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      "FirstName": firstName,
      "LastName": lastName,
      "Username": username,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "ProfilePicture": profilePicture,
      "Role": role.name.toString(),
      "CreatedAt": createAt,
      "UpdatedAt": updatedAt = DateTime.now(),
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data["FirstName"] ?? "",
        lastName: data["LastName"] ?? "",
        username: data["Username"] ?? "",
        email: data["Email"] ?? "",
        phoneNumber: data["PhoneNumber"] ?? "",
        profilePicture: data["ProfilePicture"] ?? "",
        role: (data["Role"] ?? AppRole.user.name) == AppRole.admin.name
            ? AppRole.admin
            : AppRole.user,
        createAt: data["CreatedAt"]?.toDate() ?? DateTime.now(),
        updatedAt: data["UpdatedAt"]?.toDate() ?? DateTime.now(),
        addresses: [], // Load addresses separately if needed
      );
    } else {
      return empty();
    }
  }
}
