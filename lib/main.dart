import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/screens/signin_page.dart';
import 'package:scholar_chat/screens/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: kSignInPageId,
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
    );
  }
}
