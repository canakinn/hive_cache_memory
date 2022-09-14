import 'dart:convert';
import 'dart:io';

import 'package:hive_cache_memory/hive/model/user_model.dart';

import 'package:http/http.dart' as http;

abstract class IHTTPServices {
  final String _uri = "https://jsonplaceholder.typicode.com/users";
  Future<List<User>?> getData();
}

class HTTPServices extends IHTTPServices {
  @override
  Future<List<User>?> getData() async {
    final uri = Uri.parse(_uri);

    final response = await http.get(uri);
    if (response.statusCode == HttpStatus.ok) {
      Iterable result = json.decode(response.body);
      return List<User>.from(result.map((e) => User.fromJson(e)));
    }
    return null;
  }
}
