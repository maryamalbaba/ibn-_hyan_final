// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/question_model.dart';

class ProblemModel {
  final num? id;
  final String? problem_text;
  final String? problem_image;
  final List<QuestionModel>? questions;
  ProblemModel({
    this.id,
    this.problem_text,
    this.problem_image,
    this.questions,
  });

  ProblemModel copyWith({
    num? id,
    String? problem_text,
    String? problem_image,
    List<QuestionModel>? questions,
  }) {
    return ProblemModel(
      id: id ?? this.id,
      problem_text: problem_text ?? this.problem_text,
      problem_image: problem_image ?? this.problem_image,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'problem_text': problem_text,
      'problem_image': problem_image,
      'questions': questions?.map((x) => x.toMap()).toList(),
    };
  }

factory ProblemModel.fromMap(Map<String, dynamic> map) {
  return ProblemModel(
    id: map['id'] as num?,
    problem_text: map['problem_text'] !=null ?map['problem_text']as String :"",
    problem_image: map['problem_image'] as String?,
    questions: map['questions'] != null
        ? List<QuestionModel>.from(
            (map['questions'] as List)
                .where((element) => element != null) // Filter out null
                .map((x) => QuestionModel.fromMap(x as Map<String, dynamic>)),
          )
        : [],
  );
}


  String toJson() => json.encode(toMap());

  factory ProblemModel.fromJson(String source) => ProblemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProblemModel(id: $id, problem_text: $problem_text, problem_image: $problem_image, questions: $questions)';
  }

  @override
  bool operator ==(covariant ProblemModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.problem_text == problem_text &&
      other.problem_image == problem_image &&
      listEquals(other.questions, questions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      problem_text.hashCode ^
      problem_image.hashCode ^
      questions.hashCode;
  }
}
