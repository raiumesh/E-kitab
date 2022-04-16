import 'package:book/extrascreens/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/color_value.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 35),
        children: <Widget>[
          Card(
            child: ListTile(
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              title: Text(
                "Computer Engineering",
                style: GoogleFonts.openSans(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookDetail()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              title: Text(
                "Civil Engineering",
                style: GoogleFonts.openSans(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              title: Text(
                "Aerospace Engineering",
                style: GoogleFonts.openSans(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              title: Text(
                "Automobile Engineering",
                style: GoogleFonts.openSans(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              title: Text(
                "Electrical Engineering",
                style: GoogleFonts.openSans(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              title: Text(
                "Electronics Engineering",
                style: GoogleFonts.openSans(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              title: Text(
                "Mechanical Engineering",
                style: GoogleFonts.openSans(
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
