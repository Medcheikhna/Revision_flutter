class Auth {
  final String? token;
  final String username;
  final String? password;
  final String email;

  Auth(
      {this.token, required this.username, required this.email, this.password});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      token: json['accessToken'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
}
