// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ibnhyanfinal/feature/quiz_in_subject/data/model/answer_model.dart';

class QuestionModel {
  num id;
  String question_text;
  String? question_image;
  List<AnswerModel> answers;

  QuestionModel({
    required this.id,
    required this.question_text,
    this.question_image,
    required this.answers,
  });

  QuestionModel copyWith({
    num? id,
    String? question_text,
    String? question_image,
    List<AnswerModel>? answers,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      question_text: question_text ?? this.question_text,
      question_image: question_image ?? this.question_image,
      answers: answers ?? this.answers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question_text': question_text,
      'question_image': question_image,
      'answers': answers.map((x) => x.toMap()).toList(),
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    try {
      return QuestionModel(
          id: map['id'] as num? ?? 0,
          question_text: map['question_text'] as String? ?? "",
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
              : []);
    } catch (e, stackTrace) {
      print("we are in  question model catch");
      
      return QuestionModel(
        id: 0,
        question_text: "",
        question_image: null,
        answers: [],
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionModel(id: $id, question_text: $question_text, question_image: $question_image, answers: $answers)';
  }

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.question_text == question_text &&
        other.question_image == question_image &&
        listEquals(other.answers, answers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question_text.hashCode ^
        question_image.hashCode ^
        answers.hashCode;
  }
}
