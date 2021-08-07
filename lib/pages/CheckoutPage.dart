import 'dart:convert';

import 'package:covidapp/constants.dart';
import 'package:covidapp/models/CheckInModel.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CheckOutPage extends StatefulWidget {

  final User user;
  final CheckIn checkIn;

  const CheckOutPage({Key key,@required this.user,@required this.checkIn}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState(user: user, checkIn: checkIn);
}

class _CheckOutPageState extends State<CheckOutPage> {

  _CheckOutPageState({this.user, this.checkIn});
  User user;
  CheckIn checkIn;
  String flag = "detail";

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 100),
            transitionBuilder: (child, animation) => ScaleTransition(
              child: SizedBox.expand(child: child,),
              scale: animation,
            ),
            child:  handleCheckOutPage()
        ),
      ),
    );
  }

  Future<String> checkout(String userID) async{
    var uri = Uri.parse("${hostname}/timeline/checkout.php");
    var response = await http.post(uri, body: {
      "userID" : userID
    });
    Map<String, dynamic> data = json.decode(response.body);
    String message = data["msg"];
    print("Checkout : Message => ${message}");
    return message;
  }

  Widget handleCheckOutPage() {
    switch(flag){
      case "detail" :
        return Container(
            key: Key('1'),
            child: detailCheckOutPage(user, checkIn)
        );
      case "verify" :
        return Container(
            key: Key('2'),
          child: verifyCheckOutPage(user),
        );
    }

  }

  Widget detailCheckOutPage(User user, CheckIn checkIn) {
    return checkIn != null?
    Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              manageSpace(checkIn.placeName),
              style: GoogleFonts.kanit(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),

            Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "เช็คอินเมื่อ ${getTimeCheckIn(checkIn.timeCheckIn)} น.",
                            style: GoogleFonts.kanit(
                              color: Colors.lightBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.red[900],
                                  Colors.red[600]
                                ]
                            ),
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: (){
                                flag = "verify";
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                child: Text(
                                  "ออกจากสถานที่",
                                  style: GoogleFonts.kanit(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
            ),

          ],
        ),
      ),
    )
    :
    Center(
      child: Text(
        manageSpace("ไม่มีข้อมูลสถานที่"),
        style: GoogleFonts.kanit(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.grey
        ),
      ),
    );
  }

  Widget verifyCheckOutPage(User user) {
    return Center(
      child: FutureBuilder(
        future: checkout(user.userID),
        builder: (context, snapshotCheckOut){
          if(!snapshotCheckOut.hasData){
            return statusCheckOut("loading");
          }else{
            if(snapshotCheckOut.hasError){
              return statusCheckOut("error");
            }
            else{
              String message = snapshotCheckOut.data;
              return statusCheckOut(message);
            }
          }
        },
      ),
    );
  }

  Widget statusCheckOut(String state) {
    Widget widgetIcon;
    String word;
    Color color;
    double width = MediaQuery.of(context).size.width *0.3;
    switch(state){
      case "loading" :
        color = Colors.lightBlue[400];
        widgetIcon = CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(color));
        word = "กำลังโหลดข้อมูล";
        break;

      case "error" :
        color = Colors.yellow[800];
        widgetIcon = Icon(
          Icons.warning_amber_rounded,
          color: color,
          size: width,
        );
        word = "Some error is Occurred";
        break;

      case "success" :
        color = Colors.green[600];
        widgetIcon = Icon(
          Icons.file_download_done,
          color: color,
          size: width,
        );
        word = "เช็คเอาท์สำเร็จ";
        break;
    }
    return showStatusCheckOut(widgetIcon, word, color);
  }

  Widget showStatusCheckOut(Widget widget, String word, Color color) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: widget,
            ),

            Text(
              manageSpace(word),
              style: GoogleFonts.kanit(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            )

          ],
        ),
      ),
    );
  }

  String verifyTime(int time ) {
    String correctTime = "";
    if(time < 10)
      correctTime = "0" + time.toString();
    else
      correctTime = time.toString();
    return correctTime;
  }

  String getTimeCheckIn(DateTime time) {
    String timeHour = verifyTime(time.hour);
    String timeMin = verifyTime(time.minute);
    String timeCheckIn = timeHour + ":" + timeMin;
    return timeCheckIn;
  }

  String manageSpace(String str){
    return str.trim().replaceAll("[ ]+", " ");
  }

}
