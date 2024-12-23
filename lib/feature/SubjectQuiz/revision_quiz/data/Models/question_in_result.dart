// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/answer_model.dart';

class QuestionInResult {
  num id;
  num score;
  // ignore: non_constant_identifier_names
  String question_text;
  // ignore: non_constant_identifier_names
  String question_image;
  List<AnswerModel> answers;
  // ignore: non_constant_identifier_names
  num user_answer_id;
  QuestionInResult({
    required this.id,
    required this.score,
    required this.question_text,
    required this.question_image,
    required this.answers,
    required this.user_answer_id,
  });

  QuestionInResult copyWith({
    num? id,
    num? score,
    String? question_text,
    String? question_image,
    List<AnswerModel>? answers,
    num? user_answer_id,
  }) {
    return QuestionInResult(
      id: id ?? this.id,
      score: score ?? this.score,
      question_text: question_text ?? this.question_text,
      question_image: question_image ?? this.question_image,
      answers: answers ?? this.answers,
      user_answer_id: user_answer_id ?? this.user_answer_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'score': score,
      'question_text': question_text,
      'question_image': question_image,
      'answers': answers.map((x) => x.toMap()).toList(),
      'user_answer_id': user_answer_id,
    };
  }

  factory QuestionInResult.fromMap(Map<String, dynamic> map) {
    return QuestionInResult(
      id: map['id'] as num,
      score: map['score'] as num,
      question_text: map['question_text'] as String,
      question_image: map['question_image'] as String,
      answers: List<AnswerModel>.from((map['answers'] as List<int>).map<AnswerModel>((x) => AnswerModel.fromMap(x as Map<String,dynamic>),),),
      user_answer_id: map['user_answer_id'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionInResult.fromJson(String source) => QuestionInResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionInResult(id: $id, score: $score, question_text: $question_text, question_image: $question_image, answers: $answers, user_answer_id: $user_answer_id)';
  }

  @override
  bool operator ==(covariant QuestionInResult other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.score == score &&
      other.question_text == question_text &&
      other.question_image == question_image &&
      listEquals(other.answers, answers) &&
      other.user_answer_id == user_answer_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      score.hashCode ^
      question_text.hashCode ^
      question_image.hashCode ^
      answers.hashCode ^
      user_answer_id.hashCode;
  }
}
