import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_animated_project/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget{
  static const String route='chat_screen';
  
  
  ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState() ;
}

final _firestore=FirebaseFirestore.instance;
final user=FirebaseAuth.instance.currentUser;
class _ChatScreenState extends State<ChatScreen> {
  late User signInUser;
  
  
  


  String ?_messagetext=' ';

  Future<void> _signOut() async {
    try{
        await FirebaseAuth.instance.signOut();
     var a=FirebaseAuth.instance.currentUser;
        if(a==null)
            
              Navigator.pushNamed(context, WelcomeScreen.route);
            
    print('Déconnexion réussie');
    }catch(e){
      print("error:${e}");
    };
  }
  //gets messages
  void getMessages() async{
    try{
      final messages =await _firestore.collection('messages').get();
      for(var message in messages.docs){
        print(message.data());
      }
    }catch(e){
      print(e);

    }
  }
  void getStreamMessage() async{
     await  for ( var snapshot in _firestore.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        print(message.data());
      }
     }

  }
    //controller text fileld
    final messagetextcontroller=TextEditingController();

  
  
 

  @override
  Widget build(BuildContext context) {
    String email = user != null ? user!.email!.split('@')[0] : '';
    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: Row(
            children: [
                  Image.asset('chatLog.jpg',height: 30,),
                  SizedBox(width: 20,),
                  Text("${email}", style: TextStyle(color: Colors.white),)
            ],
      ) 
        )
      , 
        backgroundColor: Colors.yellow[900],
        actions: [
          IconButton(onPressed: _signOut, icon: Icon(Icons.close)),

          IconButton(onPressed: (){}
          , icon: Icon(Icons.download)),
          
        ],
        
      ),
      body: SafeArea(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MessageStreamBuilder()
              ,


              Container(
                decoration: const BoxDecoration(
                  border:Border( 
                    top :  BorderSide( 
                      color: Colors.orange,
                      width: 2
                    ))
                ),
                child: Row(
                  children: [
                    Expanded(
                      
                      child:  TextField(
                        controller: messagetextcontroller,
                        onChanged: (value){
                          _messagetext=value;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 20),
                          hintText: "write your code here",
                          border: InputBorder.none
                        ),
                      )
                    )
                    ,
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 248, 246, 246),
                        borderRadius: BorderRadius.circular(28)),
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: TextButton(
                        onPressed: (){
                          print("enregistrer les donnes");
                          try{
                            _firestore.collection('messages').add(
                            {
                              'text':_messagetext ,
                              'sender':user!.email,
                              'time':FieldValue.serverTimestamp()
                            }
                            
                          );
                          messagetextcontroller.clear();
                          }catch(e){

                          };
                      }, 
                      child:const  Text("send" ,style: TextStyle(
                        color: Color.fromARGB(255, 128, 3, 128)
                        ,fontSize: 16,
                        fontFamily: "Trebuchet MS"
                      ), )) ),
                  ],
                  
                ) ,
                )



            ],
          )
        )
    );
  }
}
 class MessageStreamBuilder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').orderBy('time').snapshots(), 
                builder: (context,snapshot){
                  List <MessageLine> messageswidget=[]; 
                  if(!snapshot.hasData){
                    
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.amber[700],
                      ),
                    );

                  }
                  final messages= snapshot.data!.docs.reversed;
                  
                  for(var message in messages){
                    final messagetext= message.get('text');
                    final sender= message.get('sender');
                    messageswidget.add(MessageLine(text: messagetext,sender: sender,isMe: sender==user!.email,)
                      );

                  }

                  return Expanded(child: 
                    ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    children: messageswidget

                    
                  )
                  );
                });
  }
  
 }


class MessageLine extends StatelessWidget{
  const MessageLine({super.key, required this.sender, required this.text, required this.isMe});
  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
   return Padding(padding: EdgeInsets.all(15),
   child: Column(
    crossAxisAlignment:isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
    children: [
      Text("${sender}" ,style: const TextStyle(fontSize: 15,color: Color.fromARGB(255, 106, 106, 103)),),
       Material(
        elevation: 6,
        borderRadius: isMe? const BorderRadius.only(
          topLeft: Radius.circular(30),bottomLeft: Radius.circular(30), bottomRight:Radius.circular(30)
        ):
        const BorderRadius.only(
          topRight: Radius.circular(30),bottomLeft: Radius.circular(30), bottomRight:Radius.circular(30)
        ),
        color: (!isMe)?Colors.white: Colors.blue,
        child:Padding(
          
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child:Text("${text}",
                      style:TextStyle(color: !isMe?const Color.fromARGB(255, 62, 62, 62): Colors.white) ,
                      ) ,) ,
   )
    ],
   )
   
   ,);
  }
  
}