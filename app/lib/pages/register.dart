// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geneio/components/my_button.dart';

import '../components/associate_user.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onPressed;
  const RegisterPage({super.key, this.onPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  //sign user up
  Future<void> signUp() async {
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
      if (passwordController.text != confirmPasswordController.text) {
        Navigator.pop(context);
        passwordMismatchError();
        return;
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: confirmPasswordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'email-already-in-use') {
        usedEmailError();
        return;
      } else if (e.code == 'weak-password') {
        weakPasswordError();
        return;
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: confirmPasswordController.text,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print(e);
    }

    //Call the associateUserWithPerson function from associate_user.dart
    //This will create a Person document for the user if it doesn't exist
    //and associate the user with the Person document
    associateUserWithPerson();
  }

  void usedEmailError() {
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
              "Used Email",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 96, 125, 79),
              ),
            )),
            content: const Text("The email you entered is already registered",
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

  void weakPasswordError() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          alignment: Alignment.center,
          title: Center(
              child: const Text(
            "Weak Password",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 96, 125, 79),
            ),
          )),
          content: const Text("The password you entered is not strong enough",
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

  void passwordMismatchError() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          alignment: Alignment.center,
          title: Center(
              child: const Text(
            "Passwords don't match",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 96, 125, 79),
            ),
          )),
          content: const Text(
              "The password you entered is different from the one you confirmed",
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0, bottom: 25.0),
                              child: Text(
                                "Let's get started!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
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
                              height: 10,
                            ),

                            //password
                            MyTextField(
                              controller: passwordController,
                              obscureText: true,
                              hintText: "Password",
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Colors.grey[100]),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            //confirm password
                            MyTextField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              hintText: "Confirm Password",
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Colors.grey[100]),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    " ",
                                    style: TextStyle(
                                      color: Color(0xff3B4436),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            MyButton(
                              text: "Register",
                              onTap: signUp,
                            ),

                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    color: Color(0xff3B4436),
                                    fontSize: 15,
                                  ),
                                ),
                                TextButton(
                                  onPressed: widget.onPressed,
                                  child: Text(
                                    "Login here",
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
