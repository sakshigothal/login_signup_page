import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPFile extends StatefulWidget {
  const OTPFile({Key? key}) : super(key: key);

  @override
  _OTPFileState createState() => _OTPFileState();
}

class _OTPFileState extends State<OTPFile> {
  PhoneAuthCredential? pcred;
  TextEditingController otp1=TextEditingController();
  TextEditingController otp2=TextEditingController();
  TextEditingController otp3=TextEditingController();
  TextEditingController otp4=TextEditingController();
  TextEditingController otp5=TextEditingController();
  TextEditingController otp6=TextEditingController();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdESRDAgPuqqEMZtiqbo890u4Cx8yyl8vxHg&usqp=CAU"),
              fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verify OTP",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black54,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 85,
                        // color: Colors.red,
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            showbox(otp1),
                            SizedBox(width: 10,),
                            showbox(otp2),
                            SizedBox(width: 10,),
                            showbox(otp3),
                            SizedBox(width: 10,),
                            showbox(otp4),
                            SizedBox(width: 10,),
                            showbox(otp5),
                            SizedBox(width: 10,),
                            showbox(otp6),
                          ],
                        )
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (pcred?.smsCode==otp6) {
                            print("sucessful");
                          } else {
                            print("unsucessful");
                          }
                        },
                        child: const Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 50, right: 50),
                          child: Text(
                            "Verify",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showbox(TextEditingController tt) {
    return AspectRatio(
      aspectRatio: 0.5,
      child: TextField(
        controller: tt,
        autofocus: true,
        onChanged: (val) {
          
        },
        readOnly: false,
        showCursor: true,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}


