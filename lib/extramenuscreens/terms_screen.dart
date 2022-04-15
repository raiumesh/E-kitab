import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/color_value.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terms and Conditions",
          style: GoogleFonts.openSans(
              fontSize: 16,
              color: kBackgroundColor,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),
      body: Container(
        height: 400,
        width: 500,
        margin: EdgeInsets.only(left: 25, right: 25, top: 25),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 65, bottom: 15),
              child: Text(
                "Terms and Conditions",
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: kBlackColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "1. E-kitab will use user's credentials for recomendation and offical use only.",
                style: GoogleFonts.openSans(
                    fontSize: 13,
                    color: kBlackColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "2. Businesses and organization pay us to show you ads for their product. By using this app you agree that we can show you ads that we think will be relevant to you.",
                style: GoogleFonts.openSans(
                    fontSize: 13,
                    color: kBlackColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "3. No one in anyway should use E-kitab for illegal purposes, to cheat, scam and fraud",
                style: GoogleFonts.openSans(
                    fontSize: 13,
                    color: kBlackColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "4. For any fraudulent activities committed through E-kitab, the user will solely be held liable.",
                style: GoogleFonts.openSans(
                    fontSize: 13,
                    color: kBlackColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "5. E-kitab reserves the right to revise these Terms and Conditions of Use at any time.",
                style: GoogleFonts.openSans(
                    fontSize: 13,
                    color: kBlackColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
