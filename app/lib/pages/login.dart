// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geneio/components/associate_user.dart';
import 'package:geneio/components/my_button.dart';

import '../components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onPressed;
  const LoginPage({super.key, this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //sign user in
  Future<void> login() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: Color(0xff71935D),
              ),
            ],
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailError();
      } else if (e.code == 'wrong-password') {
        wrongPasswordError();
      }
    }

    //Call the associateUserWithPerson function from associate_user.dart
    //This will create a Person document for the user if it doesn't exist
    //and associate the user with the Person document
    associateUserWithPerson();
  }

  void wrongEmailError() {
    showDialog(
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AlertDialog(
            backgroundColor: Colors.grey[300],
            alignment: Alignment.center,
            title: Center(
                child: const Text(
              "Wrong Email",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 96, 125, 79),
              ),
            )),
            content: const Text("The email you entered is not registered",
                textAlign: TextAlign.center),
            actions: [
              Center(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xff71935D),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void wrongPasswordError() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          alignment: Alignment.center,
          title: Center(
              child: const Text(
            "Wrong Password",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 96, 125, 79),
            ),
          )),
          content: const Text("The password you entered is incorrect",
              textAlign: TextAlign.center),
          actions: [
            Center(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xff71935D),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //ver se quero safearea ou nao, e ver como por o background ate ao fim
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 210.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //logo

                  Image.asset(
                    "lib/images/geneio.png",
                    height: 80,
                  ),

                  //login form

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            //uncover your past
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 50.0, bottom: 30.0),
                              child: Text(
                                "Uncover your past, connect with your present, and explore your future with our genealogy app",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff0C572A),
                                ),
                              ),
                            ),

                            //email
                            MyTextField(
                              controller: emailController,
                              obscureText: false,
                              hintText: "E-mail",
                              prefixIcon: Icon(Icons.email_outlined,
                                  color: Colors.grey[100]),
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            //password
                            MyTextField(
                              controller: passwordController,
                              obscureText: true,
                              hintText: "Password",
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Colors.grey[100]),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Color(0xff3B4436),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            MyButton(
                              text: "Login",
                              onTap: login,
                            ),

                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: Color(0xff3B4436),
                                    fontSize: 15,
                                  ),
                                ),
                                TextButton(
                                  onPressed: widget.onPressed,
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Color(0xff71935D),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
