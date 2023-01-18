import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/homescreen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<User?> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);

      return user;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/wallpaper2.jpeg'), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 400,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "sign In to Continue",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Text(
                      "Foodie ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          shadows: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.green,
                              spreadRadius: 10,
                              offset: Offset(2, 2),
                            )
                          ]),
                    ),
                    Column(
                      children: [
                        SignInButton(
                          Buttons.Apple,
                          text: "Sign in with Apple",
                          onPressed: () {},
                        ),
                        SignInButton(
                          Buttons.Google,
                          text: "Sign in with Google",
                          onPressed: () {
                            _googleSignUp().then(
                              (value) => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        Text(
                          "By signing in ur are agreeing to our ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              shadows: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                )
                              ]),
                        ),
                        Text(
                          "Terms and Policy ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              shadows: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                )
                              ]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}