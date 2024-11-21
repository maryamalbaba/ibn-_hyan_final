// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ibnhyanfinal/feature/quiz_in_subject/data/model/problem.dart';
import 'package:ibnhyanfinal/feature/quiz_in_subject/data/model/question_model.dart';

class ResponseQuizAllSubject {
  num id;
  String name;
  String description;
  num time_limit;
  num subject_id;
  String subject_name;
  num result_id;
  num question_count;
  num total_score;
List<QuestionModel>separated_questions;
  List<ProblemModel>? problems;
  ResponseQuizAllSubject({
    required this.id,
    required this.name,
    required this.description,
    required this.time_limit,
    required this.subject_id,
    required this.subject_name,
    required this.result_id,
    required this.question_count,
    required this.total_score,
    required this.problems,
    required this.separated_questions
  });

  ResponseQuizAllSubject copyWith({
    num? id,
    String? name,
    String? description,
    num? time_limit,
    num? subject_id,
    String? subject_name,
    num? result_id,
    num? question_count,
    num? total_score,
    List<ProblemModel>? problems,
  }) {
    return ResponseQuizAllSubject(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      time_limit: time_limit ?? this.time_limit,
      subject_id: subject_id ?? this.subject_id,
      subject_name: subject_name ?? this.subject_name,
      result_id: result_id ?? this.result_id,
      question_count: question_count ?? this.question_count,
      total_score: total_score ?? this.total_score,
      problems: problems ?? this.problems,
       separated_questions: separated_questions ?? this.separated_questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'time_limit': time_limit,
      'subject_id': subject_id,
      'subject_name': subject_name,
      'result_id': result_id,
      'question_count': question_count,
      'total_score': total_score,
      'problems': problems!.map((x) => x.toMap()).toList(),
    };
  }

  factory ResponseQuizAllSubject.fromMap(Map<String, dynamic> map) {
    return ResponseQuizAllSubject(
      id: map['id'] as num? ??0,
      name: map['name'] as String,
      description: map['description'] as String? ??"",
      time_limit: map['time_limit']  as num? ??0,
      subject_id: map['subject_id'] as num? ??0,
      subject_name: map['subject_name'] as String? ??"",
      result_id: map['result_id'] as num? ??0,
      question_count: map['question_count'] as num? ??0,
      total_score: map['total_score'] as num,
      problems:  map['problems']!=null? List<ProblemModel>.from((map['problems'] as List<dynamic>).map<ProblemModel>((x) => ProblemModel.fromMap(x as Map<String,dynamic>),),):[],
       separated_questions: map['separated_questions']!=null? List<QuestionModel>.from((map['separated_questions'] as List<dynamic>).map<QuestionModel>((x) => QuestionModel.fromMap(x as Map<String,dynamic>),),):[],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseQuizAllSubject.fromJson(String source) => ResponseQuizAllSubject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResponseQuiz(id: $id, name: $name, description: $description, time_limit: $time_limit, subject_id: $subject_id, subject_name: $subject_name, result_id: $result_id, question_count: $question_count, total_score: $total_score, problems: $problems)';
  }

  @override
  bool operator ==(covariant ResponseQuizAllSubject other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.time_limit == time_limit &&
      other.subject_id == subject_id &&
      other.subject_name == subject_name &&
      other.result_id == result_id &&
      other.question_count == question_count &&
      other.total_score == total_score &&
      listEquals(other.problems, problems);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      time_limit.hashCode ^
      subject_id.hashCode ^
      subject_name.hashCode ^
      result_id.hashCode ^
      question_count.hashCode ^
      total_score.hashCode ^
      problems.hashCode;
  }
}
