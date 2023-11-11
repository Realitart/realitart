import 'dart:convert';

TestResponseModel testResponseModelFromJson(String str) =>
    TestResponseModel.fromJson(json.decode(str));

String testResponseModelToJson(TestResponseModel data) =>
    json.encode(data.toJson());

class TestResponseModel {
  int id;
  DateTime start;
  DateTime expiration;
  List<QuestionsAnsAnswer> questionsAnsAnswers;

  TestResponseModel({
    required this.id,
    required this.start,
    required this.expiration,
    required this.questionsAnsAnswers,
  });

  factory TestResponseModel.fromJson(Map<String, dynamic> json) =>
      TestResponseModel(
        id: json["id"],
        start: DateTime.parse(json["start"]),
        expiration: DateTime.parse(json["expiration"]),
        questionsAnsAnswers: List<QuestionsAnsAnswer>.from(
            json["questionsAnsAnswers"]
                .map((x) => QuestionsAnsAnswer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start": start.toIso8601String(),
        "expiration": expiration.toIso8601String(),
        "questionsAnsAnswers":
            List<dynamic>.from(questionsAnsAnswers.map((x) => x.toJson())),
      };
}

class QuestionsAnsAnswer {
  int questionId;
  int answerId;

  QuestionsAnsAnswer({
    required this.questionId,
    required this.answerId,
  });

  factory QuestionsAnsAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionsAnsAnswer(
        questionId: json["questionId"],
        answerId: json["answerId"],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "answerId": answerId,
      };
}
