import 'dart:convert';

import 'package:covidapp/constants.dart';
import 'package:covidapp/models/CheckInModel.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CheckOutPage extends StatefulWidget {

  final User user;
  final CheckIn checkin_info;
  const CheckOutPage({Key key,@required this.user,@required this.checkin_info}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState(user: user, checkIn: checkin_info);
}

class _CheckOutPageState extends State<CheckOutPage> {

  _CheckOutPageState({this.user, this.checkIn});
  User user;
  CheckIn checkIn;

  Future<void> onTappedCheckOut() async{
    final String url = "${hostname}/timeline/checkout.php";
    var response = await http.post(url);
    Map<String, dynamic> data = json.decode(response.body);
    if(data["msg"] == "success" && data["statusCode"] == 200) {

    }
  }

  String getTimeCheckIn(DateTime timeCheckIn) {
    return verifyTime(timeCheckIn.hour) + " : " + verifyTime(timeCheckIn.minute) + " น.";
  }

  String verifyTime(int time ) {
    String correctTime = "";
    if(time < 10)
      correctTime = "0" + time.toString();
    else
      correctTime = time.toString();
    return correctTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[300],
      child: SafeArea(
        child: Scaffold(
            body: Container(
              padding: EdgeInsets.all(8),
              color: Color(0xFFF5F5F5),
              child: Column (
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child:  Text(
                      'Check Out',
                      style: GoogleFonts.kanit(
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Column(
                            children: [
                              Text(
                                "สถานที่",
                                style: GoogleFonts.kanit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[300]
                                ),
                              ),

                              Divider(),

                              Text(
                                checkIn.placeName,
                                style: GoogleFonts.kanit(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 50,
                          ),

                          Column(
                            children: [
                              Text(
                                "เช็คอินเมื่อ " + getTimeCheckIn(checkIn.timeCheckIn),
                                style: GoogleFonts.kanit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: (){},
                                    child: Text(
                                      'เช็คเอาท์',
                                      style: GoogleFonts.kanit(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Colors.white
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        padding: EdgeInsets.symmetric(horizontal: 50 , vertical: 25),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50)
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                ],
              ),
            )
        ),
      ),
    );

  }
}
