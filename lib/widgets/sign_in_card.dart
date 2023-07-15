import 'package:fikri/models/user_model_email.dart';
import 'package:fikri/pages/product_page.dart';
import 'package:fikri/pages/profile_page.dart';
import 'package:fikri/utils/authentication.dart';
import 'package:fikri/utils/colors.dart';
import 'package:fikri/utils/constants.dart';
import 'package:fikri/widgets/facebook_sign_in_button.dart';
import 'package:fikri/widgets/google_sign_in_button.dart';
import 'package:fikri/widgets/twitter_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInCard extends StatefulWidget {
  const SignInCard(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  SignInCardState createState() => SignInCardState();
}

class SignInCardState extends State<SignInCard> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  final String defUser = "fikri";
  final String defPassword = "fikri";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 170, 107, 138),
            offset: Offset(5, 5),
            blurRadius: 8,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Color.fromARGB(255, 83, 51, 76),
            offset: Offset(-4, 4),
            blurRadius: 15,
            spreadRadius: 1,
          )
        ],
        color: kSignInCardColor,
        borderRadius: BorderRadius.circular(40),
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
                    "Sign In",
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
                              horizontal: 30.0, vertical: 20),
                          child: Container(
                            padding: const EdgeInsets.all(2),
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
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Could not be empty';
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.black),
                              controller: widget.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Email"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30.0),
                          child: Container(
                            padding: const EdgeInsets.all(2),
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
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Could not be empty';
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.black),
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
              if (_formKey.currentState!.validate()) {
                if (widget.emailController.text == defUser &&
                    widget.passwordController.text == defPassword) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        user: UserModelEmail.defaultUser,
                      ),
                    ),
                  );
                } else {
                  UserModelEmail? resp = await Authentication.signInWithEmail(
                    email: widget.emailController.text,
                    password: widget.passwordController.text,
                  );
                  if (resp!.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      Authentication.customSnackBar(
                        content: resp.error!,
                      ),
                    );
                  } else {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool(sharedLogged, true);
                    prefs.setString(sharedUserEmail, resp.email);
                    prefs.setString(sharedUserPassword, resp.password);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ProductPage(
                          user: resp,
                        ),
                      ),
                    );
                  }
                }
              }
            },
            child: const Text(
              "Sign In",
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
