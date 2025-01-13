// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AnswerModel {
  final num? id;
  final String? answer_text;
  final num? is_correct;
  final String? answer_image;
  AnswerModel({
    this.id,
    this.answer_text,
    this.is_correct,
    this.answer_image,
  });

  AnswerModel copyWith({
    num? id,
    String? answer_text,
    num? is_correct,
    String? answer_image,
  }) {
    return AnswerModel(
      id: id ?? this.id,
      answer_text: answer_text ?? this.answer_text,
      is_correct: is_correct ?? this.is_correct,
      answer_image: answer_image ?? this.answer_image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'answer_text': answer_text,
      'is_correct': is_correct,
      'answer_image': answer_image,
    };
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      id: map['id'] != null ? map['id'] as num : null,
      answer_text: map['answer_text'] != null ? map['answer_text'] as String : null,
      is_correct: map['is_correct'] != null ? map['is_correct'] as num : null,
      answer_image: map['answer_image'] != null ? map['answer_image'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerModel.fromJson(String source) => AnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnswerModel(id: $id, answer_text: $answer_text, is_correct: $is_correct, answer_image: $answer_image)';
  }

  @override
  bool operator ==(covariant AnswerModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.answer_text == answer_text &&
      other.is_correct == is_correct &&
      other.answer_image == answer_image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      answer_text.hashCode ^
      is_correct.hashCode ^
      answer_image.hashCode;
  }
}
