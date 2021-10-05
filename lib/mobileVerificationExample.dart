import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileVerificationExample extends StatefulWidget {
  const MobileVerificationExample({Key? key}) : super(key: key);

  @override
  _MobileVerificationExampleState createState() =>
      _MobileVerificationExampleState();
}

class _MobileVerificationExampleState extends State<MobileVerificationExample> {
  TextEditingController no=TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: double.infinity,
        // width: double.infinity,
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
              const Text(
                "Verify Phone Number",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black54,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: no,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Mobile Number"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        sendOTP();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
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
            ],
          ),
        ),
      ),
    );
  }

  sendOTP() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: no.text,
        verificationCompleted: (usercred) {
          print("verification completed ${usercred.smsCode}");
        },
        verificationFailed: (ex) {
          print("verification failed ${ex.message}");
        },
        codeSent: (otp, otp_len) {
          print("code sent");
        },
        codeAutoRetrievalTimeout: (timeout) {
          print("code timeout");
        });
  }
}
