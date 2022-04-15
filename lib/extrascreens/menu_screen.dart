// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructor, prefer_const_constructors, avoid_print
import 'package:book/colors/color_value.dart';
import 'package:book/extramenuscreens/aboutus_screen.dart';
import 'package:book/extramenuscreens/profile_screen.dart';
import 'package:book/extramenuscreens/terms_screen.dart';
import 'package:book/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          Card(
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: kMainColor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              title: Text(
                "Profile",
                style: GoogleFonts.openSans(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.info,
                color: kMainColor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              title: Text(
                "About us",
                style: GoogleFonts.openSans(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutusScreen()));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.content_paste,
                color: kMainColor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              title: Text(
                "Terms and Condition",
                style: GoogleFonts.openSans(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TermsScreen()));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: kMainColor,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              title: Text(
                "Logout",
                style: GoogleFonts.openSans(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
