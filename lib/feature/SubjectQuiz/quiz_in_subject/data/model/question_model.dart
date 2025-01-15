// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/answer_model.dart';

class QuestionModel {
  num id;
  // ignore: non_constant_identifier_names
  String question_text;
  // ignore: non_constant_identifier_names
  String? question_image;
  final int score;
  final String source;
  List<AnswerModel> answers;
   // ignore: non_constant_identifier_names
   num? user_answer_id;

  QuestionModel({
    required this.id,
    required this.question_text,
    this.question_image,
    required this.score,
    required this.source,

    required this.answers,
     this.user_answer_id,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question_text': question_text,
      'question_image': question_image,
      'score': score,
      'source': source,
      'answers': answers.map((x) => x.toMap()).toList(),
      'user_answer_id': user_answer_id,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    try {
      return QuestionModel(
          id: map['id'] as num? ?? 0,
          question_text: map['question_text'] as String? ?? "",
          score: map['score'] as int? ?? 0,
          source: map['source'] as String? ?? "",
          question_image: map['question_image'] != null
              ? map['question_image'] as String
              : null,
          //!edit
          answers: map['answers'] != null
              ? List<AnswerModel>.from(
                  (map['answers'] as List<dynamic>).map<AnswerModel>(
                    (x) => AnswerModel.fromMap(x as Map<String, dynamic>),
                  ),
                )
              : [],
              user_answer_id:map['user_answer_id'] != null
              ? map['user_answer_id'] as num
              : null,);
    } catch (e, stackTrace) {
      print("we are in  question model catch");
      
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionModel(id: $id, question_text: $question_text, question_image: $question_image, answers: $answers,user_answer_id:$user_answer_id)';
  }

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.question_text == question_text &&
        other.question_image == question_image &&
        other.user_answer_id == user_answer_id&&
        listEquals(other.answers, answers);
         

  }

  @override
  int get hashCode {
    return id.hashCode ^
        question_text.hashCode ^
        question_image.hashCode ^
        user_answer_id.hashCode^
        answers.hashCode;
  }
}
