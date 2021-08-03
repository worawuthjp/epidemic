import 'package:covidapp/constants.dart';
import 'package:covidapp/pages/Container_Page.dart';
import 'package:covidapp/pages/DataRisk.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages/Risk_Form_HIV.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiskShowHiv extends StatefulWidget {
  bool weary;
  bool perspire;
  bool haggrad;
  bool rash;
  bool lymphGlands;
  String username;
  String picture;
  String studentID;

  RiskShowHiv(bool weary, bool perspire, bool haggrad, bool rash,
      bool lymphGlands, String username, String picture, String studentID) {
    this.weary = weary;
    this.perspire = perspire;
    this.haggrad = haggrad;
    this.rash = rash;

    this.lymphGlands = lymphGlands;
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  _RiskShowHivState createState() => _RiskShowHivState(weary, perspire, haggrad,
      rash, lymphGlands, username, picture, studentID);
}

class _RiskShowHivState extends State<RiskShowHiv> {
  bool weary;
  bool perspire;
  bool haggrad;
  bool rash;
  bool lymphGlands;
  String username;
  String picture;
  String studentID;

  _RiskShowHivState(bool weary, bool perspire, bool haggrad, bool rash,
      bool lymphGlands, String username, String picture, String studentID) {
    this.weary = weary;
    this.perspire = perspire;
    this.haggrad = haggrad;
    this.rash = rash;

    this.lymphGlands = lymphGlands;
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: FractionalOffset.topLeft,
            padding: const EdgeInsets.only(left: 25),
            //padding: EdgeInsets.fromLTRB(left, top, right, bottom),
            //padding: EdgeInsets.all(25),
            child: Text(
              "$username\n",
              style: GoogleFonts.kanit(fontSize: 40, color: Color(0xff3FAEF3)),
            ),
          ),
          Container(
            //padding: EdgeInsets.only(bottom: 40),
            alignment: Alignment.center,
            child: CircleAvatar(
                radius: 110,
                backgroundImage: NetworkImage(
                    "${hostname}/signup/avataruser/$picture")),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 160,
                  width: 330,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                ),
                //กรณีเลือก1choice
                weary == true &&
                        perspire == false &&
                        haggrad == false &&
                        rash == false &&
                        lymphGlands == false
                    ? Container(
                        padding: EdgeInsets.only(top: 30, bottom: 10),
                        child: Text(
                          'ความเสี่ยงต่ำ',
                          style: GoogleFonts.kanit(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff01FF2C)),
                        ),
                      )
                    : weary == false &&
                            perspire == true &&
                            haggrad == false &&
                            rash == false &&
                            lymphGlands == false
                        ? Container(
                            padding: EdgeInsets.only(top: 30, bottom: 10),
                            child: Text(
                              'ความเสี่ยงต่ำ',
                              style: GoogleFonts.kanit(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff01FF2C)),
                            ),
                          )
                        : weary == false &&
                                perspire == false &&
                                haggrad == true &&
                                rash == false &&
                                lymphGlands == false
                            ? Container(
                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                child: Text(
                                  'ความเสี่ยงต่ำ',
                                  style: GoogleFonts.kanit(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff01FF2C)),
                                ),
                              )
                            : weary == false &&
                                    perspire == false &&
                                    haggrad == false &&
                                    rash == true &&
                                    lymphGlands == false
                                ? Container(
                                    padding:
                                        EdgeInsets.only(top: 30, bottom: 10),
                                    child: Text(
                                      'ความเสี่ยงปานกลาง',
                                      style: GoogleFonts.kanit(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow[700]),
                                    ),
                                  )
                                : weary == false &&
                                        perspire == false &&
                                        haggrad == false &&
                                        rash == false &&
                                        lymphGlands == true
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            top: 30, bottom: 10),
                                        child: Text(
                                          'ความเสี่ยงสูง',
                                          style: GoogleFonts.kanit(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange[700]),
                                        ),
                                      )
                                    //กรณีเลือก1choice*

                                    //กรณีเลือก2choice
                                    : weary == true &&
                                            perspire == true &&
                                            haggrad == false &&
                                            rash == false &&
                                            lymphGlands == false
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                top: 30, bottom: 10),
                                            child: Text(
                                              'ความเสี่ยงปานกลาง',
                                              style: GoogleFonts.kanit(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.yellow[700]),
                                            ),
                                          )
                                        : weary == true &&
                                                perspire == false &&
                                                haggrad == true &&
                                                rash == false &&
                                                lymphGlands == false
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                    top: 30, bottom: 10),
                                                child: Text(
                                                  'ความเสี่ยงสูง',
                                                  style: GoogleFonts.kanit(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.orange[700]),
                                                ),
                                              )
                                            : weary == true &&
                                                    perspire == false &&
                                                    haggrad == false &&
                                                    rash == true &&
                                                    lymphGlands == false
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        top: 30, bottom: 10),
                                                    child: Text(
                                                      'ความเสี่ยงสูง',
                                                      style: GoogleFonts.kanit(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .orange[700]),
                                                    ),
                                                  )
                                                : weary == true &&
                                                        perspire == false &&
                                                        haggrad == false &&
                                                        rash == false &&
                                                        lymphGlands == true
                                                    ? Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 30,
                                                                bottom: 10),
                                                        child: Text(
                                                          'ความเสี่ยงสูงมาก',
                                                          style:
                                                              GoogleFonts.kanit(
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                          .red[
                                                                      700]),
                                                        ),
                                                      )
                                                    : weary == false &&
                                                            perspire == true &&
                                                            haggrad == true &&
                                                            rash == false &&
                                                            lymphGlands == false
                                                        ? Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 30,
                                                                    bottom: 10),
                                                            child: Text(
                                                              'ความเสี่ยงปานกลาง',
                                                              style: GoogleFonts.kanit(
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                          .yellow[
                                                                      700]),
                                                            ),
                                                          )
                                                        : weary == false &&
                                                                perspire ==
                                                                    true &&
                                                                haggrad ==
                                                                    false &&
                                                                rash == true &&
                                                                lymphGlands ==
                                                                    false
                                                            ? Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 30,
                                                                        bottom:
                                                                            10),
                                                                child: Text(
                                                                  'ความเสี่ยงสูง',
                                                                  style: GoogleFonts.kanit(
                                                                      fontSize:
                                                                          22,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                              .orange[
                                                                          700]),
                                                                ),
                                                              )
                                                            : weary == false &&
                                                                    perspire ==
                                                                        true &&
                                                                    haggrad ==
                                                                        false &&
                                                                    rash ==
                                                                        false &&
                                                                    lymphGlands ==
                                                                        true
                                                                ? Container(
                                                                    padding: EdgeInsets.only(
                                                                        top: 30,
                                                                        bottom:
                                                                            10),
                                                                    child: Text(
                                                                      'ความเสี่ยงสูงมาก',
                                                                      style: GoogleFonts.kanit(
                                                                          fontSize:
                                                                              22,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.red[700]),
                                                                    ),
                                                                  )
                                                                : weary == false &&
                                                                        perspire ==
                                                                            false &&
                                                                        haggrad ==
                                                                            true &&
                                                                        rash ==
                                                                            true &&
                                                                        lymphGlands ==
                                                                            false
                                                                    ? Container(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                30,
                                                                            bottom:
                                                                                10),
                                                                        child:
                                                                            Text(
                                                                          'ความเสี่ยงสูง',
                                                                          style: GoogleFonts.kanit(
                                                                              fontSize: 22,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.orange[700]),
                                                                        ),
                                                                      )
                                                                    : weary == false &&
                                                                            perspire ==
                                                                                false &&
                                                                            haggrad ==
                                                                                true &&
                                                                            rash ==
                                                                                false &&
                                                                            lymphGlands ==
                                                                                true
                                                                        ? Container(
                                                                            padding:
                                                                                EdgeInsets.only(top: 30, bottom: 10),
                                                                            child:
                                                                                Text(
                                                                              'ความเสี่ยงสูงมาก',
                                                                              style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                            ),
                                                                          )
                                                                        : weary == false &&
                                                                                perspire == false &&
                                                                                haggrad == false &&
                                                                                rash == true &&
                                                                                lymphGlands == true
                                                                            ? Container(
                                                                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                child: Text(
                                                                                  'ความเสี่ยงสูงมาก',
                                                                                  style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                ),
                                                                              )

                                                                            //กรณีเลือก2choice*

                                                                            //กรณีเลือก3choice
                                                                            : weary == true && perspire == true && haggrad == true && rash == false && lymphGlands == false
                                                                                ? Container(
                                                                                    padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                    child: Text(
                                                                                      'ความเสี่ยงสูง',
                                                                                      style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                                    ),
                                                                                  )
                                                                                : weary == true && perspire == true && haggrad == false && rash == true && lymphGlands == false
                                                                                    ? Container(
                                                                                        padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                        child: Text(
                                                                                          'ความเสี่ยงสูง',
                                                                                          style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                                        ),
                                                                                      )
                                                                                    : weary == true && perspire == true && haggrad == false && rash == false && lymphGlands == true
                                                                                        ? Container(
                                                                                            padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                            child: Text(
                                                                                              'ความเสี่ยงสูงมาก',
                                                                                              style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                            ),
                                                                                          )
                                                                                        : weary == false && perspire == true && haggrad == true && rash == true && lymphGlands == false
                                                                                            ? Container(
                                                                                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                child: Text(
                                                                                                  'ความเสี่ยงสูง',
                                                                                                  style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                                                ),
                                                                                              )
                                                                                            : weary == false && perspire == true && haggrad == true && rash == false && lymphGlands == true
                                                                                                ? Container(
                                                                                                    padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                    child: Text(
                                                                                                      'ความเสี่ยงสูงมาก',
                                                                                                      style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                    ),
                                                                                                  )
                                                                                                : weary == false && perspire == false && haggrad == true && rash == true && lymphGlands == true
                                                                                                    ? Container(
                                                                                                        padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                        child: Text(
                                                                                                          'ความเสี่ยงสูงมาก',
                                                                                                          style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                        ),
                                                                                                      )
                                                                                                    : weary == true && perspire == false && haggrad == true && rash == true && lymphGlands == false
                                                                                                        ? Container(
                                                                                                            padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                            child: Text(
                                                                                                              'ความเสี่ยงสูง',
                                                                                                              style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                                                            ),
                                                                                                          )
                                                                                                        : weary == true && perspire == false && haggrad == true && rash == false && lymphGlands == true
                                                                                                            ? Container(
                                                                                                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                child: Text(
                                                                                                                  'ความเสี่ยงสูงมาก',
                                                                                                                  style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                ),
                                                                                                              )
                                                                                                            : weary == true && perspire == false && haggrad == false && rash == true && lymphGlands == true
                                                                                                                ? Container(
                                                                                                                    padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                    child: Text(
                                                                                                                      'ความเสี่ยงสูงมาก',
                                                                                                                      style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                    ),
                                                                                                                  )
                                                                                                                : weary == false && perspire == true && haggrad == false && rash == true && lymphGlands == true
                                                                                                                    ? Container(
                                                                                                                        padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                        child: Text(
                                                                                                                          'ความเสี่ยงสูงมาก',
                                                                                                                          style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                        ),
                                                                                                                      )

                                                                                                                    //กรณีเลือก3choice*

                                                                                                                    //กรณีเลือก4choice*
                                                                                                                    : weary == true && perspire == true && haggrad == true && rash == true && lymphGlands == false
                                                                                                                        ? Container(
                                                                                                                            padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                            child: Text(
                                                                                                                              'ความเสี่ยงสูงมาก',
                                                                                                                              style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                            ),
                                                                                                                          )
                                                                                                                        : weary == true && perspire == true && haggrad == true && rash == false && lymphGlands == true
                                                                                                                            ? Container(
                                                                                                                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                                child: Text(
                                                                                                                                  'ความเสี่ยงสูงมาก',
                                                                                                                                  style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                                ),
                                                                                                                              )
                                                                                                                            : weary == true && perspire == true && haggrad == false && rash == true && lymphGlands == true
                                                                                                                                ? Container(
                                                                                                                                    padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                                    child: Text(
                                                                                                                                      'ความเสี่ยงสูงมาก',
                                                                                                                                      style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                                    ),
                                                                                                                                  )
                                                                                                                                : weary == true && perspire == false && haggrad == true && rash == true && lymphGlands == true
                                                                                                                                    ? Container(
                                                                                                                                        padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                                        child: Text(
                                                                                                                                          'ความเสี่ยงสูงมาก',
                                                                                                                                          style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                                        ),
                                                                                                                                      )
                                                                                                                                    : weary == false && perspire == true && haggrad == true && rash == true && lymphGlands == true
                                                                                                                                        ? Container(
                                                                                                                                            padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                                            child: Text(
                                                                                                                                              'ความเสี่ยงสูงมาก',
                                                                                                                                              style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                                            ),
                                                                                                                                          )

                                                                                                                                        //กรณีเลือก4choice*
                                                                                                                                        : weary == true && perspire == true && haggrad == true && rash == true && lymphGlands == true
                                                                                                                                            ? Container(
                                                                                                                                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                                                child: Text(
                                                                                                                                                  'ความเสี่ยงสูงมาก',
                                                                                                                                                  style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                                                ),
                                                                                                                                              )
                                                                                                                                            : Container(),

                Container(
                  margin: EdgeInsets.only(left: 52, top: 75),
                  height: 50,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightGreenAccent[700],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0)),
                          ),
                          alignment: Alignment.center,
                          width: 72.5,
                          height: 50,
                          child: Text(
                            'ต่ำ',
                            style: GoogleFonts.kanit(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 72.5,
                          height: 50,
                          color: Colors.yellow[700],
                          child: Text(
                            'ปานกลาง',
                            style: GoogleFonts.kanit(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 72.5,
                          height: 50,
                          color: Colors.orangeAccent[700],
                          child: Text(
                            'สูง',
                            style: GoogleFonts.kanit(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent[700],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0)),
                          ),
                          alignment: Alignment.center,
                          width: 72.5,
                          height: 50,
                          child: Text(
                            'สูงมาก',
                            style: GoogleFonts.kanit(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ]),
                ),
                //กรณีเลือก1choice
                weary == true &&
                        perspire == false &&
                        haggrad == false &&
                        rash == false &&
                        lymphGlands == false
                    ? Container(
                        alignment: FractionalOffset.topLeft,
                        padding:
                            const EdgeInsets.only(left: 78, top: 125), //ต่ำ

                        child: CustomPaint(
                          size: Size(20, 20),
                          painter: TriangleDraw(),
                        ),
                      )
                    : weary == false &&
                            perspire == true &&
                            haggrad == false &&
                            rash == false &&
                            lymphGlands == false
                        ? Container(
                            alignment: FractionalOffset.topLeft,
                            padding:
                                const EdgeInsets.only(left: 78, top: 125), //ต่ำ

                            child: CustomPaint(
                              size: Size(20, 20),
                              painter: TriangleDraw(),
                            ),
                          )
                        : weary == false &&
                                perspire == false &&
                                haggrad == true &&
                                rash == false &&
                                lymphGlands == false
                            ? Container(
                                alignment: FractionalOffset.topLeft,
                                padding: const EdgeInsets.only(
                                    left: 78, top: 125), //ต่ำ

                                child: CustomPaint(
                                  size: Size(20, 20),
                                  painter: TriangleDraw(),
                                ),
                              )
                            : weary == false &&
                                    perspire == false &&
                                    haggrad == false &&
                                    rash == true &&
                                    lymphGlands == false
                                ? Container(
                                    alignment: FractionalOffset.topLeft,
                                    padding: const EdgeInsets.only(
                                        left: 151, top: 125), //ปานกลาง

                                    child: CustomPaint(
                                      size: Size(20, 20),
                                      painter: TriangleDraw(),
                                    ),
                                  )
                                : weary == false &&
                                        perspire == false &&
                                        haggrad == false &&
                                        rash == false &&
                                        lymphGlands == true
                                    ? Container(
                                        alignment: FractionalOffset.topLeft,
                                        padding: const EdgeInsets.only(
                                            left: 224, top: 125), //สูง

                                        child: CustomPaint(
                                          size: Size(20, 20),
                                          painter: TriangleDraw(),
                                        ),
                                      )
                                    //กรณีเลือก1choice*

                                    //กรณีเลือก2choice
                                    : weary == true &&
                                            perspire == true &&
                                            haggrad == false &&
                                            rash == false &&
                                            lymphGlands == false
                                        ? Container(
                                            alignment: FractionalOffset.topLeft,
                                            padding: const EdgeInsets.only(
                                                left: 151, top: 125), //ปานกลาง

                                            child: CustomPaint(
                                              size: Size(20, 20),
                                              painter: TriangleDraw(),
                                            ),
                                          )
                                        : weary == true &&
                                                perspire == false &&
                                                haggrad == true &&
                                                rash == false &&
                                                lymphGlands == false
                                            ? Container(
                                                alignment:
                                                    FractionalOffset.topLeft,
                                                padding: const EdgeInsets.only(
                                                    left: 224, top: 125), //สูง

                                                child: CustomPaint(
                                                  size: Size(20, 20),
                                                  painter: TriangleDraw(),
                                                ),
                                              )
                                            : weary == true &&
                                                    perspire == false &&
                                                    haggrad == false &&
                                                    rash == true &&
                                                    lymphGlands == false
                                                ? Container(
                                                    alignment: FractionalOffset
                                                        .topLeft,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 224,
                                                            top: 125), //สูง

                                                    child: CustomPaint(
                                                      size: Size(20, 20),
                                                      painter: TriangleDraw(),
                                                    ),
                                                  )
                                                : weary == true &&
                                                        perspire == false &&
                                                        haggrad == false &&
                                                        rash == false &&
                                                        lymphGlands == true
                                                    ? Container(
                                                        alignment:
                                                            FractionalOffset
                                                                .topLeft,
                                                        padding: const EdgeInsets
                                                                .only(
                                                            left: 298,
                                                            top: 125), //สูงมาก

                                                        child: CustomPaint(
                                                          size: Size(20, 20),
                                                          painter:
                                                              TriangleDraw(),
                                                        ),
                                                      )
                                                    : weary == false &&
                                                            perspire == true &&
                                                            haggrad == true &&
                                                            rash == false &&
                                                            lymphGlands == false
                                                        ? Container(
                                                            alignment:
                                                                FractionalOffset
                                                                    .topLeft,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 151,
                                                                    top:
                                                                        125), //ปานกลาง

                                                            child: CustomPaint(
                                                              size:
                                                                  Size(20, 20),
                                                              painter:
                                                                  TriangleDraw(),
                                                            ),
                                                          )
                                                        : weary == false &&
                                                                perspire ==
                                                                    true &&
                                                                haggrad ==
                                                                    false &&
                                                                rash == true &&
                                                                lymphGlands ==
                                                                    false
                                                            ? Container(
                                                                alignment:
                                                                    FractionalOffset
                                                                        .topLeft,
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: 224,
                                                                    top:
                                                                        125), //สูง

                                                                child:
                                                                    CustomPaint(
                                                                  size: Size(
                                                                      20, 20),
                                                                  painter:
                                                                      TriangleDraw(),
                                                                ),
                                                              )
                                                            : weary == false &&
                                                                    perspire ==
                                                                        true &&
                                                                    haggrad ==
                                                                        false &&
                                                                    rash ==
                                                                        false &&
                                                                    lymphGlands ==
                                                                        true
                                                                ? Container(
                                                                    alignment:
                                                                        FractionalOffset
                                                                            .topLeft,
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            298,
                                                                        top:
                                                                            125), //สูงมาก

                                                                    child:
                                                                        CustomPaint(
                                                                      size: Size(
                                                                          20,
                                                                          20),
                                                                      painter:
                                                                          TriangleDraw(),
                                                                    ),
                                                                  )
                                                                : weary == false &&
                                                                        perspire ==
                                                                            false &&
                                                                        haggrad ==
                                                                            true &&
                                                                        rash ==
                                                                            true &&
                                                                        lymphGlands ==
                                                                            false
                                                                    ? Container(
                                                                        alignment:
                                                                            FractionalOffset.topLeft,
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                224,
                                                                            top:
                                                                                125), //สูง

                                                                        child:
                                                                            CustomPaint(
                                                                          size: Size(
                                                                              20,
                                                                              20),
                                                                          painter:
                                                                              TriangleDraw(),
                                                                        ),
                                                                      )
                                                                    : weary == false &&
                                                                            perspire ==
                                                                                false &&
                                                                            haggrad ==
                                                                                true &&
                                                                            rash ==
                                                                                false &&
                                                                            lymphGlands ==
                                                                                true
                                                                        ? Container(
                                                                            alignment:
                                                                                FractionalOffset.topLeft,
                                                                            padding:
                                                                                const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                            child:
                                                                                CustomPaint(
                                                                              size: Size(20, 20),
                                                                              painter: TriangleDraw(),
                                                                            ),
                                                                          )
                                                                        : weary == false &&
                                                                                perspire == false &&
                                                                                haggrad == false &&
                                                                                rash == true &&
                                                                                lymphGlands == true
                                                                            ? Container(
                                                                                alignment: FractionalOffset.topLeft,
                                                                                padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                child: CustomPaint(
                                                                                  size: Size(20, 20),
                                                                                  painter: TriangleDraw(),
                                                                                ),
                                                                              )

                                                                            //กรณีเลือก2choice*

                                                                            //กรณีเลือก3choice
                                                                            : weary == true && perspire == true && haggrad == true && rash == false && lymphGlands == false
                                                                                ? Container(
                                                                                    alignment: FractionalOffset.topLeft,
                                                                                    padding: const EdgeInsets.only(left: 224, top: 125), //สูง

                                                                                    child: CustomPaint(
                                                                                      size: Size(20, 20),
                                                                                      painter: TriangleDraw(),
                                                                                    ),
                                                                                  )
                                                                                : weary == true && perspire == true && haggrad == false && rash == true && lymphGlands == false
                                                                                    ? Container(
                                                                                        alignment: FractionalOffset.topLeft,
                                                                                        padding: const EdgeInsets.only(left: 224, top: 125), //สูง

                                                                                        child: CustomPaint(
                                                                                          size: Size(20, 20),
                                                                                          painter: TriangleDraw(),
                                                                                        ),
                                                                                      )
                                                                                    : weary == true && perspire == true && haggrad == false && rash == false && lymphGlands == true
                                                                                        ? Container(
                                                                                            alignment: FractionalOffset.topLeft,
                                                                                            padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                            child: CustomPaint(
                                                                                              size: Size(20, 20),
                                                                                              painter: TriangleDraw(),
                                                                                            ),
                                                                                          )
                                                                                        : weary == false && perspire == true && haggrad == true && rash == true && lymphGlands == false
                                                                                            ? Container(
                                                                                                alignment: FractionalOffset.topLeft,
                                                                                                padding: const EdgeInsets.only(left: 224, top: 125), //สูง

                                                                                                child: CustomPaint(
                                                                                                  size: Size(20, 20),
                                                                                                  painter: TriangleDraw(),
                                                                                                ),
                                                                                              )
                                                                                            : weary == false && perspire == true && haggrad == true && rash == false && lymphGlands == true
                                                                                                ? Container(
                                                                                                    alignment: FractionalOffset.topLeft,
                                                                                                    padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                                    child: CustomPaint(
                                                                                                      size: Size(20, 20),
                                                                                                      painter: TriangleDraw(),
                                                                                                    ),
                                                                                                  )
                                                                                                : weary == false && perspire == false && haggrad == true && rash == true && lymphGlands == true
                                                                                                    ? Container(
                                                                                                        alignment: FractionalOffset.topLeft,
                                                                                                        padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                                        child: CustomPaint(
                                                                                                          size: Size(20, 20),
                                                                                                          painter: TriangleDraw(),
                                                                                                        ),
                                                                                                      )
                                                                                                    : weary == true && perspire == false && haggrad == true && rash == true && lymphGlands == false
                                                                                                        ? Container(
                                                                                                            alignment: FractionalOffset.topLeft,
                                                                                                            padding: const EdgeInsets.only(left: 224, top: 125), //สูง

                                                                                                            child: CustomPaint(
                                                                                                              size: Size(20, 20),
                                                                                                              painter: TriangleDraw(),
                                                                                                            ),
                                                                                                          )
                                                                                                        : weary == true && perspire == false && haggrad == true && rash == false && lymphGlands == true
                                                                                                            ? Container(
                                                                                                                alignment: FractionalOffset.topLeft,
                                                                                                                padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                                                child: CustomPaint(
                                                                                                                  size: Size(20, 20),
                                                                                                                  painter: TriangleDraw(),
                                                                                                                ),
                                                                                                              )
                                                                                                            : weary == true && perspire == false && haggrad == false && rash == true && lymphGlands == true
                                                                                                                ? Container(
                                                                                                                    alignment: FractionalOffset.topLeft,
                                                                                                                    padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                                                    child: CustomPaint(
                                                                                                                      size: Size(20, 20),
                                                                                                                      painter: TriangleDraw(),
                                                                                                                    ),
                                                                                                                  )
                                                                                                                : weary == false && perspire == true && haggrad == false && rash == true && lymphGlands == true
                                                                                                                    ? Container(
                                                                                                                        alignment: FractionalOffset.topLeft,
                                                                                                                        padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                                                        child: CustomPaint(
                                                                                                                          size: Size(20, 20),
                                                                                                                          painter: TriangleDraw(),
                                                                                                                        ),
                                                                                                                      )

                                                                                                                    //กรณีเลือก3choice*

                                                                                                                    //กรณีเลือก4choice*
                                                                                                                    : weary == true && perspire == true && haggrad == true && rash == true && lymphGlands == false
                                                                                                                        ? Container(
                                                                                                                            alignment: FractionalOffset.topLeft,
                                                                                                                            padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                                                            child: CustomPaint(
                                                                                                                              size: Size(20, 20),
                                                                                                                              painter: TriangleDraw(),
                                                                                                                            ),
                                                                                                                          )
                                                                                                                        : weary == true && perspire == true && haggrad == true && rash == false && lymphGlands == true
                                                                                                                            ? Container(
                                                                                                                                alignment: FractionalOffset.topLeft,
                                                                                                                                padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                                                                child: CustomPaint(
                                                                                                                                  size: Size(20, 20),
                                                                                                                                  painter: TriangleDraw(),
                                                                                                                                ),
                                                                                                                              )
                                                                                                                            : weary == true && perspire == true && haggrad == false && rash == true && lymphGlands == true
                                                                                                                                ? Container(
                                                                                                                                    alignment: FractionalOffset.topLeft,
                                                                                                                                    padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                                                                    child: CustomPaint(
                                                                                                                                      size: Size(20, 20),
                                                                                                                                      painter: TriangleDraw(),
                                                                                                                                    ),
                                                                                                                                  )
                                                                                                                                : weary == true && perspire == false && haggrad == true && rash == true && lymphGlands == true
                                                                                                                                    ? Container(
                                                                                                                                        alignment: FractionalOffset.topLeft,
                                                                                                                                        padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                                                                        child: CustomPaint(
                                                                                                                                          size: Size(20, 20),
                                                                                                                                          painter: TriangleDraw(),
                                                                                                                                        ),
                                                                                                                                      )
                                                                                                                                    : weary == false && perspire == true && haggrad == true && rash == true && lymphGlands == true
                                                                                                                                        ? Container(
                                                                                                                                            alignment: FractionalOffset.topLeft,
                                                                                                                                            padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                                                                            child: CustomPaint(
                                                                                                                                              size: Size(20, 20),
                                                                                                                                              painter: TriangleDraw(),
                                                                                                                                            ),
                                                                                                                                          )

                                                                                                                                        //กรณีเลือก4choice*
                                                                                                                                        : weary == true && perspire == true && haggrad == true && rash == true && lymphGlands == true
                                                                                                                                            ? Container(
                                                                                                                                                alignment: FractionalOffset.topLeft,
                                                                                                                                                padding: const EdgeInsets.only(left: 298, top: 125), //สูงมาก

                                                                                                                                                child: CustomPaint(
                                                                                                                                                  size: Size(20, 20),
                                                                                                                                                  painter: TriangleDraw(),
                                                                                                                                                ),
                                                                                                                                              )
                                                                                                                                            : Container()
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 293,
            height: 42,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return DataRisk(username, picture, studentID);
                }));
              },
              child: Text(
                'ถัดไป',
                style: GoogleFonts.kanit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Color(0xffA2DAFF),
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

class TriangleDraw extends CustomPainter {
  Paint painter;

  TriangleDraw() {
    painter = Paint();
    painter.color = Colors.black;
    painter.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
