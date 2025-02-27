// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ibnhyanfinal/core/Models/Result.dart';

class ResultExam extends Result {
    num result_id;
String image;
  num duration_minutes;
   num score;
        num total_score;
  ResultExam({
    required this.result_id,
    required this.image,
    required this.duration_minutes,
    required this.score,
    required this.total_score,
  });
 

  ResultExam copyWith({
    num? result_id,
    String? image,
    num? duration_minutes,
    num? score,
    num? total_score,
  }) {
    return ResultExam(
      result_id: result_id ?? this.result_id,
      image: image ?? this.image,
      duration_minutes: duration_minutes ?? this.duration_minutes,
      score: score ?? this.score,
      total_score: total_score ?? this.total_score,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'result_id': result_id,
      'image': image,
      'duration_minutes': duration_minutes,
      'score': score,
      'total_score': total_score,
    };
  }

  factory ResultExam.fromMap(Map<String, dynamic> map) {
    return ResultExam(
      result_id: map['result_id'] as num,
      image: map['image'] as String,
      duration_minutes: map['duration_minutes'] as num,
      score: map['score'] as num,
      total_score: map['total_score'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultExam.fromJson(String source) => ResultExam.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResultExam(result_id: $result_id, image: $image, duration_minutes: $duration_minutes, score: $score, total_score: $total_score)';
  }

  @override
  bool operator ==(covariant ResultExam other) {
    if (identical(this, other)) return true;
  
    return 
      other.result_id == result_id &&
      other.image == image &&
      other.duration_minutes == duration_minutes &&
      other.score == score &&
      other.total_score == total_score;
  }

  @override
  int get hashCode {
    return result_id.hashCode ^
      image.hashCode ^
      duration_minutes.hashCode ^
      score.hashCode ^
      total_score.hashCode;
  }
}
