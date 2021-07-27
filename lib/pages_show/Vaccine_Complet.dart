import 'package:covidapp/pages/Home_page_two.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VaccineShowPage extends StatefulWidget {
  String username;
  String picture;
  String studentID;

  VaccineShowPage(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  _VaccineShowPageState createState() =>
      _VaccineShowPageState(username, picture, studentID);
}

class _VaccineShowPageState extends State<VaccineShowPage> {
  String username;
  String picture;
  String studentID;

  _VaccineShowPageState(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  Future<List> getData() async {
    var url = Uri.parse(
        "http://172.20.10.8/ConnectDBProject/connectApp/vaccine/getVaccine.php?id=$studentID");
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }
          if (snapshot.hasData) {
            return Items(
              list: snapshot.data,
              username: username,
              picture: picture,
              studentID: studentID,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Items extends StatefulWidget {
  List list;
  String username;
  String picture;
  String studentID;

  Items({this.list, this.username, this.picture, this.studentID});

  @override
  _ItemsState createState() => _ItemsState(
      list: list, username: username, picture: picture, studentID: studentID);
}

class _ItemsState extends State<Items> {
  List list;
  String username;
  String picture;
  String studentID;

  _ItemsState({this.list, this.username, this.picture, this.studentID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 150),
            child: Text(
              username,
              style: GoogleFonts.kanit(fontSize: 30, color: Colors.lightBlue),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage(
                  "http://172.20.10.8/ConnectDBProject/connectApp/signup/avataruser/$picture"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Stack(alignment: Alignment.topCenter, children: [
              Container(
                  width: 323,
                  height: 163,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(31))),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: RichText(
                  text: TextSpan(
                      text: "สถานะ\n\n",
                      style: GoogleFonts.kanit(
                          fontSize: 20,
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold),
                      children: [
                        list.isEmpty
                            ? TextSpan(
                                text: 'กรุณาแสดงผลการฉีดวัคซีน!\n',
                                style: GoogleFonts.kanit(
                                    color: Colors.orangeAccent[700],
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))
                            : list[0]['user_status'] == "อนุมัติ" ||
                                    list[0]['user_status'] == "ยืนยัน"
                                ? TextSpan(
                                    text: 'ฉีดวัคซีนแล้ว!\n',
                                    style: GoogleFonts.kanit(
                                        color: Color(0xff01FF2C),
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold))
                                : list[0]['user_status'] == "No" ||
                                        list[0]['user_status'] == "no"
                                    ? TextSpan(
                                        text: 'ยังไม่ได้รับการตรวจสอบ!\n',
                                        style: GoogleFonts.kanit(
                                            color: Colors.orangeAccent[700],
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold))
                                    : TextSpan(),
                        list.isEmpty
                            ? TextSpan(
                                text: 'ยังไม่ได้รับการยืนยัน\n',
                                style: GoogleFonts.kanit(
                                    color: Colors.redAccent[700],
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold))
                            : list[0]['user_status'] == "อนุมัติ" ||
                                    list[0]['user_status'] == "ยืนยัน"
                                ? TextSpan(
                                    text: 'ได้รับการยืนยัน',
                                    style: GoogleFonts.kanit(
                                        color: Colors.redAccent[700],
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold))
                                : list[0]['user_status'] == "No" ||
                                        list[0]['user_status'] == "no"
                                    ? TextSpan(
                                        text: 'รอการตรวจสอบจากผู้ดูแล',
                                        style: GoogleFonts.kanit(
                                            color: Colors.redAccent[700],
                                            fontSize: 27,
                                            fontWeight: FontWeight.bold))
                                    : TextSpan(),
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 293,
            height: 42,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Color(0xffA2DAFF),
              onPressed: () {
                print(list);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePageTwo()));
              },
              child: Text(
                'ยืนยัน',
                style: GoogleFonts.kanit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffA2DAFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePageTwo()));
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.location_on,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.history,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
