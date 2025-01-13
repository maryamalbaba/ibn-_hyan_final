// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ibnhyanfinal/core/Models/Result.dart';

class StatiscisModel extends Result {
  String? quiz_name;
  num score;
  num total_score;
  String? subject_name;

  String image;
  StatiscisModel({
    this.quiz_name,
    required this.score,
    required this.total_score,
    this.subject_name,
    required this.image,
  });

  StatiscisModel copyWith({
    String? quiz_name,
    num? score,
    num? total_score,
    String? subject_name,
    String? image,
  }) {
    return StatiscisModel(
      quiz_name: quiz_name ?? this.quiz_name,
      score: score ?? this.score,
      total_score: total_score ?? this.total_score,
      subject_name: subject_name ?? this.subject_name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quiz_name': quiz_name,
      'score': score,
      'total_score': total_score,
      'subject_name': subject_name,
      'image': image,
    };
  }

  factory StatiscisModel.fromMap(Map<String, dynamic> map) {
    return StatiscisModel(
      quiz_name: map['quiz_name'] != null ? map['quiz_name'] as String : "",
      score: map['score'] as num,
      total_score: map['total_score'] as num,
      subject_name: map['subject_name'] != null ? map['subject_name'] as String : '',
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatiscisModel.fromJson(String source) => StatiscisModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatiscisModel(quiz_name: $quiz_name, score: $score, total_score: $total_score, subject_name: $subject_name, image: $image)';
  }

  @override
  bool operator ==(covariant StatiscisModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.quiz_name == quiz_name &&
      other.score == score &&
      other.total_score == total_score &&
      other.subject_name == subject_name &&
      other.image == image;
  }

  @override
  int get hashCode {
    return quiz_name.hashCode ^
      score.hashCode ^
      total_score.hashCode ^
      subject_name.hashCode ^
      image.hashCode;
  }
}
