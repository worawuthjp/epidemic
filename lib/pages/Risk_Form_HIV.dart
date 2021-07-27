import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages_show/Risk_Show_HIV.dart';
import 'package:covidapp/pages_show/Risk_Show_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiskFormHiv extends StatefulWidget {
  String username;
  String picture;
  String studentID;

  RiskFormHiv(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }
  @override
  _RiskFormHivState createState() =>
      _RiskFormHivState(username, picture, studentID);
}

class _RiskFormHivState extends State<RiskFormHiv> {
  bool _isSelectedWeary = false;
  bool _isSelectedPerspire = false;
  bool _isSelectedHaggrad = false;
  bool _isSelectedRash = false;
  bool _isSelectedLymphGlands = false;

  String username;
  String picture;
  String studentID;

  _RiskFormHivState(String username, String picture, String studentID) {
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
                                text: 'โรคเอชไอวี',
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
                                'เหนื่อยผิดปกติ',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedWeary,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedWeary = newValue;
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
                                'เหงื่อออกตอนกลางคืน',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedPerspire,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedPerspire = newValue;
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
                                'น้ำหนักลดอย่างรวดเร็ว',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedHaggrad,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedHaggrad = newValue;
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
                                'มีผื่นตามผิวหนัง ในช่องปาก จมูกและเปลือกตา',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedRash,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedRash = newValue;
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
                                'อาการบวมที่ต่อมน้ำเหลืองบริเวณคอรักแร้และขาหนีบ',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedLymphGlands,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedLymphGlands = newValue;
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
                                  return RiskShowHiv(
                                      _isSelectedWeary,
                                      _isSelectedPerspire,
                                      _isSelectedHaggrad,
                                      _isSelectedRash,
                                      _isSelectedLymphGlands,
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
