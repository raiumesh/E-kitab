// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:book/colors/color_value.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  // final PopularBookModel _popularBookModel;
  // DetailScreen(this._popularBookModel);
  // Future<String> fetchData() async {
  //   String url = "https://major-project-ekitab.herokuapp.com/recs";
  //   http.Response data = await http.post(Uri.parse(url),
  //       body: ({
  //         'username': '074bct519',
  //       }));

  //   return data.body;
  // }

  String title, coverurl, bookurl, author, uicontent;
  int rating;
  DetailScreen(
      {required this.title,
      required this.author,
      required this.bookurl,
      required this.uicontent,
      required this.coverurl,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 15),
        height: 45,
        color: Colors.transparent,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: kMainColor,
          child: Text(
            'Download Books',
            style: GoogleFonts.openSans(
                fontSize: 14, fontWeight: FontWeight.w600, color: kWhiteColor),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: kMainColor,
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                flexibleSpace: Container(
                  color: kMainColor,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 62),
                          width: 172,
                          height: 225,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://major-project-ekitab.herokuapp.com" +
                                      coverurl),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.only(top: 24, left: 25),
                  child: Text(
                    title,
                    style: GoogleFonts.openSans(
                        fontSize: 22,
                        color: kBlackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7, left: 25),
                  child: Text(
                    author,
                    style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: kMainColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                // Container(
                //   height: 28,
                //   margin: EdgeInsets.only(top: 23, bottom: 36),
                //   padding: EdgeInsets.only(left: 25),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: Text(
                    "Description",
                    style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: kBlackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                // DefaultTabController(
                //   length: 2,
                //   child: Container(
                //     child: TabBar(
                //         labelPadding: EdgeInsets.all(0),
                //         indicatorPadding: EdgeInsets.all(0),
                //         indicatorColor: kMainColor,
                //         isScrollable: true,
                //         labelColor: kBlackColor,
                //         unselectedLabelColor: kGreyColor,
                //         // labelStyle: GoogleFonts.openSans(
                //         //     fontSize: 14, fontWeight: FontWeight.w700),
                //         // unselectedLabelStyle: GoogleFonts.openSans(
                //         //     fontSize: 14, fontWeight: FontWeight.w600),
                //         tabs: [
                //           Tab(
                //             child: Container(
                //               margin: EdgeInsets.only(right: 35),
                //               child: Padding(
                //                 padding: const EdgeInsets.only(left: 24),
                //                 child: Text('Description'),
                //               ),
                //             ),
                //           ),
                //           Tab(
                //             child: Container(
                //               margin: EdgeInsets.only(right: 35),
                //               child: Padding(
                //                 padding: const EdgeInsets.only(left: 24),
                //                 child: Text('Reviews'),
                //               ),
                //             ),
                //           ),
                //         ]),
                //   ),
                // ),
                // Container(
                //     child: TabBarView(
                //   children: [
                //     Center(
                //       child: Padding(
                //         padding:
                //             EdgeInsets.only(left: 25, right: 25, bottom: 25),
                //         child: Text(
                //           uicontent,
                //           style: GoogleFonts.openSans(
                //             fontSize: 12,
                //             fontWeight: FontWeight.w400,
                //             color: kGreyColor,
                //             letterSpacing: 1.5,
                //             height: 2,
                //           ),
                //         ),
                //       ),
                //     ),
                //     Center(
                //       child: Padding(
                //         padding:
                //             EdgeInsets.only(left: 25, right: 25, bottom: 25),
                //         child: Text("Reviews"),
                //       ),
                //     ),
                //   ],
                // )),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: Text(
                    uicontent,
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kGreyColor,
                      letterSpacing: 1.5,
                      height: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: Text(
                    "Reviews",
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kBlackColor,
                    ),
                  ),
                ),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
