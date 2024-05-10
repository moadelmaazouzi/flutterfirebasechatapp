import 'package:flutter/material.dart';
import 'package:my_animated_project/screens/registration_screen.dart';
import 'package:my_animated_project/screens/signin_screen.dart';

class WelcomeScreen extends StatefulWidget{
  static const String route='welcome_screen';

  @override
_WelcomeScreenState createState ()=>  _WelcomeScreenState();
  
  
}



class _WelcomeScreenState extends State<WelcomeScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
     // appBar: AppBar(title: Text("my app"),),
      body: 
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
                 Text("MD-Chat" ,style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromARGB(255, 0, 49, 90)
                 ),)
              ],
            ),

            SizedBox(height: 30,),

            Material(
              elevation: 5,
              color: Colors.yellow[900],
              borderRadius: BorderRadius.circular(10),
              child: MyButton(color: Color.fromARGB(255, 136, 243, 6), title: 'sign In', 
              onPress: ()=>{
                Navigator.pushNamed(
              context, SignInScreen.route
            )
              }),
            ),
            SizedBox(height: 20,),
            Material(
              elevation: 5,
              color: Color.fromARGB(255, 170, 26, 199),
              borderRadius: BorderRadius.circular(10),
              
              child: MyButton(color: Color.fromARGB(255, 243, 191, 4), title: 'Register', onPress: ()=>{
                Navigator.pushNamed(
              context,RegistrationScreen.route,
            )
              }),
            )
          ],
        ),
        ),
        
        
      
    );
  }
}

class MyButton extends StatelessWidget{
  
  final Color color;
  final String title;
  final VoidCallback onPress;
  MyButton({  required this.color , required this.title ,required this.onPress});
  @override
  Widget build(BuildContext context) {
    return 
    MaterialButton(
      onPressed :onPress
    , minWidth: 200, 
        
              height: 47, 
              color: this.color,
              child: Text(this.title ,
              style: TextStyle( color:Colors.white ),),);
  } 
  
}