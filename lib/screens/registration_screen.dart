import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../components/roundedButton.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class RegistrationScreen extends StatefulWidget {
  String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;

  final _auth = FirebaseAuth.instance;

  Future<void> getFuture() async {
    // Perform your long-running operation here
    await Future.delayed(Duration(seconds: 3)); // Simulate a 5-second delay
  }

  void showBuffer(){
    showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        getFuture().then((_) => Navigator.of(context).pop()),
        message: Text('Loading...'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  KTextFieldDecoration.copyWith(hintText: 'Enter email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration:
                  KTextFieldDecoration.copyWith(hintText: 'Enter password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                text: 'Register',
                onPressed: () async {
                  setState(() {
                    showBuffer();
                  });
                  try{
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if(newUser != null){
                      Navigator.pushReplacementNamed(context, ChatScreen().id);
                    }
                  }
                  catch(e){
                    print(e);
                  }
                },
                colour: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}
