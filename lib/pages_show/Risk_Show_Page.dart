import 'package:covidapp/constants.dart';
import 'package:covidapp/pages/Container_Page.dart';
import 'package:covidapp/pages/DataRisk.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class RiskShowPage extends StatefulWidget {
  bool vomit;
  bool cough;
  bool throat;
  bool temp;
  bool noSymp;

  String username;
  String picture;
  String studentID;

  RiskShowPage(bool vomit, bool cough, bool throat, bool temp, bool noSymp,
      String username, String picture, String studentID) {
    this.vomit = vomit;
    this.cough = cough;
    this.throat = throat;
    this.temp = temp;
    this.noSymp = noSymp;
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  _RiskShowPageState createState() => _RiskShowPageState(
      vomit, cough, throat, temp, noSymp, username, picture, studentID);
}

class _RiskShowPageState extends State<RiskShowPage> {
  bool vomit;
  bool cough;
  bool throat;
  bool temp;
  bool noSymp;

  String username;
  String picture;
  String studentID;

  _RiskShowPageState(bool vomit, bool cough, bool throat, bool temp,
      bool noSymp, String username, String picture, String studentID) {
    this.vomit = vomit;
    this.cough = cough;
    this.throat = throat;
    this.temp = temp;
    this.noSymp = noSymp;
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[200],
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: FractionalOffset.topLeft,
              padding: const EdgeInsets.only(left: 25),
              //padding: EdgeInsets.fromLTRB(left, top, right, bottom),
              //padding: EdgeInsets.all(25),
              child: Text(
                "$username\n",
                style:
                    GoogleFonts.kanit(fontSize: 40, color: Color(0xff3FAEF3)),
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
                  //???????????????????????????1choice
                  vomit == true && //?????????????????????
                          cough == false &&
                          throat == false &&
                          temp == false &&
                          noSymp == false
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
                      : vomit == false &&
                              cough == true && // ??????
                              throat == false &&
                              temp == false &&
                              noSymp == false
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
                          : vomit == false &&
                                  cough == false &&
                                  throat == true && //??????????????????
                                  temp == false &&
                                  noSymp == false
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
                              : vomit == false &&
                                      cough == false &&
                                      throat == false &&
                                      temp == true && //??????????????????
                                      noSymp == false
                                  ? Container(
                                      padding:
                                          EdgeInsets.only(top: 30, bottom: 10),
                                      child: Text(
                                        '???????????????????????????????????????????????????',
                                        style: GoogleFonts.kanit(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.yellow[700]),
                                      ),
                                    )
                                  : vomit == false &&
                                          cough == false &&
                                          throat == false &&
                                          temp == false &&
                                          noSymp == true //???????????????????????????????????????
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              top: 30, bottom: 10),
                                          child: Text(
                                            '???????????????????????????????????????',
                                            style: GoogleFonts.kanit(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff01FF2C)),
                                          ),
                                        )
                                      //???????????????????????????1choice

                                      //???????????????????????????2choice
                                      : vomit == true && //?????????????????????
                                              cough == true && //??????
                                              throat == false &&
                                              temp == false &&
                                              noSymp == false
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
                                          : vomit == true && //?????????????????????
                                                  cough == false &&
                                                  throat == true && // ??????????????????
                                                  temp == false &&
                                                  noSymp == false
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
                                              : vomit == true && //?????????????????????
                                                      cough == false &&
                                                      throat == false &&
                                                      temp == true && //??????????????????
                                                      noSymp == false
                                                  ? Container(
                                                      padding: EdgeInsets.only(
                                                          top: 30, bottom: 10),
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
                                                  : vomit == false &&
                                                          cough == true && //??????
                                                          throat ==
                                                              true && //??????????????????
                                                          temp == false &&
                                                          noSymp == false
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
                                                      : vomit == false &&
                                                              cough ==
                                                                  true && //??????
                                                              throat == false &&
                                                              temp ==
                                                                  true && //??????????????????
                                                              noSymp == false
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
                                                          : vomit == false &&
                                                                  cough ==
                                                                      false &&
                                                                  throat ==
                                                                      true && //??????????????????
                                                                  temp ==
                                                                      true && //??????????????????
                                                                  noSymp ==
                                                                      false
                                                              ? Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              30,
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
                                                                            .orange[700]),
                                                                  ),
                                                                )

                                                              //???????????????????????????2choice

                                                              //???????????????????????????3choice
                                                              : vomit ==
                                                                          true && //?????????????????????
                                                                      cough ==
                                                                          true && //??????
                                                                      throat ==
                                                                          true && //??????????????????
                                                                      temp ==
                                                                          false &&
                                                                      noSymp ==
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
                                                                            fontSize:
                                                                                22,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.orange[700]),
                                                                      ),
                                                                    )
                                                                  : vomit ==
                                                                              true && //??????????????????
                                                                          cough ==
                                                                              true && //??????
                                                                          throat ==
                                                                              false &&
                                                                          temp ==
                                                                              true && //??????????????????
                                                                          noSymp ==
                                                                              false
                                                                      ? Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: 30,
                                                                              bottom: 10),
                                                                          child:
                                                                              Text(
                                                                            '????????????????????????????????????????????????',
                                                                            style: GoogleFonts.kanit(
                                                                                fontSize: 22,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.red[700]),
                                                                          ),
                                                                        )
                                                                      : vomit == false &&
                                                                              cough == true && //??????
                                                                              throat == true && //??????????????????
                                                                              temp == true && //??????????????????
                                                                              noSymp == false
                                                                          ? Container(
                                                                              padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                              child: Text(
                                                                                '????????????????????????????????????????????????',
                                                                                style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                              ),
                                                                            )
                                                                          : vomit == true && //?????????????????????
                                                                                  cough == false && //??????
                                                                                  throat == true && //??????????????????
                                                                                  temp == true && //??????????????????
                                                                                  noSymp == false
                                                                              ? Container(
                                                                                  padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                  child: Text(
                                                                                    '????????????????????????????????????????????????',
                                                                                    style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                  ),
                                                                                )
                                                                              //???????????????????????????3choice

                                                                              //???????????????????????????4choice
                                                                              : vomit == true && cough == true && throat == true && temp == true && noSymp == false
                                                                                  ? Container(
                                                                                      padding: EdgeInsets.only(top: 30, bottom: 10),
                                                                                      child: Text(
                                                                                        '????????????????????????????????????????????????',
                                                                                        style: GoogleFonts.kanit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red[700]),
                                                                                      ),
                                                                                    )
                                                                                  //???????????????????????????4choice
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
                  //???????????????????????????1 Choice
                  vomit == true && //?????????????????????
                          cough == false &&
                          throat == false &&
                          temp == false &&
                          noSymp == false
                      ? Container(
                          alignment: FractionalOffset.topLeft,
                          padding:
                              const EdgeInsets.only(left: 78, top: 125), //?????????

                          child: CustomPaint(
                            size: Size(20, 20),
                            painter: TriangleDraw(),
                          ),
                        )
                      : vomit == false &&
                              cough == true && // ??????
                              throat == false &&
                              temp == false &&
                              noSymp == false
                          ? Container(
                              alignment: FractionalOffset.topLeft,
                              padding: const EdgeInsets.only(
                                  left: 78, top: 125), //?????????

                              child: CustomPaint(
                                size: Size(20, 20),
                                painter: TriangleDraw(),
                              ),
                            )
                          : vomit == false &&
                                  cough == false &&
                                  throat == true && //??????????????????
                                  temp == false &&
                                  noSymp == false
                              ? Container(
                                  alignment: FractionalOffset.topLeft,
                                  padding: const EdgeInsets.only(
                                      left: 78, top: 125), //?????????

                                  child: CustomPaint(
                                    size: Size(20, 20),
                                    painter: TriangleDraw(),
                                  ),
                                )
                              : vomit == false &&
                                      cough == false &&
                                      throat == false &&
                                      temp == true && // ??????????????????
                                      noSymp == false
                                  ? Container(
                                      alignment: FractionalOffset.topLeft,
                                      padding: const EdgeInsets.only(
                                          left: 151, top: 125), //?????????????????????

                                      child: CustomPaint(
                                        size: Size(20, 20),
                                        painter: TriangleDraw(),
                                      ),
                                    )
                                  : vomit == false &&
                                          cough == false &&
                                          throat == false &&
                                          temp == false &&
                                          noSymp == true //??????????????????????????????
                                      ? Container(
                                          alignment: FractionalOffset.topLeft,
                                          padding: const EdgeInsets.only(
                                              left: 78, top: 125), //?????????

                                          child: CustomPaint(
                                            size: Size(20, 20),
                                            painter: TriangleDraw(),
                                          ),
                                        )
                                      //???????????????????????????1 Choice

                                      //???????????????????????????2 Choice

                                      : vomit == true && //?????????????????????
                                              cough == true && //??????
                                              throat == false &&
                                              temp == false &&
                                              noSymp == false
                                          ? Container(
                                              alignment:
                                                  FractionalOffset.topLeft,

                                              padding: const EdgeInsets.only(
                                                  left: 151, top: 125), // ????????????

                                              child: CustomPaint(
                                                size: Size(20, 20),
                                                painter: TriangleDraw(),
                                              ),
                                            )
                                          : vomit == true && //?????????????????????
                                                  cough == false &&
                                                  throat == true && // ??????????????????
                                                  temp == false &&
                                                  noSymp == false
                                              ? Container(
                                                  alignment:
                                                      FractionalOffset.topLeft,

                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 151,
                                                          top: 125), // ????????????

                                                  child: CustomPaint(
                                                    size: Size(20, 20),
                                                    painter: TriangleDraw(),
                                                  ),
                                                )
                                              : vomit == true && //?????????????????????
                                                      cough == false &&
                                                      throat == false &&
                                                      temp == true && //??????????????????
                                                      noSymp == false
                                                  ? Container(
                                                      alignment:
                                                          FractionalOffset
                                                              .topLeft,

                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 224,
                                                              top: 125), // ?????????

                                                      child: CustomPaint(
                                                        size: Size(20, 20),
                                                        painter: TriangleDraw(),
                                                      ),
                                                    )
                                                  : vomit == false &&
                                                          cough == true && //??????
                                                          throat ==
                                                              true && //??????????????????
                                                          temp == false &&
                                                          noSymp == false
                                                      ? Container(
                                                          alignment:
                                                              FractionalOffset
                                                                  .topLeft,

                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 151,
                                                                  top:
                                                                      125), // ?????????

                                                          child: CustomPaint(
                                                            size: Size(20, 20),
                                                            painter:
                                                                TriangleDraw(),
                                                          ),
                                                        )
                                                      : vomit == false &&
                                                              cough ==
                                                                  true && //??????
                                                              throat == false &&
                                                              temp ==
                                                                  true && //??????????????????
                                                              noSymp == false
                                                          ? Container(
                                                              alignment:
                                                                  FractionalOffset
                                                                      .topLeft,

                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 224,
                                                                      top:
                                                                          125), // ?????????

                                                              child:
                                                                  CustomPaint(
                                                                size: Size(
                                                                    20, 20),
                                                                painter:
                                                                    TriangleDraw(),
                                                              ),
                                                            )
                                                          : vomit == false &&
                                                                  cough ==
                                                                      false &&
                                                                  throat ==
                                                                      true && //??????????????????
                                                                  temp ==
                                                                      true && //??????????????????
                                                                  noSymp ==
                                                                      false
                                                              ? Container(
                                                                  alignment:
                                                                      FractionalOffset
                                                                          .topLeft,

                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 224,
                                                                      top:
                                                                          125), // ?????????

                                                                  child:
                                                                      CustomPaint(
                                                                    size: Size(
                                                                        20, 20),
                                                                    painter:
                                                                        TriangleDraw(),
                                                                  ),
                                                                )
                                                              //???????????????????????????2 Choice

                                                              //???????????????????????????3 Choice

                                                              : vomit ==
                                                                          true && //?????????????????????
                                                                      cough ==
                                                                          true && //??????
                                                                      throat ==
                                                                          true && //??????????????????
                                                                      temp ==
                                                                          false &&
                                                                      noSymp ==
                                                                          false
                                                                  ? Container(
                                                                      alignment:
                                                                          FractionalOffset
                                                                              .topLeft,

                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              224,
                                                                          top:
                                                                              125), // ?????????

                                                                      child:
                                                                          CustomPaint(
                                                                        size: Size(
                                                                            20,
                                                                            20),
                                                                        painter:
                                                                            TriangleDraw(),
                                                                      ),
                                                                    )
                                                                  : vomit ==
                                                                              true && //?????????????????????
                                                                          cough ==
                                                                              true && //??????
                                                                          throat ==
                                                                              false &&
                                                                          temp ==
                                                                              true && //??????????????????
                                                                          noSymp ==
                                                                              false
                                                                      ? Container(
                                                                          alignment:
                                                                              FractionalOffset.topLeft,

                                                                          padding: const EdgeInsets.only(
                                                                              left: 298,
                                                                              top: 125), // ??????????????????

                                                                          child:
                                                                              CustomPaint(
                                                                            size:
                                                                                Size(20, 20),
                                                                            painter:
                                                                                TriangleDraw(),
                                                                          ),
                                                                        )
                                                                      : vomit == false &&
                                                                              cough == true && //??????
                                                                              throat == true && //??????????????????
                                                                              temp == true && //??????????????????
                                                                              noSymp == false
                                                                          ? Container(
                                                                              alignment: FractionalOffset.topLeft,

                                                                              padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????

                                                                              child: CustomPaint(
                                                                                size: Size(20, 20),
                                                                                painter: TriangleDraw(),
                                                                              ),
                                                                            )
                                                                          : vomit == true &&
                                                                                  cough == false && //??????
                                                                                  throat == true && //??????????????????
                                                                                  temp == true && //??????????????????
                                                                                  noSymp == false
                                                                              ? Container(
                                                                                  alignment: FractionalOffset.topLeft,

                                                                                  padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????

                                                                                  child: CustomPaint(
                                                                                    size: Size(20, 20),
                                                                                    painter: TriangleDraw(),
                                                                                  ),
                                                                                )
                                                                              //???????????????????????????3 Choice

                                                                              //???????????????????????????4 Choice
                                                                              : vomit == true && cough == true && throat == true && temp == true && noSymp == false
                                                                                  ? Container(
                                                                                      alignment: FractionalOffset.topLeft,
                                                                                      padding: const EdgeInsets.only(left: 298, top: 125), // ??????????????????
                                                                                      child: CustomPaint(
                                                                                        size: Size(20, 20),
                                                                                        painter: TriangleDraw(),
                                                                                      ),
                                                                                    )
                                                                                  //???????????????????????????4 Choice
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
