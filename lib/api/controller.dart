import 'package:dio/dio.dart';
import '../models/user.dart';
import '../models/message.dart';

class ChatController {
  static const String baseUrl = 'http://localhost:5000/api';
  static final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  static Future<bool> registerUser(String username, String password) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'username': username,
        'password': password
      });

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<User?> login(String username, String password) async {
    try {
      final response =  await _dio.post('/auth/login', data: {
        'username': username,
        'password': password
      });

      if (response.statusCode == 200 && response.data != null) {
        final user = response.data["userNameCheck"];
        return User(id: user['_id'], username: user['username']);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<User?> fetchUserById(String id) async {
    try {
      final response =  await _dio.post('/auth/alluser/'+id);
      if (response.statusCode == 200) {
        final user = response.data;
        return user;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('/auth/getalluser');
      if (response.statusCode == 200) {
        final List data = response.data["users"];

        return data.map((u) => User(id: u["_id"], username: u["username"])).toList();
      }
    } catch (e) {
      return [];
    }
    return [];
  }

  static Future<List<Message>> getMessages() async {
    try {
      final response = await _dio.post('/message/getmsg');
      if (response.statusCode == 200) {
        final List data = response.data;

        return data.map((m) =>
            Message(
                text: m["message"],
                from: m["from"],
                username: m["username"],
                createdAt: DateTime.parse(m["time"])
            )).toList();
      }
    } catch (e) {
      return [];
    }
    return [];
  }

  static Future<bool> sendMessage(String from, String username, String text) async {
    try {
      final response = await _dio.post('/message/addmsg', data: {
        'from': from,
        'username': username,
        'message': text
      });

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

}