import 'dart:io';

import 'package:flutter/material.dart';

class FacebookSignInButton extends StatefulWidget {
  const FacebookSignInButton({super.key});

  @override
  FacebookSignInButtonState createState() => FacebookSignInButtonState();
}

class FacebookSignInButtonState extends State<FacebookSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: _isSigningIn
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
            )
          : IconButton(
              onPressed: () async {
                sleep(const Duration(milliseconds: 1000));
              },
              icon: const Image(
                image: AssetImage("assets/images/facebook-logo.png"),
                height: 40.0,
              ),
            ),
    );
  }
}
