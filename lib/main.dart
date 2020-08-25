import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelblogapp/screens/homepage.dart';
import 'package:travelblogapp/screens/loginpage.dart';
import 'package:travelblogapp/screens/signuppage.dart';
import 'package:travelblogapp/screens/userprofilepage.dart';
import 'package:travelblogapp/utils/constants.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Constants.preferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}


class MyApp extends StatefulWidget{

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Travel Blog",
      debugShowCheckedModeBanner: false,
      home:  Constants.preferences.getBool("loggedIn")==true?HomePage():LoginPage(),
      routes: {
        LoginPage.id : (context)=> LoginPage(),
        SignUpPage.id:(context)=> SignUpPage(),
        HomePage.id:(context)=>HomePage(),
      },
    );
  }
}
