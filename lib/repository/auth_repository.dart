import 'dart:convert';

import 'package:fikri/models/login_data_model.dart';
import 'package:fikri/models/user_model_gmail.dart';
import 'package:fikri/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
  ),
);

final userProvider =
    StateProvider<UserModelGmail?>((ref) => null); // To modify values

class AuthRepository {
  final GoogleSignIn _googleSignIn; // private value
  final Client _client;

  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
  })  : _googleSignIn = googleSignIn,
        _client = client;

  Future<LoginDataModel> signInWithGoogle() async {
    LoginDataModel error =
        LoginDataModel(error: "Some unexpected error occured", data: null);
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = UserModelGmail(
          email: user.email,
          name: user.displayName ?? '',
          profilePic: user.photoUrl ?? '',
          uid: '', // Automatically created by MongoDB
        );

        var res = await _client.post(
          Uri.parse("$host/api/signup"),
          body: userAcc.toJson(),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
            ); // to change a value of class
            error = LoginDataModel(error: null, data: newUser);
            break;
        }
      }
    } catch (err) {
      error = LoginDataModel(error: err.toString(), data: null);
    }
    return error;
  }

  Future<LoginDataModel> getUserData() async {
    LoginDataModel error = LoginDataModel(
      error: "Some unexpected error occured",
      data: null,
    );
    try {
      var res = await _client.get(
        Uri.parse("$host/"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      switch (res.statusCode) {
        case 200:
          final newUser = UserModelGmail.fromJson(
            jsonEncode(jsonDecode(res.body)['user']),
          );

          error = LoginDataModel(error: null, data: newUser);
          break;
        case 409:
          error = LoginDataModel(error: res.body.toString(), data: null);
      }
    } catch (err) {
      error = LoginDataModel(error: err.toString(), data: null);
    }
    return error;
  }

  void signOut() async {
    await _googleSignIn.signOut();
    await _googleSignIn.disconnect();
  }
}
