class Quiz {
  final String id;
  final String title;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'].toString(),
      title: json['title'] ?? 'Unknown Quiz',
      questions: List<Question>.from(
        json['questions'].map((x) => Question.fromJson(x)),
      ),
    );
  }
}

class Question {
  final String id;
  final String description;
  final List<Answer> options;

  Question({
    required this.id,
    required this.description,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'].toString(),
      description: json['description'] ?? '',
      options: List<Answer>.from(
        json['options'].map((x) => Answer.fromJson(x)),
      ),
    );
  }
}

class Answer {
  final String id;
  final String description;
  final bool isCorrect;

  Answer({
    required this.id,
    required this.description,
    required this.isCorrect,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'].toString(),
      description: json['description'] ?? '',
      isCorrect: json['is_correct'] ?? false,
    );
  }
}