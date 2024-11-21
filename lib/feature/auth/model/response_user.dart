// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ibnhyanfinal/core/Models/Result.dart';

// ignore: camel_case_types
class user_response extends Result {
  String first_name;
  String last_name;
  String signIn_code;
  user_response({
    required this.first_name,
    required this.last_name,
    required this.signIn_code,
  });

  user_response copyWith({
    String? first_name,
    String? last_name,
    String? signIn_code,
  }) {
    return user_response(
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      signIn_code: signIn_code ?? this.signIn_code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': first_name,
      'last_name': last_name,
      'signIn_code': signIn_code,
    };
  }

  factory user_response.fromMap(Map<String, dynamic> map) {
    return user_response(
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      signIn_code: map['signIn_code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory user_response.fromJson(String source) => user_response.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'user_request(first_name: $first_name, last_name: $last_name, signIn_code: $signIn_code)';

  @override
  bool operator ==(covariant user_response other) {
    if (identical(this, other)) return true;
  
    return 
      other.first_name == first_name &&
      other.last_name == last_name &&
      other.signIn_code == signIn_code;
  }

  @override
  int get hashCode => first_name.hashCode ^ last_name.hashCode ^ signIn_code.hashCode;
}
