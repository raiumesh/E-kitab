import 'package:book/extrascreens/morebook_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/color_value.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

var semesterLists = [
  'Semester 1',
  'Semester 2',
  'Semester 3',
  'Semester 4',
  'Semester 5',
  'Semester 6',
  'Semester 7',
  'Semester 8',
];

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: semesterLists.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                title: Text(
                  semesterLists[index],
                  style: GoogleFonts.openSans(
                      color: kBlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MorebookDetail(index)),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
