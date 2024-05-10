import 'package:flutter/material.dart';
class HomePage extends StatelessWidget{

  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Container(child: const Text("Annimation"),),),
      body:  Container(
        child: const Column(
          children: [
            ListTile(
              leading: Image(image: AssetImage('1.jpg')),
              title: Text("lofi"),
              trailing: Icon(Icons.next_plan_outlined),
            )
          ],
        ),
      )
    );
  }
  
  
}