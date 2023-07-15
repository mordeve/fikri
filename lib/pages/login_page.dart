import 'package:fikri/models/user_model_email.dart';
import 'package:fikri/pages/product_page.dart';
import 'package:fikri/utils/authentication.dart';
import 'package:fikri/utils/colors.dart';
import 'package:fikri/utils/constants.dart';
import 'package:fikri/widgets/sign_in_card.dart';
import 'package:fikri/widgets/sign_up_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool activeCard = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController signUpUsernameController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpPasswordConfirmController =
      TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await checkLoginStatus();
    FlutterNativeSplash.remove();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(sharedLogged) ?? false;
    String userEmail = prefs.getString(sharedUserEmail) ?? '';
    String userPassword = prefs.getString(sharedUserPassword) ?? '';
    if (isLoggedIn) {
      UserModelEmail? resp = await Authentication.signInWithEmail(
        email: userEmail,
        password: userPassword,
      );
      if (resp!.error != null) {
        prefs.setBool(sharedLogged, false);
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content: resp.error!,
          ),
        );
      } else {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPinkColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 275,
                      ),
                    ),
                    Text(
                      "Fikri",
                      style: GoogleFonts.b612(
                        fontSize: 48,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        activeCard = !activeCard;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              scale: animation, child: child);
                        },
                        child: activeCard
                            ? SignUpCard(
                                usernameController: signUpUsernameController,
                                passwordController: signUpPasswordController,
                                passwordConfirmController:
                                    signUpPasswordConfirmController,
                                emailController: signUpEmailController,
                              )
                            : SignInCard(
                                emailController: emailController,
                                passwordController: passwordController,
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: activeCard
                          ? SignInCard(
                              emailController: emailController,
                              passwordController: passwordController,
                            )
                          : SignUpCard(
                              usernameController: signUpUsernameController,
                              passwordController: signUpPasswordController,
                              passwordConfirmController:
                                  signUpPasswordConfirmController,
                              emailController: signUpEmailController,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
