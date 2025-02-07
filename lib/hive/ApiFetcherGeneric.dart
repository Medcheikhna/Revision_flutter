import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:newtest/services/exception.dart';

class Fetcher {
  // GET method
  Future get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        await Future.delayed(Duration(seconds: 3));
        return json.decode(response.body);
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

  // POST method
  Future post(Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/users"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
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
  Future put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.put(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      print('object response ${response.statusCode}');
      print('object response ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
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
  }

  // DELETE method
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse(endpoint));

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
