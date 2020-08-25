import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:travelblogapp/screens/loginpage.dart';
import 'package:travelblogapp/utils/constants.dart';

class UserProfilePage extends StatefulWidget {
  static const String id = "userprofilepage";

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                return Column(
                  children: <Widget>[
                    Text("User Info",style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold) ),
                    SizedBox(height: 30.0),
                    CircleAvatar(
                      child: Icon(Icons.person,size: 42.0,),
                      radius: 34.0,
                    ),
                    SizedBox(height: 20.0),
                    Text('User email : ${snapshot.data.email}', style: TextStyle(fontSize: 18.0),),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      child: Text("Log Out",style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        FirebaseAuth.instance.signOut();
                        Constants.preferences.setBool("loggedIn", false);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
                      },
                      color: Colors.redAccent,
                    ),
                  ],
                );
              }else
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
            },
          ),
        ],
      ),
    );
  }
}
