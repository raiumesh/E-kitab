// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../models/globals.dart' as globals;

import '../colors/color_value.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = " ";
  void getcred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
    });
  }

  @override
  void initState() {
    getcred();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.openSans(
              fontSize: 16,
              color: kBackgroundColor,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),
      body: Container(
        height: 200,
        width: 300,
        margin: EdgeInsets.only(left: 30, right: 20, top: 25),
        decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: kMainColor,
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(4, 4))
            ]),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.person,
              size: 65,
              color: Colors.blue,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Welcome",
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  color: kBlackColor,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              username,
              style: GoogleFonts.openSans(
                  fontSize: 13,
                  color: kBlackColor,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
