// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ibnhyanfinal/core/Models/Result.dart';

class SubjecDetailsQuizs extends Result {
  num id;
  String name;
  String description;
  num time_limit;
  num subject_id;
  String subject_name;
  SubjecDetailsQuizs({
    required this.id,
    required this.name,
    required this.description,
    required this.time_limit,
    required this.subject_id,
    required this.subject_name,
  });

  SubjecDetailsQuizs copyWith({
    num? id,
    String? name,
    String? description,
    num? time_limit,
    num? subject_id,
    String? subject_name,
  }) {
    return SubjecDetailsQuizs(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      time_limit: time_limit ?? this.time_limit,
      subject_id: subject_id ?? this.subject_id,
      subject_name: subject_name ?? this.subject_name,
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
    };
  }

  factory SubjecDetailsQuizs.fromMap(Map<String, dynamic> map) {
    return SubjecDetailsQuizs(
      id: map['id'] as num,
      name: map['name'] as String,
      description: map['description'] as String,
      time_limit: map['time_limit'] as num,
      subject_id: map['subject_id'] as num,
      subject_name: map['subject_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjecDetailsQuizs.fromJson(String source) => SubjecDetailsQuizs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubjecDetailsQuizs(id: $id, name: $name, description: $description, time_limit: $time_limit, subject_id: $subject_id, subject_name: $subject_name)';
  }

  @override
  bool operator ==(covariant SubjecDetailsQuizs other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.time_limit == time_limit &&
      other.subject_id == subject_id &&
      other.subject_name == subject_name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      time_limit.hashCode ^
      subject_id.hashCode ^
      subject_name.hashCode;
  }
}
