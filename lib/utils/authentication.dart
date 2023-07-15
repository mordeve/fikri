import 'dart:convert';

import 'package:fikri/models/login_data_model.dart';
import 'package:fikri/models/user_model_email.dart';
import 'package:fikri/models/user_model_gmail.dart';
import 'package:fikri/pages/profile_page.dart';
import 'package:fikri/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

class Authentication {
  static Client client = Client();

  static Future<FirebaseApp> initializeFirebase(BuildContext context) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // User? user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => HomePage(
    //         user: user,
    //       ),
    //     ),
    //   );
    // }

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'The account already exists with a different credential',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content: 'Error occurred using Google Sign In. Try again.',
          ),
        );
      }
    }

    if (user != null) {
      final userAcc = UserModelGmail(
        email: user.email!,
        name: user.displayName ?? '',
        profilePic: user.photoURL ?? '',
        uid: '', // Automatically created by MongoDB
      );

      var res = await client.post(
        Uri.parse("$host$gmailSignUpURI"),
        body: userAcc.toJson(),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      switch (res.statusCode) {
        case 200:
          final UserModelGmail newUser = userAcc.copyWith(
            uid: jsonDecode(res.body)['user']['_id'],
          ); // to change a value of class
          print("new user signed in with ${newUser.uid} uid.");
          break;
      }
    }
    return user;
  }

  static Future<UserModelEmail?> signUp(
      {required email, required name, required password}) async {
    UserModelEmail? user;

    final userAcc = UserModelEmail(
      email: email,
      name: name,
      password: password,
      profilePic: '',
      uid: '',
    );

    var res = await client.post(
      Uri.parse("$host$emailSignUpURI"),
      body: userAcc.toJson(),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (res.statusCode) {
      case 200:
        user = userAcc.copyWith(
          uid: jsonDecode(res.body)['user']['_id'],
        ); // to change a value of class
        print("new user signed in with ${user.uid} uid.");
        break;
      case 409:
        user = userAcc.copyWith(
          error: jsonDecode(res.body)['error'],
        );
        break;
    }

    return user;
  }

  static Future<UserModelEmail?> signInWithEmail(
      {required email, required password}) async {
    UserModelEmail? user;

    final userAcc = UserModelEmail(
      email: email,
      name: '',
      password: password,
      profilePic: '',
      uid: '',
    );

    var res = await client.post(
      Uri.parse("$host$emailSignInURI"),
      body: userAcc.toJson(),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (res.statusCode) {
      case 200:
        user = UserModelEmail.fromJson(jsonDecode(res.body)['user'])
            .copyWith(error: jsonDecode(res.body)['error']);
        print("new user signed in with ${user.uid} uid. From email sign in");
        break;
      case 401:
        user = userAcc.copyWith(
          error: jsonDecode(res.body)['error'],
        );
        break;
      case 404:
        user = userAcc.copyWith(
          error: jsonDecode(res.body)['error'],
        );
        break;
    }

    user = user!.copyWith(
      error: jsonDecode(res.body)['error'],
    );
    return user;
  }

  static Future<LoginDataModel> getUserData() async {
    LoginDataModel error = LoginDataModel(
      error: "Some unexpected error occured",
      data: null,
    );
    try {
      var res = await client.get(
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
      }
    } catch (err) {
      error = LoginDataModel(error: err.toString(), data: null);
    }
    return error;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.redAccent,
          letterSpacing: 0.5,
          fontSize: 16,
        ),
      ),
    );
  }
}
