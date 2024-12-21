// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ibnhyanfinal/core/Models/Result.dart';

class MarksModel extends Result {
 String subject_name;
  String exam_name;
  num my_score;
  num total_score;
  String date;
  MarksModel({
    required this.subject_name,
    required this.exam_name,
    required this.my_score,
    required this.total_score,
    required this.date,
  });

  MarksModel copyWith({
    String? subject_name,
    String? exam_name,
    num? my_score,
    num? total_score,
    String? date,
  }) {
    return MarksModel(
      subject_name: subject_name ?? this.subject_name,
      exam_name: exam_name ?? this.exam_name,
      my_score: my_score ?? this.my_score,
      total_score: total_score ?? this.total_score,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subject_name': subject_name,
      'exam_name': exam_name,
      'my_score': my_score,
      'total_score': total_score,
      'date': date,
    };
  }

  factory MarksModel.fromMap(Map<String, dynamic> map) {
    return MarksModel(
      subject_name: map['subject_name'] as String,
      exam_name: map['exam_name'] as String,
      my_score: map['my_score'] as num,
      total_score: map['total_score'] as num,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MarksModel.fromJson(String source) => MarksModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MarksModel(subject_name: $subject_name, exam_name: $exam_name, my_score: $my_score, total_score: $total_score, date: $date)';
  }

  @override
  bool operator ==(covariant MarksModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.subject_name == subject_name &&
      other.exam_name == exam_name &&
      other.my_score == my_score &&
      other.total_score == total_score &&
      other.date == date;
  }

  @override
  int get hashCode {
    return subject_name.hashCode ^
      exam_name.hashCode ^
      my_score.hashCode ^
      total_score.hashCode ^
      date.hashCode;
  }
}
