import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/providers/chat_provider.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/screens/signin_page.dart';
import 'package:scholar_chat/screens/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

bool isSignedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  userIsSignedIn();
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: MaterialApp(
        initialRoute: userIsSignedIn() ? kChatPageId : kSignInPageId,
        routes: {
          kSignInPageId: (context) => const SigninPage(),
          kSignUpPageId: (context) => const SignupPage(),
          kChatPageId: (context) => ChatPage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Scholar Chat',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          textTheme: const TextTheme().copyWith(
            bodySmall: const TextStyle(color: Colors.white),
            bodyMedium: const TextStyle(color: Colors.white),
            bodyLarge: const TextStyle(color: Colors.white),
            labelSmall: const TextStyle(color: Colors.white),
            labelMedium: const TextStyle(color: Colors.white),
            labelLarge: const TextStyle(color: Colors.white),
            displaySmall: const TextStyle(color: Colors.white),
            displayMedium: const TextStyle(color: Colors.white),
            displayLarge: const TextStyle(color: Colors.white),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            primary: Colors.white,
            brightness: Brightness.light,
          ),
        ),
      ),
    );
  }
}

userIsSignedIn() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      log('User is currently signed out!');
      isSignedIn = false;
    } else {
      log('User is signed in!');
      isSignedIn = true;
    }
  });
  return isSignedIn;
}
