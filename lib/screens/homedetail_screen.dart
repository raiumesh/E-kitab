// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_unnecessary_containers, must_be_immutable

import 'dart:convert';

import 'dart:ffi';

import 'dart:io';
import 'package:flutter/services.dart';

import 'package:book/colors/color_value.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class DetailScreen extends StatefulWidget {
  String title, coverurl, author, uicontent;
  String? bookurl;
  double rating;
  DetailScreen(
      {required this.title,
      required this.author,
      required this.bookurl,
      required this.uicontent,
      required this.coverurl,
      required this.rating});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class User {
  final int? id;
  final int? bookid;
  final String? userid;
  final String? comment;
  final double? rating;

  User({
    this.id,
    this.bookid,
    this.userid,
    this.comment,
    this.rating,
  });
}

class _DetailScreenState extends State<DetailScreen> {
  String username = " ";
  void getcred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
    });
    print(username);
  }

  TextEditingController review = TextEditingController();

  bool loading = false;
  Dio dio = new Dio();
  String filePath = "";
  String imagePath = "";
  //read epub
  createFolder() async {
    final folderName = "images";
    final path = Directory(
        "/storage/emulated/0/Android/data/com.example.book/files/$folderName");
    if ((await path.exists())) {
      // TODO:
      print("exist");
    } else {
      // TODO:
      print("not exist");
      path.create();
    }
  }

  //download
  startDownload() async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path =
        appDocDir!.path + '/' + widget.title + '.' + widget.author + '.epub';
    var ext = widget.coverurl.split('.');
    String imagep = appDocDir.path + '/images/' + widget.title + '.' + ext.last;
    File file = File(path);
    File image = File(imagep);
    print(path);

    if (!File(path).existsSync()) {
      await file.create();
      print(widget.bookurl);
      await dio.download(
        'https://major-project-ekitab.herokuapp.com' +
            widget.bookurl.toString(),
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          var percentage = receivedBytes / totalBytes * 100;
          print((receivedBytes / totalBytes * 100).toStringAsFixed(0));
          //Check if download is complete and close the alert dialog
          if (receivedBytes == totalBytes) {
            loading = false;
            filePath = path;
          }
        },
      );
    } else {
      loading = false;

      filePath = path;
    }

    if (!File(imagep).existsSync()) {
      await file.create();
      await dio.download(
        'https://major-project-ekitab.herokuapp.com' + widget.coverurl,
        imagep,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          print((receivedBytes / totalBytes * 100).toStringAsFixed(0));
          //Check if download is complete and close the alert dialog
          if (receivedBytes == totalBytes) {
            loading = false;

            imagePath = imagep;
          }
        },
      );
    } else {
      loading = false;

      imagePath = imagep;
    }
//    await file.delete();r
  }

  Future downloadFile() async {
    print('download already done');
    print(filePath);

    if (await Permission.storage.isGranted) {
      await Permission.storage.request();

      await startDownload();
    } else {
      await startDownload();
    }
  }

  download() async {
    if (Platform.isAndroid || Platform.isIOS) {
      print('download');
      await downloadFile();
    } else {
      loading = false;
    }

    print(filePath);
  }

  saver(response) async {
    String url =
        "https://major-project-ekitab.herokuapp.com/savereviews?bookid=" +
            widget.title +
            "&userid=" +
            username +
            "&comment=" +
            response.comment +
            "&rating=" +
            response.rating.toString();
    http.Response data1 = await http.get(Uri.parse(url));
    getReview();
  }

  getReview() async {
    String url = "https://major-project-ekitab.herokuapp.com/reviews?title=" +
        widget.title;
    http.Response data1 = await http.get(Uri.parse(url));

    var reviewData = json.decode(data1.body);
    List<User> users = [];
    for (var singleUser in reviewData) {
      User user = User(
          id: singleUser["id"],
          bookid: singleUser["bookid"],
          userid: singleUser["userid"],
          comment: singleUser["comment"],
          rating: singleUser["rating"]);
      users.add(user);
    }
    return users;
  }

  @override
  void initState() {
    getcred();
    getReview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 40, right: 40, bottom: 15),
        height: 45,
        color: Colors.transparent,
        child: FloatingActionButton(
          onPressed: () {
            createFolder();
            startDownload();
          },
          backgroundColor: kMainColor,
          child: Text(
            'Download Book',
            style: GoogleFonts.openSans(
                fontSize: 16, fontWeight: FontWeight.w600, color: kWhiteColor),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: kMainColor,
                expandedHeight: 500,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://major-project-ekitab.herokuapp.com" +
                                  widget.coverurl),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.only(top: 24, left: 25),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        color: kBlackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7, left: 25),
                  child: Text(
                    widget.author,
                    style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: kMainColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: Text(
                    "Description",
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: kBlackColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: Text(
                    widget.uicontent,
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: kBlackColor,
                      letterSpacing: 0.8,
                      height: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    "Reviews",
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kBlackColor,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  child: FutureBuilder(
                    future: getReview(),
                    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return SizedBox();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 60,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: 20, right: 10, bottom: 5, top: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          snapshot.data[index].userid,
                                          style: GoogleFonts.openSans(
                                              fontSize: 13,
                                              color: kMainColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(":"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data[index].comment,
                                          style: GoogleFonts.openSans(
                                              fontSize: 13,
                                              color: kBlackColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 100, right: 100, bottom: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      show();
                    },
                    child: Text("Rate and Review",
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kWhiteColor)),
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
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

  void show() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return RatingDialog(
              title: Text('Rate this app!'),
              image: Image.asset(
                'assets/icon/logo.jpg',
                width: 120,
                height: 120,
              ),
              submitButtonText: 'Submit',
              onCancelled: () => print('cancelled'),
              onSubmitted: (response) {
                saver(response);
              });
        });
  }
}
