// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/color_value.dart';

class AboutusScreen extends StatefulWidget {
  const AboutusScreen({Key? key}) : super(key: key);

  @override
  State<AboutusScreen> createState() => _AboutusScreenState();
}

class _AboutusScreenState extends State<AboutusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us",
          style: GoogleFonts.openSans(
              fontSize: 18,
              color: kBackgroundColor,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 25),
            child: Text(
              "IOE Engineering Application",
              style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: kBlackColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18, top: 10),
            child: Text(
              "E-kitab is an application that provides full books of all engineering field including civil, computer and aerosapce. This application goal is to facilitate engineering student with their course book. Student can download pdf and epub file of books and read it",
              style: GoogleFonts.openSans(
                  fontSize: 12,
                  color: kBlackColor,
                  height: 2,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 18),
            child: Text(
              "App Info",
              style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: kBlackColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 10),
            child: Text(
              "Version 0.1.1",
              style: GoogleFonts.openSans(
                  fontSize: 12,
                  color: kBlackColor,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
