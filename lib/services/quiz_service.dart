import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internquiz/models/quiz.dart';


class QuizService {
  static const String _endpoint = 'https://api.jsonserve.com/Uw5CrX';

  Future<Quiz> fetchQuiz() async {
    final response = await http.get(Uri.parse(_endpoint));
    
    if (response.statusCode == 200) {
      return Quiz.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load quiz: ${response.statusCode}');
    }
  }
}