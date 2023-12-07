import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flashchat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthHandler(),
      routes: {
        WelcomeScreen().id: (context) => WelcomeScreen(),
        LoginScreen().id: (context) => LoginScreen(),
        RegistrationScreen().id: (context) => RegistrationScreen(),
        ChatScreen().id: (context) => ChatScreen(),
      },
    );
  }
}

class AuthHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
        } else {
          if (snapshot.hasData) {
            return ChatScreen(); // Navigate to ChatScreen for authenticated users
          } else {
            return LoginScreen(); // Navigate to LoginScreen for unauthenticated users
          }
        }
      },
    );
  }
}

