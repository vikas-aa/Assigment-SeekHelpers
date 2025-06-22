import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class UserService {
  static Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((e) => User.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      rethrow;
    }
  }
}
