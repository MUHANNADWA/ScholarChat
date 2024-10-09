import 'dart:developer' as dev;
import 'dart:math';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/widgets/my_button.dart';
import 'package:scholar_chat/widgets/my_text_feild.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? email;
  String? name;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  final CollectionReference users =
      FirebaseFirestore.instance.collection(kUsersCollection);
  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      blurEffectIntensity: 4,
      opacity: 0.05,
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Image.asset(kLogo),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontFamily: 'pacifico',
                  ),
                ),
                const Spacer(flex: 2),
                const Row(
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MyTextFeild(
                  hint: 'Name',
                  onChanged: (value) {
                    name = value;
                  },
                ),
                const SizedBox(height: 10),
                MyTextFeild(
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(height: 10),
                MyTextFeild(
                  hint: 'Password',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 20),
                MyButton(
                  text: 'Sign Up',
                  textColor: kSecondaryColor,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        await signUp();
                        showSnackBar(context, 'Sign up Success');
                        Navigator.pushNamedAndRemoveUntil(
                            context, kChatPageId, (route) => false,
                            arguments: {'email': email});
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              'The account already exists for that email');
                        } else if (e.code == 'invalid-email') {
                          showSnackBar(context, 'The email is invalid');
                        } else if (e.code == 'weak-password') {
                          showSnackBar(
                              context, 'The password provided is too weak');
                        } else {
                          showSnackBar(context,
                              'Plaese check your internet connection, or try to turn on vpn');
                        }
                      } catch (e) {
                        showSnackBar(context,
                            'Something went wrong, please try again later');
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? '),
                      Text(
                        ' Sign in',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    await addUser();
  }

  addUser() {
    users
        .add({
          kUserName: name,
          kUserColor: kUserColors[Random().nextInt(kUserColors.length)],
          kId: email,
        })
        .then((_) => dev.log('user $name added'))
        .catchError((error) => dev.log("Failed to add user: $error"));
  }
}
