import 'package:covidapp/pages/Container_Page.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages_show/Risk_Show_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RiskFormPage extends StatefulWidget {
  String username;
  String picture;
  String studentID;

  RiskFormPage(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }
  @override
  _RiskFormPageState createState() =>
      _RiskFormPageState(username, picture, studentID);
}

class _RiskFormPageState extends State<RiskFormPage> {
  bool _isSelectedVomit = false;
  bool _isSelectedCough = false;
  bool _isSelectedThroat = false;
  bool _isSelectedFever = false;
  bool _isSelected = false;

  String username;
  String picture;
  String studentID;

  String vomit = "ไม่เป็น";
  String cough = "ไม่เป็น";
  String throat = "ไม่เป็น";
  String fever = "ไม่เป็น";
  String noSymp = "ไม่เป็น";

  void addData() {
    var url = Uri.parse("http://172.20.10.8/covid/Form/addDataCovid.php");
    http.post(url, body: {
      "assignment_vomit": vomit,
      "assignment_cough": cough,
      "assignment_sore_throat": throat,
      "assignment_temp37": fever,
      "assignment_no_symptoms": noSymp,
    });
  }

  _RiskFormPageState(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF7F9FA),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                                text: 'โรคโควิด-19',
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
                                'อาเจียน',
                                style: GoogleFonts.kanit(),
                              ),
                              value: _isSelectedVomit,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedVomit = newValue;
                                  if (_isSelectedVomit == true) {
                                    vomit = "เป็น";
                                  } else {
                                    vomit = "ไม่เป็น";
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
                              title: Text('ไอ', style: GoogleFonts.kanit()),
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
                              title: Text('เจ็บคอ', style: GoogleFonts.kanit()),
                              value: _isSelectedThroat,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelectedThroat = newValue;
                                  if (_isSelectedThroat == true) {
                                    throat = "เป็น";
                                  } else {
                                    throat = "ไม่เป็น";
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
                              title: Text('มีไข้สูง 37.5 องศาขึ้นไป',
                                  style: GoogleFonts.kanit()),
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
                              title: Text('ไม่มีอาการใดๆ',
                                  style: GoogleFonts.kanit()),
                              value: _isSelected,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isSelected = newValue;
                                  if (_isSelected == true) {
                                    noSymp = "เป็น";
                                  } else {
                                    noSymp = "ไม่เป็น";
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
                                addData();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return RiskShowPage(
                                      _isSelectedVomit,
                                      _isSelectedCough,
                                      _isSelectedThroat,
                                      _isSelectedFever,
                                      _isSelected,
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
