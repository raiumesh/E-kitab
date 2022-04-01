import 'package:book/colors/color_value.dart';
import 'package:book/models/download_model.dart';
import 'package:book/screens/librarydetail_screen.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: downloads.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LibrarydetailScreen()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 19),
                    height: 81,
                    width: MediaQuery.of(context).size.width - 50,
                    color: kBackgroundColor,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 81,
                          width: 62,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: AssetImage(downloads[index].image),
                              ),
                              color: kMainColor),
                        ),
                        const SizedBox(
                          width: 21,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              downloads[index].title,
                              //                             style: GoogleFonts.openSans(
                              //                               fontSize: 16,
                              //                                 fontWeight: FontWeight.w600,
                              //                                 color: kBlackColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              downloads[index].author,
                              //                             style: GoogleFonts.openSans(
                              //                                 fontSize: 12,
                              //                                 fontWeight: FontWeight.w400,
                              //                                 color: kGreyColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
