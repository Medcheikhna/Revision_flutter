import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:newtest/model/user_model.dart';
import 'package:newtest/services/exception.dart';

class Fetcher {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/users';
  final Map<String, String> headers;
  Fetcher({this.headers = const {}});
  // GET method
  Future<List<User>> get() async {
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print(data);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on TimeoutException {
      print("timout ");
      throw Failure();
    } on SocketException {
      print("socket ");
      throw Failure();
    } on http.ClientException {
      print("ClientException ");
      throw Failure();
    } on UnauthorisedException {
      print("401-3");
      throw Failure(code: 1);
    } on BadRequestException {
      print("bad 400");
      throw Failure();
    } on NotFoundException {
      print("404");
      throw Failure();
    } on FetchDataException {
      print("Erreur fetch data:");
      throw Failure(message: "Erreur fetch data:");
    }
  }

  Future<User?> getUser(int id) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/$id'), headers: headers);
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // POST method
  Future<User> post(User user) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {...headers, 'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to post data');
      }
    } on TimeoutException {
      print("timout ");
      throw Failure();
    } on SocketException {
      print("socket ");
      throw Failure();
    } on http.ClientException {
      print("ClientException ");
      throw Failure();
    } on UnauthorisedException {
      print("401-3");
      throw Failure(code: 1);
    } on BadRequestException {
      print("bad 400");
      throw Failure();
    } on NotFoundException {
      print("404");
      throw Failure();
    } on FetchDataException {
      print("Erreur fetch data:");
      throw Failure(message: "Erreur fetch data:");
    }
  }

  // PUT method
  Future<User?> put(int id, User user) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {...headers, 'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update data');
      }
    } on TimeoutException {
      print("timout ");
      throw Failure();
    } on SocketException {
      print("socket ");
      throw Failure();
    } on http.ClientException {
      print("ClientException ");
      throw Failure();
    } on UnauthorisedException {
      print("401-3");
      throw Failure(code: 1);
    } on BadRequestException {
      print("bad 400");
      throw Failure();
    } on NotFoundException {
      print("404");
      throw Failure();
    } on FetchDataException {
      print("Erreur fetch data:");
      throw Failure(message: "Erreur fetch data:");
    } catch (e) {
      print('object ,$e');
    }
    return user;
  }

  // DELETE method
  Future<bool> delete(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl/$id'), headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to delete data');
      }
    } on TimeoutException {
      print("timout ");
      throw Failure();
    } on SocketException {
      print("socket ");
      throw Failure();
    } on http.ClientException {
      print("ClientException ");
      throw Failure();
    } on UnauthorisedException {
      print("401-3");
      throw Failure(code: 1);
    } on BadRequestException {
      print("bad 400");
      throw Failure();
    } on NotFoundException {
      print("404");
      throw Failure();
    } on FetchDataException {
      print("Erreur fetch data:");
      throw Failure(message: "Erreur fetch data:");
    }
  }
}
