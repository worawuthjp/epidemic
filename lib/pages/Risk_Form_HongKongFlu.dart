import 'package:covidapp/constants.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages_show/Risk_Show_HongKong.dart';
import 'package:covidapp/pages_show/Risk_Show_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiskFormHongKongFlu extends StatefulWidget {
  String username;
  String picture;
  String studentID;

  RiskFormHongKongFlu(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }
  @override
  _RiskFormHongKongFluState createState() =>
      _RiskFormHongKongFluState(username, picture, studentID);
}

class _RiskFormHongKongFluState extends State<RiskFormHongKongFlu> {
  bool _isSelectedFever = false;
  bool _isSelectedSick = false;
  bool _isSelectedVomit = false;
  bool _isSelectedAche = false;
  bool _isSelectedDiarrhea = false;

  String username;
  String picture;
  String studentID;

  _RiskFormHongKongFluState(String username, String picture, String studentID) {
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
                                text: 'โรคไข้หวัดใหญ่ฮ่องกง ชนิด A',
                                style: GoogleFonts.kanit(
                                    fontSize: 22,
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
                                'เป็นไข้',
                                style: GoogleFonts.kanit(),
                              ),
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
                                'คลื่นไส้',
                                style: GoogleFonts.kanit(),
                              ),
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
                                'อาเจียน',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedVomit,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedVomit = newValue;
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
                                'ปวดเมื่อยกล้ามเนื้อมาก',
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
                              title: Text(
                                'ท้องร่วง',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedDiarrhea,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedDiarrhea = newValue;
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
                                  return RiskShowHongkong(
                                      _isSelectedFever,
                                      _isSelectedSick,
                                      _isSelectedVomit,
                                      _isSelectedAche,
                                      _isSelectedDiarrhea,
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
