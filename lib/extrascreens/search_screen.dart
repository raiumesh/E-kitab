// // ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, avoid_unnecessary_containers, unused_field, unused_element, avoid_print, dead_code

import 'dart:convert';
import 'package:book/models/search_model.dart';
import 'package:book/screens/homedetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../colors/color_value.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

TextEditingController searchword = TextEditingController();

class filterSuggestion {
  static Future<List<dynamic>> getSuggestions(String query) async {
    var response = await http.post(
        Uri.parse('https://major-project-ekitab.herokuapp.com/sendoptions'),
        body: ({'q': query}));
    var data = json.decode(response.body);

    return data['message'];
  }
}

class _SearchScreenState extends State<SearchScreen> {
  String username = " ";
  void getcred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
    });
    print(username);
  }

  List<SearchModel> searchState = [];
  handleSubmit() async {
    print(searchword.text);
    var response = await http.post(
        Uri.parse('https://major-project-ekitab.herokuapp.com'),
        body: ({'username': username, 'q': searchword.text}));
    final List<SearchModel> searchModel = searchModelFromJson(response.body);
    setState(() => {searchState = searchModel});
  }

  void logandscreen(title, uicontent, coverurl, bookurl, author, rating) async {
    String url = "https://major-project-ekitab.herokuapp.com/savelog";
    http.Response data1 = await http.post(Uri.parse(url),
        body: ({
          'username': username,
          'title': title,
        }));
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
  void initState() {
    getcred();
    setState(() {
      searchword.text = "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kBackgroundColor,
        title: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 15,
              right: 5,
              left: 5,
              bottom: 15,
            ),
            height: 50,
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: searchword,
                onSubmitted: (value) {
                  handleSubmit();
                },
                autofocus: false,
                style: DefaultTextStyle.of(context)
                    .style
                    .copyWith(fontStyle: FontStyle.normal),
                decoration: InputDecoration(
                    fillColor: kBackgroundColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    hintText: 'Search',
                    suffixIcon: IconButton(
                        onPressed: handleSubmit,
                        icon: Icon(
                          Icons.search,
                          color: kGreyColor,
                        ))),
              ),
              suggestionsCallback: (value) async {
                if (value != "") {
                  return await filterSuggestion.getSuggestions(value);
                } else {
                  return ["Type Something"];
                }
              },
              itemBuilder: (context, dynamic suggestion) {
                return Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          suggestion,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                );
              },
              onSuggestionSelected: (dynamic suggestion) {
                setState(() {
                  searchword.text = suggestion;
                });
                handleSubmit();
              },
            ),
          ),
        ]),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            // ignore: unnecessary_null_comparison
            child: searchState == null
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                        itemCount: searchState.length,
                        itemBuilder: (context, index) {
                          SearchModel searchData = searchState[index];
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
                              margin: EdgeInsets.only(bottom: 19),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "https://major-project-ekitab.herokuapp.com" +
                                                    searchData.coverurl),
                                          ),
                                          color: kMainColor),
                                    ),
                                    SizedBox(
                                      width: 21,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          searchData.title,
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              color: kBlackColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
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
          ),
        ],
      ),
    );
  }
}
