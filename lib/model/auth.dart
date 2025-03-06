class UserModel {
  final String? token;
  final String username;
  final String? password;
  final String email;

  UserModel(
      {this.token, required this.username, required this.email, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['accessToken'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
}
