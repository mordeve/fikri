import 'package:fikri/models/user_model_email.dart';
import 'package:fikri/pages/login_page.dart';
import 'package:fikri/utils/authentication.dart';
import 'package:fikri/utils/colors.dart';
import 'package:fikri/utils/constants.dart';
import 'package:fikri/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final UserModelEmail user;

  const ProfilePage({
    super.key,
    required this.user,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const BaseAppBar(title: "Fikri"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 150,
                height: 150,
                child: widget.user.profilePic != ""
                    ? // add profile picture inside circle avatar
                    CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(widget.user.profilePic),
                      )
                    : const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
                      ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: widget.user.name,
                      onChanged: (value) {
                        widget.user.name = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: widget.user.email,
                      onChanged: (value) {
                        widget.user.email = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.teal,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text("Save"),
                      onPressed: () {
                        // handle save
                      },
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      'You are now signed in. To sign out of your account click the "Sign Out" button below.',
                      style: TextStyle(
                          color: kGreyColor.withOpacity(0.8),
                          fontSize: 14,
                          letterSpacing: 0.2),
                    ),
                    const SizedBox(height: 16.0),
                    _isSigningOut
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.redAccent,
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isSigningOut = true;
                              });
                              await Authentication.signOut(context: context);
                              setState(() {
                                _isSigningOut = false;
                              });
                              if (mounted) {
                                Navigator.of(context)
                                    .pushReplacement(_routeToSignInScreen());
                              }
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.remove(sharedLogged);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                'Sign Out',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
