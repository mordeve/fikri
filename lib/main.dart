import 'package:fikri/models/user_model_email.dart';
import 'package:fikri/pages/profile_page.dart';
import 'package:fikri/pages/login_page.dart';
import 'package:fikri/utils/authentication.dart';
import 'package:fikri/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const FikriApp());
}

class FikriApp extends StatelessWidget {
  const FikriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fikri',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryAppColor,
      ),
      home: FutureBuilder(
        future: Authentication.initializeFirebase(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error initializing app (firebase)');
          } else if (snapshot.connectionState == ConnectionState.done) {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              return ProfilePage(user: UserModelEmail.fromGmail(user));
            } else {
              return const LoginPage();
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  kRedColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
