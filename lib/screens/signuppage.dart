import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelblogapp/screens/homepage.dart';
import 'package:travelblogapp/screens/loginpage.dart';



class SignUpPage extends StatefulWidget {
  static const String id = 'signuppage';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email;
  String _password;

  Future<bool>registerUser(String email, String password) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    try{
      AuthResult result = await auth.createUserWithEmailAndPassword(email: _email, password: _password);
      FirebaseUser user = result.user;
      return true;
    }catch(e){
      print(e);
      return false;
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
                Text("Sign Up Page",style: TextStyle(
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
                  color: Colors.blue,
                    child: Text("Sign Up",style: TextStyle(color: Colors.white),),
                    onPressed: () async{
                      bool result = await registerUser(_email, _password);
                      if(result){
                        Navigator.of(context).pushReplacementNamed(HomePage.id);
                      }
                    }
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
                      },
                      child: Text("Login!",
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
