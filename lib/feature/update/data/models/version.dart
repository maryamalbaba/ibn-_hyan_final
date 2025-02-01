// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Version {
  String version_num;
  String version_url;
  Version({
    required this.version_num,
    required this.version_url,
  });

  Version copyWith({
    String? version_num,
    String? version_url,
  }) {
    return Version(
      version_num: version_num ?? this.version_num,
      version_url: version_url ?? this.version_url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version_num': version_num,
      'version_url': version_url,
    };
  }

  factory Version.fromMap(Map<String, dynamic> map) {
    return Version(
      version_num: map['version_num'] as String,
      version_url: map['version_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Version.fromJson(String source) => Version.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Version(version_num: $version_num, version_url: $version_url)';

  @override
  bool operator ==(covariant Version other) {
    if (identical(this, other)) return true;
  
    return 
      other.version_num == version_num &&
      other.version_url == version_url;
  }

  @override
  int get hashCode => version_num.hashCode ^ version_url.hashCode;
}
