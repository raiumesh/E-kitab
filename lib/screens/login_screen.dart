// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:book/colors/color_value.dart';
import 'package:book/extrascreens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailText = TextEditingController();
TextEditingController passwordText = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  Future<void> login() async {
    if (passwordText.text.isNotEmpty && emailText.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse('https://major-project-ekitab.herokuapp.com/login'),
          body: ({'username': emailText.text, 'password': passwordText.text}));
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavScreen()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Blank field not allowed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Welcome",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                // Center(
                //   child: Text(
                //     "Sign in Continue",
                //     style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                //   ),
                // ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Image.asset(
                    'assets/icon/logo.jpg',
                    width: 170,
                    height: 170,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                TextFormField(
                  controller: emailText,
                  decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle:
                          TextStyle(fontSize: 15, color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordText,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle:
                          TextStyle(fontSize: 15, color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                // SizedBox(
                //   height: 5,
                // ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Text(
                //     "Forget Password",
                //     style:
                //         TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                //   ),
                // ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    login();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 14,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Login ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
