import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/note_model.dart';
import '../models/user_model.dart';

class ServerException implements Exception {
  final String errorMessage;

  ServerException(this.errorMessage);
}

class NetworkRepository {
  final http.Client httpClient = http.Client();

  // Configure the backend base URL here
  // For Android emulator: "http://10.0.2.2:8000"
  // For real device on same network: "http://<your-local-ip>:8000" (e.g., "http://192.168.1.100:8000")
  // For localhost development: "http://127.0.0.1:8000" or "http://localhost:8000"
  static const String _baseUrl =
      "http://10.0.2.2:8000"; // Change this to your backend's IP

  String _endPoint(String endPoint) {
    return "$_baseUrl/v1/$endPoint";
  }

  final Map<String, String> _header = {
    "Content-Type": "application/json; charset=utf-8"
  };

  Future<UserModel> signUp(UserModel user) async {
    final encodedParams = json.encode(user.toJson());

    final response = await httpClient.post(Uri.parse(_endPoint("user/signUp")),
        body: encodedParams, headers: _header);

    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJson(json.decode(response.body)['response']);
      return userModel;
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<UserModel> signIn(UserModel user) async {
    final encodedParams = json.encode(user.toJson());

    final response = await httpClient.post(Uri.parse(_endPoint("user/signIn")),
        body: encodedParams, headers: _header);

    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJson(json.decode(response.body)['response']);
      return userModel;
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<UserModel> myProfile(UserModel user) async {
    final response = await httpClient.get(
      Uri.parse(_endPoint("user/myProfile?uid=${user.uid}")),
    );

    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJson(json.decode(response.body)['response']);

      return userModel;
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<UserModel> updateProfile(UserModel user) async {
    final encodedParams = json.encode(user.toJson());

    final response = await httpClient.put(
        Uri.parse(_endPoint("user/updateProfile")),
        body: encodedParams,
        headers: _header);

    if (response.statusCode == 200) {
      final userModel =
          UserModel.fromJson(json.decode(response.body)['response']);
      return userModel;
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<List<NoteModel>> getMyNotes(NoteModel note) async {
    final response = await httpClient
        .get(Uri.parse(_endPoint("note/getMyNotes?uid=${note.creatorId}")));

    if (response.statusCode == 200) {
      List<dynamic> notes = json.decode(response.body)['response'];

      final notesData = notes.map((item) => NoteModel.fromjson(item)).toList();

      return notesData;
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<void> addNote(NoteModel note) async {
    final encodedParams = json.encode(note.tojson());
    final response = await httpClient.post(Uri.parse(_endPoint("note/addNote")),
        body: encodedParams, headers: _header);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<void> updateNote(NoteModel note) async {
    final encodedParams = json.encode(note.tojson());
    final response = await httpClient.put(
        Uri.parse(_endPoint("note/updateNote")),
        body: encodedParams,
        headers: _header);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }

  Future<void> deleteNote(NoteModel note) async {
    final encodedParams = json.encode(note.tojson());
    final response = await httpClient.delete(
        Uri.parse(_endPoint("note/deleteNote")),
        body: encodedParams,
        headers: _header);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw ServerException(json.decode(response.body)['response']);
    }
  }
}
