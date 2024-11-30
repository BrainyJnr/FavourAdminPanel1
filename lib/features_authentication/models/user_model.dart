import 'package:cloud_firestore/cloud_firestore.dart';
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

  /// Constructor for UserModel
  UserModel({this.id,
    this.firstName = "",
    this.lastName = "",
    this.username = "",
    required this.email,
    this.phoneNumber = "",
    this.profilePicture = "",
    this.role = AppRole.user,
    this.createAt,
    this.updatedAt});

  /// Helper function to get the full name.
  String get fullName => "$firstName $lastName";

  ///--------------------------------------------------///
  String get formattedDate => fFormatter.formatDate(createAt);

  String get formmattedUpdatedDate => fFormatter.formatDate(updatedAt);

  /// Helper function to format phone Number
  String get formattedPhoneNo => fFormatter.formatPhoneNumber(phoneNumber);

  /// static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  /// static function to create an empty user model
  static UserModel empty() =>
      UserModel(
        //id: '',
        //     firstName: "",
        //     lastName: "",
        email: "",
        // phoneNumber: "",
        //     profilePicture: "",
        //     username: '',
      );

  /// convert model to JSON structure for storing data in Firebase
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
      "UpdateAt": updatedAt = DateTime.now(),
    };
  }

  /// factory method create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data.containsKey("FirstName") ? data["FirstName"] ?? "" : "",
        lastName: data.containsKey("LastName") ? data["LastName"] ?? "" : "",
        username: data.containsKey("Username") ? data["Username"] ?? "" : "",
        email: data.containsKey("Email") ? data["Email"] ?? "" : "",
        phoneNumber: data.containsKey("PhoneNumber")
            ? data["PhoneNumber"] ?? ""
            : "",
        profilePicture: data.containsKey("ProfilePicture")
            ? data["ProfilePicture"] ?? ""
            : "",
        role: data["Role"] == AppRole.admin.name ? AppRole.admin : AppRole.user,
        createAt: data.containsKey("CreatedAt")
            ? data["CreatedAt"]?.toDate() ?? DateTime.now()
            : DateTime.now(),
        updatedAt: data.containsKey("UpdatedAt")
            ? data["UpdatedAt"]?.toDate() ?? DateTime.now()
            : DateTime.now(),
      );
    } else {
      return UserModel.empty();
    }
  }
}