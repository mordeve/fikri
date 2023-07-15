import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserModelEmail {
  late final String email;
  late final String name;
  final String profilePic;
  final String uid;
  final String password;
  final String? error;
  UserModelEmail({
    required this.email,
    required this.name,
    required this.profilePic,
    required this.uid,
    required this.password,
    this.error,
  });

  static UserModelEmail defaultUser = UserModelEmail(
      email: "fikri",
      name: "fikriDev",
      profilePic: "",
      uid: "123",
      password: "fikri");

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
      'password': password,
      'error': error,
    };
  }

  factory UserModelEmail.fromMap(Map<String, dynamic> map) {
    return UserModelEmail(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      uid: map['_id'] ?? '',
      password: map['password'] ?? '',
      error: map['error'] ?? '',
    );
  }

  factory UserModelEmail.fromGmail(User userG) {
    return UserModelEmail(
      email: userG.email ?? '',
      name: userG.displayName ?? '',
      profilePic: userG.photoURL ?? '',
      uid: userG.uid,
      password: '',
      error: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModelEmail.fromJson(Map<String, dynamic> json) {
    return UserModelEmail(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      profilePic: json['profilePic'] ?? '',
      uid: json['_id'] ?? '',
      password: json['password'] ?? '',
    );
  }

  UserModelEmail copyWith({
    String? email,
    String? displayName,
    String? profilePic,
    String? uid,
    String? password,
    String? error,
  }) {
    return UserModelEmail(
      email: email ?? this.email,
      name: displayName ?? name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }
}
