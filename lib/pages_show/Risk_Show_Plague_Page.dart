import 'dart:typed_data';

import 'package:covidapp/constants.dart';
import 'package:covidapp/pages/Container_Page.dart';
import 'package:covidapp/pages/DataRisk.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiskShowPlaguePage extends StatefulWidget {
  bool headache;
  bool fever;
  bool heart;
  bool cough;
  bool pain;

  String username;
  String picture;
  String studentID;

  RiskShowPlaguePage(bool headache, bool fever, bool heart, bool cough,
      bool pain, String username, String picture, String studentID) {
    this.headache = headache;
    this.fever = fever;
    this.heart = heart;
    this.cough = cough;
    this.pain = pain;
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  _RiskShowPlaguePageState createState() => _RiskShowPlaguePageState(
      headache, fever, heart, cough, pain, username, picture, studentID);
}

class _RiskShowPlaguePageState extends State<RiskShowPlaguePage> {
  bool headache;
  bool fever;
  bool heart;
  bool cough;
  bool pain;

  String username;
  String picture;
  String studentID;

  _RiskShowPlaguePageState(bool headache, bool fever, bool heart, bool cough,
      bool pain, String username, String picture, String studentID) {
    this.headache = headache;
    this.fever = fever;
    this.heart = heart;
    this.cough = cough;
    this.pain = pain;
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

                //???????????????????????????1Choice
                headache == true &&
                        fever == false &&
                        cough == false &&
                        pain == false &&
                        heart == false
                    ? Container(
                        padding: EdgeInsets.only(top: 30, bottom: 10),
                        child: Text(
                          '???????????????????????????????????????',
                          style: GoogleFonts.kanit(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff01FF2C)),
                        ),
                      )
                    : headache == false &&
                            fever == true &&
                            cough == false &&
                            pain == false &&
                            heart == false
                        ? Container(
                            padding: EdgeInsets.only(top: 30, bottom: 10),
                            child: Text(
                              '???????????????????????????????????????????????????',
                              style: GoogleFonts.kanit(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow[700]),
                            ),
                          )
                        : headache == false &&
                                fever == false &&
                                cough == true &&
                                pain == false &&
                                heart == false
                            ? Container(
                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                child: Text(
                                  '???????????????????????????????????????',
                                  style: GoogleFonts.kanit(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff01FF2C)),
                                ),
                              )
                            : headache == false &&
                                    fever == false &&
                                    cough == false &&
                                    pain == true &&
                                    heart == false
                                ? Container(
                                    padding:
                                        EdgeInsets.only(top: 30, bottom: 10),
                                    child: Text(
                                      '???????????????????????????????????????',
                                      style: GoogleFonts.kanit(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange[700]),
                                    ),
                                  )
                                : headache == false &&
                                        fever == false &&
                                        cough == false &&
                                        pain == false &&
                                        heart == true
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            top: 30, bottom: 10),
                                        child: Text(
                                          '???????????????????????????????????????',
                                          style: GoogleFonts.kanit(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange[700]),
                                        ),
                                      )
                                    //???????????????????????????1Choice

                                    //???????????????????????????2Choice
                                    : headache == true &&
                                            fever == true &&
                                            cough == false &&
                                            pain == false &&
                                            heart == false
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                top: 30, bottom: 10),
                                            child: Text(
                                              '???????????????????????????????????????????????????',
                                              style: GoogleFonts.kanit(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.yellow[700]),
                                            ),
                                          )
                                        : headache == true &&
                                                fever == false &&
                                                cough == true &&
                                                pain == false &&
                                                heart == false
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                    top: 30, bottom: 10),
                                                child: Text(
                                                  '???????????????????????????????????????????????????',
                                                  style: GoogleFonts.kanit(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.yellow[700]),
                                                ),
                                              )
                                            : headache == true &&
                                                    fever == false &&
                                                    cough == false &&
                                                    pain == true &&
                                                    heart == false
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        top: 30, bottom: 10),
                                                    child: Text(
                                                      '???????????????????????????????????????',
                                                      style: GoogleFonts.kanit(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .orange[700]),
                                                    ),
                                                  )
                                                : headache == true &&
                                                        fever == false &&
                                                        cough == false &&
                                                        pain == false &&
                                                        heart == true
                                                    ? Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 30,
                                                                bottom: 10),
                                                        child: Text(
                                                          '???????????????????????????????????????',
                                                          style:
                                                              GoogleFonts.kanit(
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                          .orange[
                                                                      700]),
                                                        ),
                                                      )
                                                    : headache == false &&
                                                            fever == true &&
                                                            cough == true &&
                                                            pain == false &&
                                                            heart == false
                                                        ? Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 30,
                                                                    bottom: 10),
                                                            child: Text(
                                                              '???????????????????????????????????????????????????',
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
                                                        : headache == false &&
                                                                fever == true &&
                                                                cough ==
                                                                    false &&
                                                                pain == true &&
                                                                heart == false
                                                            ? Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 30,
                                                                        bottom:
                                                                            10),
                                                                child: Text(
                                                                  '???????????????????????????????????????',
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
                                                            : headache ==
                                                                        false &&
                                                                    fever ==
                                                                        true &&
                                                                    cough ==
                                                                        false &&
                                                                    pain ==
                                                                        false &&
                                                                    heart ==
                                                                        true
                                                                ? Container(
                                                                    padding: EdgeInsets.only(
                                                                        top: 30,
                                                                        bottom:
                                                                            10),
                                                                    child: Text(
                                                                      '???????????????????????????????????????',
                                                                      style: GoogleFonts.kanit(
                                                                          fontSize:
                                                                              22,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.orange[700]),
                                                                    ),
                                                                  )
                                                                : headache ==
                                                                            false &&
                                                                        fever ==
                                                                            false &&
                                                                        cough ==
                                                                            true &&
                                                                        pain ==
                                                                            true &&
                                                                        heart ==
                                                                            false
                                                                    ? Container(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                30,
                                                                            bottom:
                                                                                10),
                                                                        child:
                                                                            Text(
                                                                          '???????????????????????????????????????',
                                                                          style: GoogleFonts.kanit(
                                                                              fontSize: 22,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.orange[700]),
                                                                        ),
                                                                      )
                                                                    : headache == false &&
                                                                            fever ==
                                                                                false &&
                                                                            cough ==
                                                                                true &&
                                                                            pain ==
                                                                                false &&
                                                                            heart ==
                                                                                true
                                                                        ? Container(
                                                                            padding:
                                                                                EdgeInsets.only(top: 30, bottom: 10),
                                                                            child:
                                                                                Text(
                                                                              '???????????????????????????????????????',
                                                                              style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                            ),
                                                                          )
                                                                        : headache == false &&
                                                                                fever == false &&
                                                                                cough == false &&
                                                                                pain == true &&
                                                                                heart == true
                                                                            ? Container(
                                                                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                child: Text(
                                                                                  '????????????????????????????????????????????????',
                                                                                  style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                ),
                                                                              )
                                                                            //???????????????????????????2Choice*

                                                                            //???????????????????????????3Choice
                                                                            : headache == true && fever == true && cough == true && pain == false && heart == false
                                                                                ? Container(
                                                                                    padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                    child: Text(
                                                                                      '???????????????????????????????????????',
                                                                                      style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                                    ),
                                                                                  )
                                                                                : headache == true && fever == true && cough == false && pain == true && heart == false
                                                                                    ? Container(
                                                                                        padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                        child: Text(
                                                                                          '???????????????????????????????????????',
                                                                                          style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                                        ),
                                                                                      )
                                                                                    : headache == true && fever == true && cough == false && pain == false && heart == true
                                                                                        ? Container(
                                                                                            padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                            child: Text(
                                                                                              '???????????????????????????????????????',
                                                                                              style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                                            ),
                                                                                          )
                                                                                        : headache == true && fever == false && cough == false && pain == true && heart == true
                                                                                            ? Container(
                                                                                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                child: Text(
                                                                                                  '????????????????????????????????????????????????',
                                                                                                  style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                ),
                                                                                              )
                                                                                            : headache == true && fever == false && cough == true && pain == false && heart == true
                                                                                                ? Container(
                                                                                                    padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                    child: Text(
                                                                                                      '???????????????????????????????????????',
                                                                                                      style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                                                    ),
                                                                                                  )
                                                                                                : headache == true && fever == false && cough == true && pain == true && heart == false
                                                                                                    ? Container(
                                                                                                        padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                        child: Text(
                                                                                                          '???????????????????????????????????????',
                                                                                                          style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                                                        ),
                                                                                                      )
                                                                                                    : headache == false && fever == true && cough == true && pain == false && heart == true
                                                                                                        ? Container(
                                                                                                            padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                            child: Text(
                                                                                                              '???????????????????????????????????????',
                                                                                                              style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                                                            ),
                                                                                                          )
                                                                                                        : headache == false && fever == true && cough == false && pain == true && heart == true
                                                                                                            ? Container(
                                                                                                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                child: Text(
                                                                                                                  '????????????????????????????????????????????????',
                                                                                                                  style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                ),
                                                                                                              )
                                                                                                            : headache == false && fever == false && cough == true && pain == true && heart == true
                                                                                                                ? Container(
                                                                                                                    padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                    child: Text(
                                                                                                                      '????????????????????????????????????????????????',
                                                                                                                      style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                    ),
                                                                                                                  )
                                                                                                                : headache == false && fever == true && cough == true && pain == true && heart == false
                                                                                                                    ? Container(
                                                                                                                        padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                        child: Text(
                                                                                                                          '???????????????????????????????????????',
                                                                                                                          style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange[700]),
                                                                                                                        ),
                                                                                                                      )

                                                                                                                    //???????????????????????????3Choice*

                                                                                                                    //???????????????????????????4Choice
                                                                                                                    : headache == true && fever == true && cough == true && pain == true && heart == false
                                                                                                                        ? Container(
                                                                                                                            padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                            child: Text(
                                                                                                                              '????????????????????????????????????????????????',
                                                                                                                              style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                            ),
                                                                                                                          )
                                                                                                                        : headache == true && fever == true && cough == true && pain == false && heart == true
                                                                                                                            ? Container(
                                                                                                                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                                child: Text(
                                                                                                                                  '????????????????????????????????????????????????',
                                                                                                                                  style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                                ),
                                                                                                                              )
                                                                                                                            : headache == false && fever == true && cough == true && pain == true && heart == true
                                                                                                                                ? Container(
                                                                                                                                    padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                                    child: Text(
                                                                                                                                      '????????????????????????????????????????????????',
                                                                                                                                      style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                                    ),
                                                                                                                                  )
                                                                                                                                : headache == true && fever == false && cough == true && pain == true && heart == true
                                                                                                                                    ? Container(
                                                                                                                                        padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                                        child: Text(
                                                                                                                                          '????????????????????????????????????????????????',
                                                                                                                                          style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                                        ),
                                                                                                                                      )
                                                                                                                                    : headache == true && fever == true && cough == false && pain == true && heart == true
                                                                                                                                        ? Container(
                                                                                                                                            padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                                            child: Text(
                                                                                                                                              '????????????????????????????????????????????????',
                                                                                                                                              style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                                                                            ),
                                                                                                                                          )

                                                                                                                                        //???????????????????????????4Choice*
                                                                                                                                        : headache == true && fever == true && cough == true && pain == true && heart == true
                                                                                                                                            ? Container(
                                                                                                                                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                                                                                child: Text(
                                                                                                                                                  '????????????????????????????????????????????????',
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
                            '?????????',
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
                            '?????????????????????',
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
                            '?????????',
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
                            '??????????????????',
                            style: GoogleFonts.kanit(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ]),
                ),
                //???????????????????????????1Choice
                headache == true &&
                        fever == false &&
                        cough == false &&
                        pain == false &&
                        heart == false
                    ? Container(
                        alignment: FractionalOffset.topLeft,
                        padding:
                            const EdgeInsets.only(left: 78, top: 125), //?????????

                        child: CustomPaint(
                          size: Size(20, 20),
                          painter: TriangleDraw(),
                        ),
                      )
                    : headache == false &&
                            fever == true &&
                            cough == false &&
                            pain == false &&
                            heart == false
                        ? Container(
                            alignment: FractionalOffset.topLeft,
                            padding: const EdgeInsets.only(
                                left: 151, top: 125), //?????????????????????

                            child: CustomPaint(
                              size: Size(20, 20),
                              painter: TriangleDraw(),
                            ),
                          )
                        : headache == false &&
                                fever == false &&
                                cough == true &&
                                pain == false &&
                                heart == false
                            ? Container(
                                alignment: FractionalOffset.topLeft,
                                padding: const EdgeInsets.only(
                                    left: 78, top: 125), //?????????

                                child: CustomPaint(
                                  size: Size(20, 20),
                                  painter: TriangleDraw(),
                                ),
                              )
                            : headache == false &&
                                    fever == false &&
                                    cough == false &&
                                    pain == true &&
                                    heart == false
                                ? Container(
                                    alignment: FractionalOffset.topLeft,
                                    padding: const EdgeInsets.only(
                                        left: 224, top: 125), //?????????

                                    child: CustomPaint(
                                      size: Size(20, 20),
                                      painter: TriangleDraw(),
                                    ),
                                  )
                                : headache == false &&
                                        fever == false &&
                                        cough == false &&
                                        pain == false &&
                                        heart == true
                                    ? Container(
                                        alignment: FractionalOffset.topLeft,
                                        padding: const EdgeInsets.only(
                                            left: 224, top: 125), //?????????

                                        child: CustomPaint(
                                          size: Size(20, 20),
                                          painter: TriangleDraw(),
                                        ),
                                      )
                                    ////???????????????????????????1Choice

                                    //???????????????????????????2Choice
                                    : headache == true &&
                                            fever == true &&
                                            cough == false &&
                                            pain == false &&
                                            heart == false
                                        ? Container(
                                            alignment: FractionalOffset.topLeft,
                                            padding: const EdgeInsets.only(
                                                left: 151, top: 125), //????????????

                                            child: CustomPaint(
                                              size: Size(20, 20),
                                              painter: TriangleDraw(),
                                            ),
                                          )
                                        : headache == true &&
                                                fever == false &&
                                                cough == true &&
                                                pain == false &&
                                                heart == false
                                            ? Container(
                                                alignment:
                                                    FractionalOffset.topLeft,
                                                padding: const EdgeInsets.only(
                                                    left: 151, top: 125), //????????????

                                                child: CustomPaint(
                                                  size: Size(20, 20),
                                                  painter: TriangleDraw(),
                                                ),
                                              )
                                            : headache == true &&
                                                    fever == false &&
                                                    cough == false &&
                                                    pain == true &&
                                                    heart == false
                                                ? Container(
                                                    alignment: FractionalOffset
                                                        .topLeft,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 224,
                                                            top: 125), //?????????

                                                    child: CustomPaint(
                                                      size: Size(20, 20),
                                                      painter: TriangleDraw(),
                                                    ),
                                                  )
                                                : headache == true &&
                                                        fever == false &&
                                                        cough == false &&
                                                        pain == false &&
                                                        heart == true
                                                    ? Container(
                                                        alignment:
                                                            FractionalOffset
                                                                .topLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 224,
                                                                top: 125), //?????????

                                                        child: CustomPaint(
                                                          size: Size(20, 20),
                                                          painter:
                                                              TriangleDraw(),
                                                        ),
                                                      )
                                                    : headache == false &&
                                                            fever == true &&
                                                            cough == false &&
                                                            pain == true &&
                                                            heart == false
                                                        ? Container(
                                                            alignment:
                                                                FractionalOffset
                                                                    .topLeft,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 224,
                                                                    top:
                                                                        125), //?????????

                                                            child: CustomPaint(
                                                              size:
                                                                  Size(20, 20),
                                                              painter:
                                                                  TriangleDraw(),
                                                            ),
                                                          )
                                                        : headache == false &&
                                                                fever == true &&
                                                                cough ==
                                                                    false &&
                                                                pain == false &&
                                                                heart == true
                                                            ? Container(
                                                                alignment:
                                                                    FractionalOffset
                                                                        .topLeft,
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: 224,
                                                                    top:
                                                                        125), //?????????

                                                                child:
                                                                    CustomPaint(
                                                                  size: Size(
                                                                      20, 20),
                                                                  painter:
                                                                      TriangleDraw(),
                                                                ),
                                                              )
                                                            : headache ==
                                                                        false &&
                                                                    fever ==
                                                                        true &&
                                                                    cough ==
                                                                        true &&
                                                                    pain ==
                                                                        false &&
                                                                    heart ==
                                                                        false
                                                                ? Container(
                                                                    alignment:
                                                                        FractionalOffset
                                                                            .topLeft,
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            151,
                                                                        top:
                                                                            125), //?????????????????????

                                                                    child:
                                                                        CustomPaint(
                                                                      size: Size(
                                                                          20,
                                                                          20),
                                                                      painter:
                                                                          TriangleDraw(),
                                                                    ),
                                                                  )
                                                                : headache ==
                                                                            false &&
                                                                        fever ==
                                                                            false &&
                                                                        cough ==
                                                                            true &&
                                                                        pain ==
                                                                            true &&
                                                                        heart ==
                                                                            false
                                                                    ? Container(
                                                                        alignment:
                                                                            FractionalOffset.topLeft,
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                224,
                                                                            top:
                                                                                125), //?????????

                                                                        child:
                                                                            CustomPaint(
                                                                          size: Size(
                                                                              20,
                                                                              20),
                                                                          painter:
                                                                              TriangleDraw(),
                                                                        ),
                                                                      )
                                                                    : headache == false &&
                                                                            fever ==
                                                                                false &&
                                                                            cough ==
                                                                                true &&
                                                                            pain ==
                                                                                false &&
                                                                            heart ==
                                                                                true
                                                                        ? Container(
                                                                            alignment:
                                                                                FractionalOffset.topLeft,
                                                                            padding:
                                                                                const EdgeInsets.only(left: 224, top: 125), //?????????

                                                                            child:
                                                                                CustomPaint(
                                                                              size: Size(20, 20),
                                                                              painter: TriangleDraw(),
                                                                            ),
                                                                          )
                                                                        : headache == false &&
                                                                                fever == false &&
                                                                                cough == false &&
                                                                                pain == true &&
                                                                                heart == true
                                                                            ? Container(
                                                                                alignment: FractionalOffset.topLeft,
                                                                                padding: const EdgeInsets.only(left: 298, top: 125), //??????????????????

                                                                                child: CustomPaint(
                                                                                  size: Size(20, 20),
                                                                                  painter: TriangleDraw(),
                                                                                ),
                                                                              )
                                                                            //???????????????????????????2Choice*

                                                                            //???????????????????????????3Choice
                                                                            : headache == true && fever == true && cough == true && pain == false && heart == false
                                                                                ? Container(
                                                                                    alignment: FractionalOffset.topLeft,

                                                                                    padding: const EdgeInsets.only(left: 224, top: 125), // ?????????

                                                                                    child: CustomPaint(
                                                                                      size: Size(20, 20),
                                                                                      painter: TriangleDraw(),
                                                                                    ),
                                                                                  )
                                                                                : headache == true && fever == true && cough == false && pain == true && heart == false
                                                                                    ? Container(
                                                                                        alignment: FractionalOffset.topLeft,

                                                                                        padding: const EdgeInsets.only(left: 224, top: 125), // ?????????

                                                                                        child: CustomPaint(
                                                                                          size: Size(20, 20),
                                                                                          painter: TriangleDraw(),
                                                                                        ),
                                                                                      )
                                                                                    : headache == true && fever == true && cough == false && pain == false && heart == true
                                                                                        ? Container(
                                                                                            alignment: FractionalOffset.topLeft,

                                                                                            padding: const EdgeInsets.only(left: 224, top: 125), // ?????????

                                                                                            child: CustomPaint(
                                                                                              size: Size(20, 20),
                                                                                              painter: TriangleDraw(),
                                                                                            ),
                                                                                          )
                                                                                        : headache == true && fever == false && cough == false && pain == true && heart == true
                                                                                            ? Container(
                                                                                                alignment: FractionalOffset.topLeft,

                                                                                                padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????

                                                                                                child: CustomPaint(
                                                                                                  size: Size(20, 20),
                                                                                                  painter: TriangleDraw(),
                                                                                                ),
                                                                                              )
                                                                                            : headache == true && fever == false && cough == true && pain == false && heart == true
                                                                                                ? Container(
                                                                                                    alignment: FractionalOffset.topLeft,

                                                                                                    padding: const EdgeInsets.only(left: 224, top: 125), // ?????????

                                                                                                    child: CustomPaint(
                                                                                                      size: Size(20, 20),
                                                                                                      painter: TriangleDraw(),
                                                                                                    ),
                                                                                                  )
                                                                                                : headache == true && fever == false && cough == true && pain == true && heart == false
                                                                                                    ? Container(
                                                                                                        alignment: FractionalOffset.topLeft,

                                                                                                        padding: const EdgeInsets.only(left: 224, top: 125), // ?????????

                                                                                                        child: CustomPaint(
                                                                                                          size: Size(20, 20),
                                                                                                          painter: TriangleDraw(),
                                                                                                        ),
                                                                                                      )
                                                                                                    : headache == false && fever == true && cough == true && pain == false && heart == true
                                                                                                        ? Container(
                                                                                                            alignment: FractionalOffset.topLeft,

                                                                                                            padding: const EdgeInsets.only(left: 224, top: 125), // ?????????

                                                                                                            child: CustomPaint(
                                                                                                              size: Size(20, 20),
                                                                                                              painter: TriangleDraw(),
                                                                                                            ),
                                                                                                          )
                                                                                                        : headache == false && fever == true && cough == false && pain == true && heart == true
                                                                                                            ? Container(
                                                                                                                alignment: FractionalOffset.topLeft,

                                                                                                                padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????

                                                                                                                child: CustomPaint(
                                                                                                                  size: Size(20, 20),
                                                                                                                  painter: TriangleDraw(),
                                                                                                                ),
                                                                                                              )
                                                                                                            : headache == false && fever == false && cough == true && pain == true && heart == true
                                                                                                                ? Container(
                                                                                                                    alignment: FractionalOffset.topLeft,

                                                                                                                    padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????

                                                                                                                    child: CustomPaint(
                                                                                                                      size: Size(20, 20),
                                                                                                                      painter: TriangleDraw(),
                                                                                                                    ),
                                                                                                                  )
                                                                                                                : headache == false && fever == true && cough == true && pain == true && heart == false
                                                                                                                    ? Container(
                                                                                                                        alignment: FractionalOffset.topLeft,

                                                                                                                        padding: const EdgeInsets.only(left: 224, top: 125), // ?????????

                                                                                                                        child: CustomPaint(
                                                                                                                          size: Size(20, 20),
                                                                                                                          painter: TriangleDraw(),
                                                                                                                        ),
                                                                                                                      )
                                                                                                                    //???????????????????????????3Choice*

                                                                                                                    //???????????????????????????4Choice
                                                                                                                    : headache == true && fever == true && cough == true && pain == true && heart == false
                                                                                                                        ? Container(
                                                                                                                            alignment: FractionalOffset.topLeft,
                                                                                                                            padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????
                                                                                                                            child: CustomPaint(
                                                                                                                              size: Size(20, 20),
                                                                                                                              painter: TriangleDraw(),
                                                                                                                            ),
                                                                                                                          )
                                                                                                                        : headache == true && fever == true && cough == true && pain == false && heart == true
                                                                                                                            ? Container(
                                                                                                                                alignment: FractionalOffset.topLeft,
                                                                                                                                padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????
                                                                                                                                child: CustomPaint(
                                                                                                                                  size: Size(20, 20),
                                                                                                                                  painter: TriangleDraw(),
                                                                                                                                ),
                                                                                                                              )
                                                                                                                            : headache == false && fever == true && cough == true && pain == true && heart == true
                                                                                                                                ? Container(
                                                                                                                                    alignment: FractionalOffset.topLeft,
                                                                                                                                    padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????
                                                                                                                                    child: CustomPaint(
                                                                                                                                      size: Size(20, 20),
                                                                                                                                      painter: TriangleDraw(),
                                                                                                                                    ),
                                                                                                                                  )
                                                                                                                                : headache == true && fever == false && cough == true && pain == true && heart == true
                                                                                                                                    ? Container(
                                                                                                                                        alignment: FractionalOffset.topLeft,
                                                                                                                                        padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????
                                                                                                                                        child: CustomPaint(
                                                                                                                                          size: Size(20, 20),
                                                                                                                                          painter: TriangleDraw(),
                                                                                                                                        ),
                                                                                                                                      )
                                                                                                                                    : headache == true && fever == true && cough == false && pain == true && heart == true
                                                                                                                                        ? Container(
                                                                                                                                            alignment: FractionalOffset.topLeft,
                                                                                                                                            padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????
                                                                                                                                            child: CustomPaint(
                                                                                                                                              size: Size(20, 20),
                                                                                                                                              painter: TriangleDraw(),
                                                                                                                                            ),
                                                                                                                                          )
                                                                                                                                        //???????????????????????????4Choice*
                                                                                                                                        : headache == true && fever == true && cough == true && pain == true && heart == true
                                                                                                                                            ? Container(
                                                                                                                                                alignment: FractionalOffset.topLeft,
                                                                                                                                                padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????
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
                '???????????????',
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
