// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructor, prefer_const_constructors, avoid_print
import 'package:book/extramenuscreens/aboutus_screen.dart';
import 'package:book/extramenuscreens/profile_screen.dart';
import 'package:book/extramenuscreens/terms_screen.dart';
import 'package:book/screens/login_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 35),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text("About us"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutusScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.content_paste),
            title: Text("Terms and Condition"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TermsScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
