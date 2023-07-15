import 'package:fikri/models/user_model_email.dart';
import 'package:fikri/utils/authentication.dart';
import 'package:fikri/utils/colors.dart';
import 'package:fikri/widgets/facebook_sign_in_button.dart';
import 'package:fikri/widgets/google_sign_in_button.dart';
import 'package:fikri/widgets/twitter_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpCard extends StatefulWidget {
  const SignUpCard(
      {Key? key,
      required this.usernameController,
      required this.passwordController,
      required this.passwordConfirmController,
      required this.emailController})
      : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final TextEditingController emailController;

  @override
  SignUpCardState createState() => SignUpCardState();
}

class SignUpCardState extends State<SignUpCard> {
  late FocusNode _focusNode;
  bool hidePassword = true;
  bool isPasswordEqual = true;
  bool isEmailValid = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          isEmailValid = widget.emailController.text.isValidEmail();
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSignUpCardColor,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 170, 107, 138),
            offset: Offset(5, 5),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Color.fromARGB(255, 83, 51, 76),
            offset: Offset(-4, 4),
            blurRadius: 8,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.robotoSerif(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 221, 142, 168),
                                    offset: Offset(5, 5),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color: Color.fromARGB(255, 249, 185, 208),
                                    offset: Offset(-4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  )
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                focusNode: _focusNode,
                                autofocus: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Could not be empty";
                                  }
                                  if (!value.isValidEmail()) {
                                    return "Email is not valid";
                                  }
                                  return null;
                                },
                                controller: widget.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(Icons.email),
                                    errorText: isEmailValid
                                        ? null
                                        : "Email is not valid",
                                    hintText: "Email"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 221, 142, 168),
                                    offset: Offset(5, 5),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color: Color.fromARGB(255, 249, 185, 208),
                                    offset: Offset(-4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  )
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Could not be empty";
                                  } else if (!value.isValidUsername()) {
                                    return "Username is not valid";
                                  }
                                  return null;
                                },
                                controller: widget.usernameController,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Name"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 221, 142, 168),
                                    offset: Offset(5, 5),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color: Color.fromARGB(255, 249, 185, 208),
                                    offset: Offset(-4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  )
                                ]),
                            child: SizedBox(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Could not be empty";
                                    }
                                    return null;
                                  },
                                  obscureText: hidePassword,
                                  controller: widget.passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon((hidePassword)
                                            ? Icons.remove_red_eye
                                            : Icons.cancel),
                                        onPressed: () => setState(
                                            () => hidePassword = !hidePassword),
                                      ),
                                      border: InputBorder.none,
                                      prefixIcon: const Icon(Icons.password),
                                      hintText: "Password"),
                                  onChanged: (value) {
                                    setState(() {
                                      isPasswordEqual =
                                          widget.passwordController.text ==
                                              value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 221, 142, 168),
                                    offset: Offset(5, 5),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color: Color.fromARGB(255, 249, 185, 208),
                                    offset: Offset(-4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  )
                                ]),
                            child: SizedBox(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Could not be empty";
                                    }
                                    return null;
                                  },
                                  obscureText: hidePassword,
                                  controller: widget.passwordConfirmController,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                      errorText: isPasswordEqual
                                          ? null
                                          : "Passwords are not equal",
                                      suffixIcon: IconButton(
                                        icon: Icon((hidePassword)
                                            ? Icons.remove_red_eye
                                            : Icons.cancel),
                                        onPressed: () => setState(
                                            () => hidePassword = !hidePassword),
                                      ),
                                      border: InputBorder.none,
                                      prefixIcon: const Icon(Icons.password),
                                      hintText: "Confirm Password"),
                                  onChanged: (value) {
                                    setState(() {
                                      isPasswordEqual =
                                          widget.passwordController.text ==
                                              value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate() && isPasswordEqual) {
                UserModelEmail? resp = await Authentication.signUp(
                  email: widget.emailController.text,
                  name: widget.usernameController.text,
                  password: widget.passwordController.text,
                );
                if (resp!.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    Authentication.customSnackBar(
                      content: 'This email account is already registered',
                    ),
                  );
                }
              }
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              children: [
                const Text(
                  "Or continue with",
                  style: TextStyle(
                      color: kBlackColor, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    GoogleSignInButton(),
                    TwitterSignInButton(),
                    FacebookSignInButton(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension SignUpValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidUsername() {
    return RegExp(r'^(?=.{4,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$')
        .hasMatch(this);
  }
}
