import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_animated_project/chat_screen/chat_screen.dart';
import 'package:my_animated_project/screens/welcome_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String route = 'signin_screen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late String _email, _password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showspinner=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(title: Text("Sign In Screen"),
      actions: [IconButton(onPressed: (){
          Navigator.pushNamed(context,WelcomeScreen.route);
        }, icon: Icon(Icons.percent_outlined))],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showspinner,
         child: 

          Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset('chatLog.jpg', width: 180, height: 180),
                ),
                const Text(
                  "MessageMe",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 0, 49, 90)),
                )
              ],
            ),
            const SizedBox(height: 30),
            TextField(
              onChanged: (value) {
                _email = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              onChanged: (value) {
                _password = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 30),
            MyButton(
              color: Color.fromARGB(255, 254, 140, 0),
              title: 'Sign In',
              onPress: () async {
                setState(() {
                  _showspinner=true;
                });

                try {
                  // Connexion de l'utilisateur avec email et mot de passe
                  final user= await _auth.signInWithEmailAndPassword(
                    email: _email,
                    password: _password,
                  );
                  // Si la connexion réussit, naviguez vers l'écran de discussion
                  if(user!=Null){
                    setState(() {
                  _showspinner=false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    );
                  }
                } catch (e) {
                  print("Erreur lors de la connexion: $e");
                }
              },
            ),
          ],
        ),
      ),

         )
    );
  }
}
