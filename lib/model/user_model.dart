import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';



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
