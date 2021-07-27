import 'package:covidapp/pages/Risk_Form_Cholera.dart';
import 'package:covidapp/pages/Risk_Form_Covid.dart';
import 'package:covidapp/pages/Risk_Form_HIV.dart';
import 'package:covidapp/pages/Risk_Form_HongKongFlu.dart';
import 'package:covidapp/pages/Risk_Form_Influenza.dart';
import 'package:covidapp/pages/Risk_Form_Plague.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'Home_page_two.dart';

class DataRisk extends StatefulWidget {
  String username;
  String picture;
  String studentID;

  DataRisk(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  _DataRiskState createState() => _DataRiskState(username, picture, studentID);
}

class _DataRiskState extends State<DataRisk> {
  String username;
  String picture;
  String studentID;

  _DataRiskState(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   backgroundColor: Color(0xffF7F9FA),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.black,
      //       size: 30,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Choose your Assignment",
                  style: GoogleFonts.kanit(
                    fontSize: 27,
                    color: Colors.lightBlue,
                    // fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.redAccent.shade700,
                            borderRadius: BorderRadius.circular(15)),
                        //width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            child: Center(
                                child: Text(
                              "แบบทดสอบโรคโควิด-19",
                              style: GoogleFonts.kanit(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return RiskFormPage(
                                    username, picture, studentID);
                              }));
                            },
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            borderRadius: BorderRadius.circular(15)),
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            child: Center(
                                child: Text(
                              "แบบทดสอบโรคกาฬโรค",
                              style: GoogleFonts.kanit(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return RiskFormPlague(
                                    username, picture, studentID);
                              }));
                            },
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(15)),
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            child: Center(
                                child: Text(
                              "แบบทดสอบอหิวาตกโรค",
                              style: GoogleFonts.kanit(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return RiskFormCholera(
                                    username, picture, studentID);
                              }));
                            },
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(15)),
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            child: Center(
                                child: Text(
                              "แบบทดสอบโรคไข้หวัดใหญ่",
                              style: GoogleFonts.kanit(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return RiskFormInfluenza(
                                    username, picture, studentID);
                              }));
                            },
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(15)),
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            child: Center(
                                child: Text(
                              "แบบทดสอบเอชไอวี",
                              style: GoogleFonts.kanit(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return RiskFormHiv(
                                    username, picture, studentID);
                              }));
                            },
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.pink[400],
                            borderRadius: BorderRadius.circular(15)),
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            child: Center(
                                child: Text(
                              "แบบทดสอบไข้หวัดใหญ่ฮ่องกง ชนิด A",
                              style: GoogleFonts.kanit(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return RiskFormHongKongFlu(
                                    username, picture, studentID);
                              }));
                            },
                          ),
                        )),
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
