import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelblogapp/screens/blogpage.dart';
import 'package:travelblogapp/screens/loginpage.dart';
import 'package:travelblogapp/screens/userprofilepage.dart';
import 'package:travelblogapp/utils/constants.dart';

class HomePage extends StatefulWidget {
  static const String id = 'homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}


class LandingPage extends StatefulWidget {
  static const String id = "landingpage";
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int selectedIndex = 0;
  String email;

  Future getCurrentUser()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user != null){
      email = user.email;
    }
  }

  void _onItemTaped(int index){
    setState(() {
      selectedIndex = index;
    });
  }
   List<Widget> _widgetOptions = [
   BlogPage(),
   UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTaped,
      ),
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
    );
  }
}
