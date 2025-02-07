import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

// @HiveType(typeId: 0)
// class UserModel extends HiveObject {
//   @HiveField(0)
//   final int? id;

//   @HiveField(1)
//   final String? username;

//   @HiveField(2)
//   final String? email;
//   @HiveField(3)
//   final String? phone;

//   @HiveField(4)
//   final String? role;

//   @HiveField(5)
//   final String? firstName;

//   @HiveField(6)
//   final String? lastName;
//   @HiveField(7)
//   final String? password;

//   @HiveField(7)
//   final String? confirmation;

//   UserModel(
//       {this.phone,
//       this.role,
//       this.firstName,
//       this.lastName,
//       this.id,
//       this.username,
//       this.email,
//       this.password,
//       this.confirmation});

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       username: json['username'],
//       email: json['email'],
//       password: json['password'],
//       confirmation: json['confirmation'],
//       phone: json['phone'],
//       role: json['role'],
//       firstName: json['first_name'] ?? '',
//       lastName: json['last_name'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'username': username,
//         'email': email,
//         'phone': phone,
//         'role': role,
//         'first_name': firstName,
//         'last_name': lastName,
//       };
// }

@HiveType(typeId: 0)
class User extends HiveObject{
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? username;
  @HiveField(3)
  final String? email;
  //final Address address;
  @HiveField(4)
  final String? phone;
  @HiveField(5)
  final String? website;
  // final Company company;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    //  required this.address,
    this.phone,
    this.website,
    // required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      //address: Address.fromJson(json['address']),
      phone: json['phone'],
      website: json['website'],
      // company: Company.fromJson(json['company']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      //'address': address,
      'phone': phone,
      'website': website,
      //'company': company,
    };
  }
}
