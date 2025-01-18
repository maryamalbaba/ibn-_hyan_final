// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ibnhyanfinal/core/Models/Result.dart';

//name is required from back
class SubjecDetailsQuizs extends Result {
  num id;
  String name;
  String? description;
  num time_limit;
  num? subject_id;
  String? subject_name;
  num? unit_id;
  String? unit_name;
  String? unit_image;
  num? lesson_id;
  String? lesson_name;
  String? lesson_image;
  num question_count;
  num total_score;
  SubjecDetailsQuizs({
    required this.id,
    required this.name,
    required this.description,
    required this.time_limit,
    required this.subject_id,
    required this.subject_name,
    required this.unit_id,
    required this.unit_name,
    required this.lesson_id,
    required this.lesson_name,
    required this.unit_image,
    required this.lesson_image,
    required this.question_count,
    required this.total_score,
  });

  SubjecDetailsQuizs copyWith({
    num? id,
    String? name,
    String? description,
    num? time_limit,
    num? subject_id,
    String? subject_name,
    num? unit_id,
    String? unit_name,
    num? lesson_id,
    String? lesson_name,
    String? unit_image,
    String? lesson_image,
    num? question_count,
    num? total_score,
  }) {
    return SubjecDetailsQuizs(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      time_limit: time_limit ?? this.time_limit,
      subject_id: subject_id ?? this.subject_id,
      subject_name: subject_name ?? this.subject_name,
      unit_id: unit_id ?? this.unit_id,
      unit_name: unit_name ?? this.unit_name,
      lesson_id: lesson_id ?? this.lesson_id,
      lesson_name: lesson_name ?? this.lesson_name,
      unit_image: unit_image ?? this.unit_image,
      lesson_image: lesson_image ?? this.lesson_image,
      question_count: question_count ?? this.question_count,
      total_score: total_score ?? this.total_score,
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
      'unit_id': unit_id,
      'unit_name': unit_name,
      'lesson_id': lesson_id,
      'lesson_name': lesson_name,
      'unit_image': unit_image,
      'lesson_image': lesson_image,
      'question_count': question_count,
      'total_score': total_score,
    };
  }

  factory SubjecDetailsQuizs.fromMap(Map<String, dynamic> map) {
    return SubjecDetailsQuizs(
      id: map['id'] as num,
      name: map['name'] as String,
      description: map['description'] as String?,
      time_limit: map['time_limit'] as num,
      subject_id: map['subject_id'] as num?,
      subject_name: map['subject_name'] as String?,
      unit_id: map['unit_id'] as num?,
      unit_name: map['unit_name'] as String?,
      lesson_id: map['lesson_id'] as num?,
      lesson_name: map['lesson_name'] as String?,
      unit_image: map['unit_image'] as String?,
      lesson_image: map['lesson_image'] as String?,
      question_count: map['question_count'] as num,
      total_score: map['total_score'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjecDetailsQuizs.fromJson(String source) =>
      SubjecDetailsQuizs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant SubjecDetailsQuizs other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.time_limit == time_limit &&
        other.subject_id == subject_id &&
        other.subject_name == subject_name &&
        other.unit_id == unit_id &&
        other.unit_name == unit_name &&
        other.lesson_id == lesson_id &&
        other.lesson_name == lesson_name &&
        other.question_count == question_count &&
        other.total_score == total_score;
  }

  @override
  String toString() {
    return 'SubjecDetailsQuizs{id: $id, name: $name, description: $description, time_limit: $time_limit, subject_id: $subject_id, subject_name: $subject_name, unit_id: $unit_id, unit_name: $unit_name, unit_image: $unit_image, lesson_id: $lesson_id, lesson_name: $lesson_name, lesson_image: $lesson_image, question_count: $question_count, total_score: $total_score}';
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        time_limit.hashCode ^
        subject_id.hashCode ^
        subject_name.hashCode ^
        question_count.hashCode ^
        total_score.hashCode;
  }
}
