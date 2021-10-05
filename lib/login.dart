import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_page/forgotpassword.dart';
import 'package:login_signup_page/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController em = TextEditingController();
  TextEditingController pass = TextEditingController();
  // TextEditingController mbo = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential? usercred;
  bool hide = false;
  var suc="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hide=true;
    suc="";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Login Page"),),
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
                "Login",
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
                              onTap: () {
                                
                                showpass();
                              },
                              child: Icon(hide?
                                Icons.visibility_off : Icons.visibility,
                                color: Colors.black,
                              ),
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
                    //     controller: mbo,
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(), hintText: "Mobile Number"),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            child: Text("Forgot Password"),
                            onTap: () {
                              print("bnvnhg");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext ctx) =>
                                      ForgotPassword(),
                                ),
                              );
                            }),
                        SizedBox(width: 15)
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:[
                        ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: const Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 38, right: 38),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        logout();
                      },
                      child: const Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 30, right: 30),
                        child: Text(
                          "Logout",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                    ),
                      ]
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      child: Text(
                        "You dont have an Account SignUp",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext ctx) => SignUp(),
                          ),
                        );
                      },
                    ),
                    Text(suc,style:TextStyle(fontSize: 35,fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    try {
      usercred = await _auth.signInWithEmailAndPassword(
          email: em.text, password: pass.text);
      if (usercred?.user != null) {
        print(usercred?.user?.uid);
        print("isEmailVerified ${usercred?.user!.emailVerified}");
        setState(() {
          suc="Login Sucessfully";
        });
        // if (usercred?.user!.emailVerified == true) {
        //   alertdialog("Details Save Sucessfully");
        // } else {
        //   alertdialog("Please Try Again");
        // }
      } else {
        print("issue creating an user  ${usercred}");
      }
    } catch (e) {
      SnackBar snack = SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
  }

  showpass() {
    setState(() {
      hide = !hide;
    });
  }

  logout(){
    _auth.signOut();
    setState(() {
      suc="Logout Sucessfully";
    });
    pass.clear();
    em.clear();
  }
}
