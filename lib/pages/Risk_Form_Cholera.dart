import 'package:covidapp/constants.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages_show/Risk_Show_Cholera.dart';
import 'package:covidapp/pages_show/Risk_Show_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiskFormCholera extends StatefulWidget {
  String username;
  String picture;
  String studentID;

  RiskFormCholera(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  _RiskFormCholeraState createState() =>
      _RiskFormCholeraState(username, picture, studentID);
}

class _RiskFormCholeraState extends State<RiskFormCholera> {
  bool _isSelectedFever = false;
  bool _isSelectedAche = false;
  bool _isSelectedSick = false;
  bool _isSelectedExcrete = false;
  bool _isSelectedExcrement = false;

  String username;
  String picture;
  String studentID;

  _RiskFormCholeraState(String username, String picture, String studentID) {
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
                                text: '???????????????????????????????????????',
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
                          "${hostname}/signup/avataruser/$picture"),
                    ),
                  )
                ],
              ),
              Container(
                alignment: FractionalOffset.centerLeft,
                padding: EdgeInsets.fromLTRB(40, 25, 0, 0),
                child: Text(
                  '?????????????????????????????????????????????????????????????????? ?',
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
                  '?????????????????????????????????????????????????????????????????????????????????',
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
                              title: Text('???????????????', style: GoogleFonts.kanit()),
                              value: _isSelectedFever,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedFever = newValue;
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
                                '?????????????????????',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedAche,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedAche = newValue;
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
                              title: Text('???????????????????????? ?????????????????????',
                                  style: GoogleFonts.kanit()),
                              value: _isSelectedSick,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedSick = newValue;
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
                                  '?????????????????????????????????????????????????????????????????? ??????????????????????????????????????????????????????',
                                  style: GoogleFonts.kanit()),
                              value: _isSelectedExcrete,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedExcrete = newValue;
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
                                  '?????????????????????????????????????????????????????????????????? ???????????????????????????????????????????????????',
                                  style: GoogleFonts.kanit()),
                              value: _isSelectedExcrement,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedExcrement = newValue;
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
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return RiskShowCholera(
                                      _isSelectedFever,
                                      _isSelectedAche,
                                      _isSelectedSick,
                                      _isSelectedExcrete,
                                      _isSelectedExcrement,
                                      username,
                                      picture,
                                      studentID);
                                }));
                              },
                              child: Text(
                                '???????????????',
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
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => HomePageTwo()));
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
