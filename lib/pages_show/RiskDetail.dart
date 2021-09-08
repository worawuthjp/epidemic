import 'package:covidapp/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../service/user_service.dart';
class RiskDetail extends StatefulWidget {
  final User user;
  const RiskDetail({Key key,@required this.user}) : super(key: key);

  @override
  _RiskDetailState createState() => _RiskDetailState(user: user);
}

class _RiskDetailState extends State<RiskDetail> {

  User user;

  _RiskDetailState({this.user});

  List<RiskArea> watchOut = List<RiskArea>();
  List<RiskArea> riskArea = List<RiskArea>();

  /* ฟังก์ชันนี้เช็คเวลาของสถานที่ที่เกิดความเสี่ยงกับเวลาปัจจุบัน
  * ถ้าหากเวลา <= 14 วัน จะมีสถานะ พื้นที่เสี่ยง
  * แต่ถ้าหากเวลาอยู่ในช่วง 14-28 วัน จะมีสถานะ เฝ้าระวัง แล้ว add ข้อมูลเก็บใน list
  * watchOut เก็บสถานที่ที่มีสถานะ เฝ้าระวัง
  * riskArea เก็บสถานที่ที่มีสถานะ พื้นที่เสี่ยง */
  verifyRiskArea (List<RiskArea> placeRisk) {
    DateTime currentDate = DateTime.now();
    placeRisk.forEach((place) {
      int differenceDate = currentDate.difference(place.startDate).inDays;
      if(differenceDate <= 14){
        riskArea.add(place);
      }else if (differenceDate > 14 && differenceDate <= 28){
        watchOut.add(place);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    verifyRiskArea(user.userPlaceRisk);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[400],
      child: SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [

                      ListTile(
                        title: Text(
                          user.username,
                          style: GoogleFonts.kanit(
                              fontSize: 25,
                              //fontWeight: FontWeight.w600,
                              color: Colors.lightBlue[300]),
                        ),
                        subtitle: Text(
                          "ประวัติพื้นที่เสี่ยง",
                          style: GoogleFonts.kanit(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlue),
                        ),
                        trailing: Container(
                          width: 60,
                          height: 60,
                          child: (user.picture == null || user.picture == "" )?
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ) :
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                "${hostname}/signup/avataruser/${user.picture}"),
                            backgroundColor: Colors.transparent,
                          ),
                        )
                      ),

                      Container(
                        child: riskAreaInfoWidget(),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: RaisedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            color: Colors.red,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_outlined,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          child: Text(
                                            "ย้อนกลับ",
                                            style: GoogleFonts.kanit(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
          ),
      ),
    );
  }

  Widget riskAreaInfoWidget(){
    return (riskArea.length != 0 || watchOut.length != 0)
    ? Container(
        margin: EdgeInsets.only(top: 16, bottom: 8),
        child: Column(
          children: [

            (riskArea.length != 0)
            ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red[500], Colors.red[900]],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25)
                )
              ),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [

                      Container(
                        child: Container(
                          child: Text(
                            "พื้นที่เสี่ยง",
                            style: GoogleFonts.kanit(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 16),
                      ),


                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: riskArea.length,
                          itemBuilder: (context, index) {
                            RiskArea place = riskArea[index];
                            return Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.symmetric( vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Container(
                                    child: Text(
                                      "${place.epidemicTopic}",
                                      style: GoogleFonts.kanit(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                                    padding: EdgeInsets.symmetric(horizontal: 32,vertical: 4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        gradient: LinearGradient(
                                            colors: [Colors.red[500], Colors.red[800]],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight
                                        )
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "สถานที่",
                                            style: GoogleFonts.kanit(
                                              color: Colors.red,
                                              fontSize: 24,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),

                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            "${place.riskAreaName}",
                                            style: GoogleFonts.kanit(
                                              color: Colors.red[900],
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    width: double.infinity,
                                    height: 2,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [Colors.red[500], Colors.red[900]],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight
                                        )
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "เช็คอิน",
                                            style: GoogleFonts.kanit(
                                              color: Colors.red,
                                              fontSize: 24,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),

                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            DateFormat.yMMMMd().format(place.startDate),
                                            style: GoogleFonts.kanit(
                                              color: Colors.red[900],
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            );
                          }
                        )
                      ),

                    ],
                  ),
                ),
              ),
            )
            : Container(),

            (watchOut.length != 0)
            ? Container(
              padding: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.orange[500], Colors.orange[900]],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)
                  )
              ),
              child: Column(
                children: [

                  Container(
                    child: Container(
                      child: Text(
                        "พื้นที่เฝ้าระวัง",
                        style: GoogleFonts.kanit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 16),
                  ),

                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: watchOut.length,
                          itemBuilder: (context, index) {
                            RiskArea place = watchOut[index];
                            return Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.symmetric( vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Container(
                                    child: Text(
                                      "${place.epidemicTopic}",
                                      style: GoogleFonts.kanit(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                                    padding: EdgeInsets.symmetric(horizontal: 32,vertical: 4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        gradient: LinearGradient(
                                            colors: [Colors.orange[500], Colors.orange[800]],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight
                                        )
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "สถานที่",
                                            style: GoogleFonts.kanit(
                                              color: Colors.orange,
                                              fontSize: 24,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),

                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            "${place.riskAreaName}",
                                            style: GoogleFonts.kanit(
                                              color: Colors.orange[900],
                                              fontSize: 18,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    width: double.infinity,
                                    height: 2,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [Colors.orange[500], Colors.orange[900]],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight
                                        )
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "เช็คอิน",
                                            style: GoogleFonts.kanit(
                                              color: Colors.orange,
                                              fontSize: 24,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),

                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            DateFormat.yMMMMd().format(place.startDate),
                                            style: GoogleFonts.kanit(
                                              color: Colors.orange[900],
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            );
                          }
                      )
                  ),

                ],
              ),
            )
            : Container(),

          ],
        ),
    )
    : Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Center(
              child: Text(
                "ไม่มีประวัติพื้นที่เสี่ยง",
                style: GoogleFonts.kanit(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
                textAlign: TextAlign.center,
              ),
            ),

          ],
        ),
      ),
    );
  }

  verifyTime(int time ) {
    String correctTime = "";
    if(time < 10)
      correctTime = "0" + time.toString();
    else
      correctTime = time.toString();
    return correctTime;
  }

  String timeLineFormat(RiskArea place) {
    String timeIn = verifyTime(place.startDate.hour) + ":" + verifyTime(place.startDate.minute);
    String timeOut = verifyTime(place.endDate.hour) + ":" + verifyTime(place.endDate.minute);
    String time = timeIn + " - " + timeOut;
    return time;
  }
}

