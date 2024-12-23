// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/problem.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/question_model.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/score/data/Models/result.dart';

class FullResRevivion {
ResultExam result_score;
  List<QuestionModel> separated_questions;
  List<ProblemModel>? problems;
  FullResRevivion({
    required this.result_score,
    required this.separated_questions,
    this.problems,
  });

  FullResRevivion copyWith({
    ResultExam? result_score,
    List<QuestionModel>? separated_questions,
    List<ProblemModel>? problems,
  }) {
    return FullResRevivion(
      result_score: result_score ?? this.result_score,
      separated_questions: separated_questions ?? this.separated_questions,
      problems: problems ?? this.problems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'result_score': result_score.toMap(),
      'separated_questions': separated_questions.map((x) => x.toMap()).toList(),
      'problems': problems?.map((x) => x.toMap()).toList(),
    };
  }

  factory FullResRevivion.fromMap(Map<String, dynamic> map) {
    try{
return FullResRevivion(
      result_score: ResultExam.fromMap(map['result_score'] as Map<String,dynamic>),
      separated_questions:  map['separated_questions'] != null
        ? List<QuestionModel>.from(
            (map['separated_questions'] as List)
                .where((element) => element != null) // Filter out null elements
                .map((x) => QuestionModel.fromMap(x as Map<String, dynamic>)),):[],
      problems: map['problems'] != null
        ? List<ProblemModel>.from(
            (map['problems'] as List)
                .where((element) => element != null) // Filter out null elements
                .map((x) => ProblemModel.fromMap(x as Map<String, dynamic>)),
          )
        : null,
    );

    }
    catch(e){
      print("excxeption in from map in FullResRevivion");
      print(' Exception is $e');
      return FullResRevivion(result_score: ResultExam(result_id: 0, image: "", duration_minutes: 0, score: 0, total_score: 0), separated_questions: []);
    }
    
  }

  String toJson() => json.encode(toMap());

  factory FullResRevivion.fromJson(String source) => FullResRevivion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FullResRevivion(result_score: $result_score, separated_questions: $separated_questions, problems: $problems)';

  @override
  bool operator ==(covariant FullResRevivion other) {
    if (identical(this, other)) return true;
  
    return 
      other.result_score == result_score &&
      listEquals(other.separated_questions, separated_questions) &&
      listEquals(other.problems, problems);
  }

  @override
  int get hashCode => result_score.hashCode ^ separated_questions.hashCode ^ problems.hashCode;
}
