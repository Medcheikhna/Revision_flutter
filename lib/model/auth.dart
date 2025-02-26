class UserModel {
  final String token;
  final String username;
  final String password;

  UserModel(
      {required this.password, required this.token, required this.username});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      password: json['password'] ?? '',
      token: json['accessToken'] ?? '',
      username: json['username'] ?? '',
    );
  }
}
