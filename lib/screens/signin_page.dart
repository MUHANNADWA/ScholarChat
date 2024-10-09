import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/widgets/my_button.dart';
import 'package:scholar_chat/widgets/my_text_feild.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      blurEffectIntensity: 4,
      opacity: 0.05,
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
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
                      'Sign in',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                  text: 'Sign in',
                  textColor: kPrimaryColor,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        await signIn();
                        showSnackBar(context, 'Log in Success');
                        Navigator.pushReplacementNamed(context, kChatPageId,
                            arguments: {'email': email});
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-email') {
                          showSnackBar(context, 'The email is invalid');
                        } else if (e.code == 'user-not-found') {
                          showSnackBar(context, 'No user found for that email');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'Wrong password');
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
                    Navigator.pushNamed(context, kSignUpPageId);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do not have an account? '),
                      Text(
                        ' Sign Up',
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

  Future<void> signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
