import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../colors/color_value.dart';
import '../models/search_model.dart';
import '../screens/homedetail_screen.dart';

class MorebookDetail extends StatefulWidget {
  final int sem;
  MorebookDetail(this.sem);
  @override
  State<MorebookDetail> createState() => _MorebookDetailState();
}

class _MorebookDetailState extends State<MorebookDetail> {
  @override
  void initState() {
    getcred();
    getsem(widget.sem);
    super.initState();
  }

  String username = " ";
  void getcred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
    });
    print(username);
  }

  List<SearchModel> _searchmodel = [];
  getsem(sem) async {
    var value = sem + 1;
    print(value);
    var response = await http.get(Uri.parse(
        'https://major-project-ekitab.herokuapp.com/sem?sem=' +
            value.toString()));
    final List<SearchModel> searchModel = searchModelFromJson(response.body);
    setState(() {
      _searchmodel = searchModel;
    });
  }

  void logandscreen(title, uicontent, coverurl, bookurl, author, rating) async {
    String url = "https://major-project-ekitab.herokuapp.com/savelog";
    http.Response data1 = await http.post(Uri.parse(url),
        body: ({
          'username': username,
          'title': title,
        }));
    print(username);
    print(title);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailScreen(
              title: title,
              uicontent: uicontent,
              coverurl: coverurl,
              bookurl: bookurl,
              author: author,
              rating: rating)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        child: ListView.builder(
            padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
            itemCount: _searchmodel.length,
            itemBuilder: (context, index) {
              SearchModel searchData = _searchmodel[index];
              return GestureDetector(
                onTap: () {
                  logandscreen(
                      searchData.title,
                      searchData.uicontent,
                      searchData.coverurl,
                      searchData.bookurl,
                      searchData.author,
                      searchData.rating);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 19),
                  height: 80,
                  width: MediaQuery.of(context).size.width - 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 81,
                          width: 62,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://major-project-ekitab.herokuapp.com" +
                                        searchData.coverurl),
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
                              searchData.title,
                              style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  color: kBlackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              searchData.author,
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  color: kMainColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
