import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/todo.dart';


Future<List<Todo>> fetchTodos() async {
 // Spring Boot 서버의 IP 또는 도메인 주소로 변경
  final url = Uri.parse('http://10.0.2.2:8080/api/todos'); // 에뮬레이터는 10.0.2.2, 실기기는 컴퓨터의 IP
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    // JSON 리스트 → Todo 객체 리스트
    return jsonList.map((json) => Todo.fromJson(json)).toList();
  } else {
    throw Exception('GET 요청 실패: ${response.statusCode}');
  }
}