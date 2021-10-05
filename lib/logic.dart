import 'package:flutter/material.dart';

class LogicExample extends StatefulWidget {
  const LogicExample({ Key? key }) : super(key: key);

  @override
  _LogicExampleState createState() => _LogicExampleState();
}

class _LogicExampleState extends State<LogicExample> {
  int a=10;
int b=20;
  // var str="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // printsome();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(onPressed: (){
          // printsome();
        }),
      )
    );
  }

  // printsome(){
  //  if(b!=a){
  //    b=a;
  //  } 
  //   else if()
  // }
}