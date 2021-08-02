import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages_show/Risk_Show_Page.dart';
import 'package:covidapp/pages_show/Risk_Show_Plague_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RiskFormPlague extends StatefulWidget {
  String username;
  String picture;
  String studentID;

  RiskFormPlague(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }
  @override
  _RiskFormPlagueState createState() =>
      _RiskFormPlagueState(username, picture, studentID);
}

class _RiskFormPlagueState extends State<RiskFormPlague> {
  bool _isSelectedHeadache = false;
  bool _isSelectedFever = false;
  bool _isSelectedHeartbeating = false;
  bool _isSelectedCough = false;
  bool _isSelectedPain = false;

  String headache = "false";
  String fever = "false";
  String heart = "false";
  String cough = "false";
  String pain = "false";

  String username;
  String picture;
  String studentID;

  void addData() {
    var url = Uri.parse("http://172.20.10.8/covid/Form/addDataPlague.php");
    http.post(url, body: {
      "plague_headache": headache,
      "plague_fever": fever,
      "plague_heart": heart,
      "plague_cough": cough,
      "plague_pain": pain,
    });
  }

  _RiskFormPlagueState(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF7F9FA),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: RichText(
                      text: TextSpan(
                          text: "$username\n",
                          style: GoogleFonts.kanit(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.lightBlue),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'โรคกาฬโรค',
                                style: GoogleFonts.kanit(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.lightBlue))
                          ]),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(right: 30),
                    child: CircleAvatar(
                      radius: 27,
                      backgroundImage: NetworkImage(
                          "http://172.20.10.8/ConnectDBProject/connectApp/signup/avataruser/$picture"),
                    ),
                  )
                ],
              ),
              Container(
                alignment: FractionalOffset.centerLeft,
                padding: EdgeInsets.fromLTRB(40, 25, 0, 0),
                child: Text(
                  'มีอาการดังกล่าวหรือไม่ ?',
                  style: GoogleFonts.kanit(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                alignment: FractionalOffset.centerLeft,
                padding: EdgeInsets.fromLTRB(40, 0, 0, 10),
                child: Text(
                  'กรุณาเลือกอาการที่ตรงกับคุณ',
                  style: GoogleFonts.kanit(
                      color: Color(0xff020202),
                      fontWeight: FontWeight.w300,
                      fontSize: 15),
                ),
              ),
              Container(
                // padding: EdgeInsets.only(bottom: 10),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 510,
                      width: 340,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(75)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40, 45, 40, 5),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black)),
                            child: CheckboxListTile(
                              title: Text(
                                'ปวดศีรษะ',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedHeadache,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedHeadache = newValue;
                                  if (_isSelectedHeadache == true) {
                                    headache = "เป็น";
                                  } else {
                                    headache = "ไม่เป็น";
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black)),
                            child: CheckboxListTile(
                              title: Text(
                                'มีไข้สูง',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedFever,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedFever = newValue;
                                  if (_isSelectedFever == true) {
                                    fever = "เป็น";
                                  } else {
                                    fever = "ไม่เป็น";
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black)),
                            child: CheckboxListTile(
                              title: Text(
                                'หัวใจเต้นเร็ว กระสับกระส่าย',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedHeartbeating,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedHeartbeating = newValue;
                                  if (_isSelectedHeartbeating == true) {
                                    heart = "เป็น";
                                  } else {
                                    heart = "ไม่เป็น";
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black)),
                            child: CheckboxListTile(
                              title: Text(
                                'ไอเป็นน้ำ',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedCough,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedCough = newValue;
                                  if (_isSelectedCough == true) {
                                    cough = "เป็น";
                                  } else {
                                    cough = "ไม่เป็น";
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black)),
                            child: CheckboxListTile(
                              title: Text(
                                'ปวดมากจนขยับแขนหรือขาไม่ได้',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedPain,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedPain = newValue;
                                  if (_isSelectedPain == true) {
                                    pain = "เป็น";
                                  } else {
                                    pain = "ไม่เป็น";
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width: 293,
                            height: 42,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              color: Color(0xffA2DAFF),
                              onPressed: () {
                                //addData();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return RiskShowPlaguePage(
                                      _isSelectedHeadache,
                                      _isSelectedFever,
                                      _isSelectedHeartbeating,
                                      _isSelectedCough,
                                      _isSelectedPain,
                                      username,
                                      picture,
                                      studentID);
                                }));
                              },
                              child: Text(
                                'ถัดไป',
                                style: GoogleFonts.kanit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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