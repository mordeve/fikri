import 'dart:io';

import 'package:flutter/material.dart';

class TwitterSignInButton extends StatefulWidget {
  const TwitterSignInButton({super.key});

  @override
  TwitterSignInButtonState createState() => TwitterSignInButtonState();
}

class TwitterSignInButtonState extends State<TwitterSignInButton> {
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
                image: AssetImage("assets/images/twitter-logo.png"),
                height: 40.0,
              ),
            ),
    );
  }
}
