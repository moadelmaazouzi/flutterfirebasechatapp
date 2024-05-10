import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_animated_project/chat_screen/chat_screen.dart';
import 'package:my_animated_project/flutterAnnimation/home.dart';
import 'package:my_animated_project/screens/registration_screen.dart';
import 'package:my_animated_project/screens/signin_screen.dart';
import 'package:my_animated_project/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:const FirebaseOptions(
      apiKey: "AIzaSyBqvliaIMw-lE4jclAs7KV-HclnpX_Wt5E",
  authDomain: "messagemeapp-7835c.firebaseapp.com",
  projectId: "messagemeapp-7835c",
  storageBucket: "messagemeapp-7835c.appspot.com",
  messagingSenderId: "966934866430",
  appId: "1:966934866430:web:7bbfda7442f8bf3ea978af"
    )
  ) ;
  
  runApp(MaterialApp(
    title: 'annimation app',
    
    //home: WelcomeScreen(),
    initialRoute: (FirebaseAuth.instance.currentUser==null)? WelcomeScreen.route :ChatScreen.route,
    routes: {
      WelcomeScreen.route:(context)=>WelcomeScreen(),
      SignInScreen.route:(context)=>SignInScreen(),
      RegistrationScreen.route:(context)=>RegistrationScreen(),
      ChatScreen.route:(context)=>ChatScreen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'annimation app',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage()
    );
  }
}







class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
    
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
