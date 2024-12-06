// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ibnhyanfinal/core/Models/Result.dart';
import 'package:ibnhyanfinal/feature/auth/model/response_user.dart';

class RespoonseModel extends Result {
  user_response user;
  String token;
  RespoonseModel({
    required this.user,
    required this.token,
  });

  RespoonseModel copyWith({
    user_response? user,
    String? token,
  }) {
    return RespoonseModel(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'token': token,
    };
  }

  factory RespoonseModel.fromMap(Map<String, dynamic> map) {
    return RespoonseModel(
      user: user_response.fromMap(map['user'] as Map<String,dynamic>),
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

 factory RespoonseModel.fromJson(dynamic source) {
  if (source is String && source.isNotEmpty) {
    try {
      // فك الشيفرة الأولى
      final decoded = json.decode(source);

      // إذا كانت النتيجة سلسلة نصية، فكها مرة أخرى
      if (decoded is String) {
        final innerDecoded = json.decode(decoded);
        return RespoonseModel.fromMap(innerDecoded);
      } else if (decoded is Map<String, dynamic>) {
        return RespoonseModel.fromMap(decoded);
      } else {
        throw ArgumentError('Decoded JSON is not valid.');
      }
    } catch (e) {
      throw ArgumentError('Failed to decode JSON: $e');
    }
  } else if (source is Map<String, dynamic>) {
    return RespoonseModel.fromMap(source);
  } else {
    throw ArgumentError(
        'Invalid JSON source: must be a non-empty String or Map<String, dynamic>');
  }
}



  @override
  String toString() => 'RespoonseModel(user: $user, token: $token)';

  @override
  bool operator ==(covariant RespoonseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.user == user &&
      other.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
}
