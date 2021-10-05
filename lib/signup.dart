import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController em = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController mno = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool hide = false;
  var suc = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hide = true;
    suc = "";
  }

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
              Text(
                "Sign Up",
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
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: em,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "Email"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: pass,
                        obscureText: hide,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: Icon(
                                hide ? Icons.visibility_off : Icons.visibility,
                                color: Colors.black,
                              ),
                              onTap: () {
                                hidepassword();
                              },
                            ),
                            border: OutlineInputBorder(),
                            hintText: "Password"),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: TextField(
                    //     controller: mno,
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(),
                    //         hintText: "Mobile Number"),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signup();
                        // sendOTP();
                      },
                      child: const Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 50, right: 50),
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      suc,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    FloatingActionButton(onPressed: (){})
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signup() async {
    try {
      UserCredential usercred = await _auth.createUserWithEmailAndPassword(
          email: em.text, password: pass.text);
      if (usercred.user != null) {
        print(usercred.user!.uid);
        await usercred.user!.sendEmailVerification();
        setState(() {
          suc = "Sign Up Sucessfully";
        });
        em.clear();
        pass.clear();
      } else {
        print("issue creating an user ${usercred}");
      }
    } catch (e) {
      SnackBar snack = SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
      print(e.toString());
    }
  }

  hidepassword() {
    setState(() {
      hide = !hide;
    });
  }
}
