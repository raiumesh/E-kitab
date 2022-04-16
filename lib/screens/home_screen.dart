// ignore_for_file: prefer_const_constructors, unused_field, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, avoid_print, prefer_const_literals_to_create_immutables

import 'package:book/models/Apibook_Model.dart';
import 'package:book/screens/homedetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../colors/color_value.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = " ";
  void getcred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
    });
    print(username);
  }

  @override
  void initState() {
    super.initState();
    getcred();
  }

  Future<String> fetchData() async {
    String url = "https://major-project-ekitab.herokuapp.com/popular";
    http.Response data = await http.get(Uri.parse(url));

    return data.body;
  }

  Future<String> getData() async {
    String url = "https://major-project-ekitab.herokuapp.com/recs";
    http.Response data1 = await http.post(Uri.parse(url),
        body: ({
          'username': username,
        }));
    return data1.body;
  }

  void logandscreen(title, uicontent, coverurl, bookurl, author, rating) async {
    String url = "https://major-project-ekitab.herokuapp.com/savelog";
    http.Response data1 = await http.post(Uri.parse(url),
        body: ({
          'username': username,
          'title': title,
        }));
    print(title);
    print(username);
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
      body: SafeArea(
        child: FutureBuilder(
          initialData: [],
          future: fetchData(),
          builder: (context, snapshot1) {
            if (snapshot1.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: kMainColor,
                ),
              );
            } else if (snapshot1.hasError && !snapshot1.hasData) {
              return Center(child: Text("Unable to fetch the data"));
            }
            var rawdata = snapshot1.data as String;

            APIBookModel apiModel =
                APIBookModel.fromJson('{"bookDatas": ' + rawdata + '}');
            List<BookData> data = apiModel.bookDatas;
            if (data.isEmpty) {
              return Center(
                child: Text("Empty List"),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Recommended books',
                          style: GoogleFonts.openSans(
                              color: kBlackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 21),
                        height: 210,
                        child: FutureBuilder(
                            future: getData(),
                            builder: (context, snapshot2) {
                              if (snapshot2.hasData) {
                                var rawdata1 = snapshot2.data as String;

                                APIBookModel apiModel = APIBookModel.fromJson(
                                    '{"bookDatas": ' + rawdata1 + '}');
                                List<BookData> data2 = apiModel.bookDatas;

                                if (data2.isEmpty) {
                                  return const Center(
                                    child: Text("No Recommendation Right Now"),
                                  );
                                }
                                return ListView.builder(
                                    padding:
                                        EdgeInsets.only(left: 25, right: 6),
                                    itemCount: data2.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: (() {
                                          logandscreen(
                                              data2[index].title,
                                              data2[index].uicontent,
                                              data2[index].coverurl,
                                              data2[index].bookurl,
                                              data2[index].author,
                                              data2[index].rating);
                                        }),
                                        child: Container(
                                          margin: EdgeInsets.only(right: 19),
                                          height: 210,
                                          width: 153,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kMainColor,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://major-project-ekitab.herokuapp.com" +
                                                      data2[index].coverurl),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }

                              return Center(
                                  child: CircularProgressIndicator(
                                color: kMainColor,
                              ));
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 23.0),
                        child: Text(
                          "Popular Books",
                          style: GoogleFonts.openSans(
                              color: kBlackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    ((context, index) => GestureDetector(
                          onTap: () {
                            logandscreen(
                                data[index].title,
                                data[index].uicontent,
                                data[index].coverurl,
                                data[index].bookurl,
                                data[index].author,
                                data[index].rating);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 19, bottom: 19),
                            height: 81,
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
                                                  data[index].coverurl),
                                        ),
                                        color: kMainColor),
                                  ),
                                  SizedBox(
                                    width: 21,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        data[index].title,
                                        style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: kBlackColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        data[index].author,
                                        style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            color: kMainColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                    childCount: data.length,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
