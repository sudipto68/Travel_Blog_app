import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:travelblogapp/screens/homepage.dart';
import 'package:travelblogapp/screens/signuppage.dart';
import 'package:travelblogapp/utils/constants.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'loginpage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();



  Future<FirebaseUser>loginUser(String email, String password)async{
    FirebaseAuth auth = FirebaseAuth.instance;
    try{
      AuthResult result = await auth.signInWithEmailAndPassword(email: _email, password: _password);
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Travel Blog",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontFamily: 'Galada',
                    fontSize: 28.0
                  ),
                ),
                SizedBox(height: 40.0,),

                Text("Login Page",style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                ),
                ),
                SizedBox(height: 40.0,),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Email",
                  ),
                  onChanged: (value){
                    setState((){
                      _email =value;
                    });
                  },
                ),
                SizedBox(height: 20.0,),
                TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Password",

                  ),
                  onChanged: (value){
                    setState((){
                      _password =value;
                    });
                  },
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  color: Colors.blueAccent,
                    child: Text("Login",style: TextStyle(color: Colors.white),),
                    onPressed: () async{
                      FirebaseUser user = await loginUser(_email, _password);
                      Constants.preferences.setBool("loggedIn", true);
                      if(user != null){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
                      }
                    }
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't Have an Account?",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 1.0),
                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignUpPage()));
                      },
                      child: Text("Sign Up !",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
