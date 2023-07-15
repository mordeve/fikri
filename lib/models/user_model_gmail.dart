import 'dart:convert';

class UserModelGmail {
  final String email;
  final String name;
  final String profilePic;
  final String uid;
  UserModelGmail({
    required this.email,
    required this.name,
    required this.profilePic,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
    };
  }

  factory UserModelGmail.fromMap(Map<String, dynamic> map) {
    return UserModelGmail(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      uid: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModelGmail.fromJson(String source) =>
      UserModelGmail.fromMap(json.decode(source));

  UserModelGmail copyWith({
    String? email,
    String? name,
    String? profilePic,
    String? uid,
  }) {
    return UserModelGmail(
      email: email ?? this.email,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
    );
  }
}
