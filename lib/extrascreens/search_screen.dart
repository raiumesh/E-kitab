// // ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, avoid_unnecessary_containers, unused_field, unused_element, avoid_print, dead_code

import 'package:book/models/search_model.dart';
import 'package:book/semscreen/sem_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/color_value.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
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

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchword = TextEditingController();
  List<SearchModel> searchState = [];

  Future<List<SearchModel>> getsem(sem) async {
    var response = await http.get(
        Uri.parse('https://major-project-ekitab.herokuapp.com/sem?sem=' + '0'));
    final List<SearchModel> searchModel = searchModelFromJson(response.body);
    setState(() => {searchState = searchModel});
  }

  Future<List<SearchModel>> handleSubmit() async {
    print(searchword.text);
    var response = await http.post(
        Uri.parse('https://major-project-ekitab.herokuapp.com'),
        body: ({'username': '074bct519', 'q': searchword.text}));
    final List<SearchModel> searchModel = searchModelFromJson(response.body);
    print(searchModel);
    setState(() => {searchState = searchModel});
  }
  // Future<List<SearchModel>> fetchData() async {
  //   String url = "https://major-project-ekitab.herokuapp.com/recs";
  //   var data1 = await http.post(Uri.parse(url),
  //       body: ({
  //         'username': '074bct519',
  //       }));
  //   final List<SearchModel> searchdata = searchModelFromJson(data1.body);
  //   return searchdata;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kMainColor,
        title: Container(
          decoration: BoxDecoration(
              color: kBackgroundColor, borderRadius: BorderRadius.circular(30)),
          child: TextField(
            controller: searchword,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(top: 13, bottom: 13, left: 17, right: 13),
              hintText: "Search",
              suffixIcon: IconButton(
                onPressed: handleSubmit,
                icon: Icon(Icons.search),
              ), // IconButton
            ), // InputDecoration
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: semesterLists.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SemScreen()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      right: 5,
                      left: 5,
                    ),
                    width: 150,
                    decoration: BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            semesterLists[index],
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
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
                            child: Container(
                              margin: EdgeInsets.only(bottom: 19),
                              height: 50,
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
                                          image: NetworkImage(
                                              "https://major-project-ekitab.herokuapp.com" +
                                                  searchData.coverurl),
                                        ),
                                        //color: kMainColor
                                      ),
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
                                              fontSize: 16,
                                              color: kBlackColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          searchData.author,
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
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
