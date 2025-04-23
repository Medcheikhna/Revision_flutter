class Auth {
  static final Auth _instance = Auth._internal();

  factory Auth() => _instance;

  Auth._internal();

  String? token;
  String username = '';
  String? password;
  String email = '';

  void fromJson(Map<String, dynamic> json) {
    token = json['accessToken'] ?? '';
    username = json['username'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
  }
}
