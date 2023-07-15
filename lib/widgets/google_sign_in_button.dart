import 'package:fikri/models/user_model_email.dart';
import 'package:fikri/pages/product_page.dart';
import 'package:fikri/pages/profile_page.dart';
import 'package:fikri/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  GoogleSignInButtonState createState() => GoogleSignInButtonState();
}

class GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: _isSigningIn
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            )
          : IconButton(
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        user: UserModelEmail.fromGmail(user),
                      ),
                    ),
                  );
                }
              },
              icon: const Image(
                image: AssetImage("assets/images/g-logo-2.png"),
                height: 40.0,
              ),
            ),
    );
  }
}
