import 'dart:convert';

TestModel testModelFromJson(String str) => TestModel.fromJson(json.decode(str));

String testModelToJson(TestModel data) => json.encode(data.toJson());

class TestModel {
  int id;
  int code;
  String name;
  int minScoreToAprove;
  DateTime start;
  DateTime expiration;
  List<QuestionsAnsAnswer> questionsAnsAnswers;

  TestModel({
    required this.id,
    required this.code,
    required this.name,
    required this.minScoreToAprove,
    required this.start,
    required this.expiration,
    required this.questionsAnsAnswers,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        minScoreToAprove: json["minScoreToAprove"],
        start: DateTime.parse(json["start"]),
        expiration: DateTime.parse(json["expiration"]),
        questionsAnsAnswers: List<QuestionsAnsAnswer>.from(
            json["questionsAnsAnswers"]
                .map((x) => QuestionsAnsAnswer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "minScoreToAprove": minScoreToAprove,
        "start": start.toIso8601String(),
        "expiration": expiration.toIso8601String(),
        "questionsAnsAnswers":
            List<dynamic>.from(questionsAnsAnswers.map((x) => x.toJson())),
      };
}

class QuestionsAnsAnswer {
  int questionId;
  String statement;
  int points;
  List<Answer> answers;

  QuestionsAnsAnswer({
    required this.questionId,
    required this.statement,
    required this.points,
    required this.answers,
  });

  factory QuestionsAnsAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionsAnsAnswer(
        questionId: json["questionId"],
        statement: json["statement"],
        points: json["points"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "statement": statement,
        "points": points,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}

class Answer {
  int id;
  String answer;
  dynamic isCorrect;
  dynamic isChosen;

  Answer({
    required this.id,
    required this.answer,
    required this.isCorrect,
    required this.isChosen,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        answer: json["answer"],
        isCorrect: json["isCorrect"],
        isChosen: json["isChosen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
        "isCorrect": isCorrect,
        "isChosen": isChosen,
      };
}
