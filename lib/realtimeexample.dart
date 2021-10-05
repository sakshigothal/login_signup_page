import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealTimeExample extends StatefulWidget {
  const RealTimeExample({Key? key}) : super(key: key);

  @override
  _RealTimeExampleState createState() => _RealTimeExampleState();
}

class _RealTimeExampleState extends State<RealTimeExample> {
  late DatabaseReference dbref;
  late DatabaseReference countref;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final count = 0;

  setup() async {
    UserCredential usercred = await _auth.signInAnonymously();
    print(usercred.user!.uid);
    dbref= FirebaseDatabase.instance.reference();
    countref=FirebaseDatabase.instance.reference().child("counter");
    countref.keepSynced(true);

    countref.onValue.listen((event) {
      print("Event Occured");
     });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Center(
            child: Text("counter ${countref.toString()}"),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              dbref.child("counter").set("1");
            });
          },
          child: Text("+"),
        ));
  }
}
