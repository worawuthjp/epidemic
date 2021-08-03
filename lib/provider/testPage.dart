import 'dart:convert';

import 'package:covidapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TestPage extends StatefulWidget {
  const TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}


class _TestPageState extends State<TestPage> {


  String text;

  Future<void> getData() async{
    var uri = Uri.parse("${hostname}/signin/login.php");
    var response = await http.post(uri, body: {
      "user_username" : "Yokwcth",
      "user_password" : "1234"
    });
    print("data");
    var data = json.decode(response.body);
    setState(() {
      text = data["userID"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}

