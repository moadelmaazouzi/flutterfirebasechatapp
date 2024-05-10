

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_animated_project/chat_screen/chat_screen.dart';
import 'package:my_animated_project/screens/signin_screen.dart';
import 'package:my_animated_project/screens/welcome_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegistrationScreen extends StatefulWidget{
  static const String route='registration_screen';
  @override
  _RegistraionState createState ()=> _RegistraionState();
  
}


class _RegistraionState  extends State<RegistrationScreen>{
  //final _auth=FirebaseAuth.instance;
  bool _showspinner=false;
  late String email;
   late String  password;
   final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(title: Text("registration screen " ),
        actions: [IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.percent_outlined))],
      ),
      body:ModalProgressHUD(inAsyncCall: _showspinner,

       child: 

        Padding(padding: EdgeInsets.symmetric(horizontal: 24 ),
        
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
          
          children: [

            Column(
             
              children: [
                 Container(
                  child: Image.asset('chatLog.jpg' ,width: 180,height:180 ,),
                 ),
                 const Text("MessageMe" ,style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color:  Color.fromARGB(255, 0, 49, 90)
                 ),)
              ],
            ),

            const SizedBox(height: 30,),

            TextField(
              onChanged: (value){
                email=value;
              },
                decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),

                ),
                hintText: 'Enter your email',
                contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 18, 157, 188),width: 1)),
                focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 242, 255, 1),width: 3)),
                
                
              ), 
              
              
), 
            const SizedBox(height: 15,),
            TextField(
              keyboardType: TextInputType.phone,
              obscureText: false,
              onChanged: (value){
                password=value;
              },
                decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),

                ),
                hintText: 'Enter your password',
                
                contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 18, 157, 188),width: 1)),
                focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 242, 255, 1),width: 3)),
                
                
              ), 
              
              
),
            const SizedBox(height: 30,),

           MyButton(color: Color.fromARGB(255, 254, 140, 0), title: 'Register', 
           onPress: () async {
              setState(() {
                      _showspinner=true;
                    });

             try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null) {
                    // L'enregistrement est réussi, naviguez vers une nouvelle page
                    setState(() {
                      _showspinner=false;
                    });
                    Navigator.pushNamed(context, SignInScreen.route);
                    print("vous etes enregistrer email:${email } ,password:${password}");
                    
                  }
                } catch (e) {
                  print(e);
                }
            
              // final newUser =await _auth.createUserWithEmailAndPassword(email: email, password: password);
              
              print("${email}:${password}");

            
          },),
            
            
          ],
        ),
        ),

       )
    );
  }
}