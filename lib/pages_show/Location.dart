
import 'package:covidapp/models/CheckInModel.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:covidapp/pages/CheckInPage.dart';
import 'package:covidapp/pages/CheckoutPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class LocationPage extends StatefulWidget {

  final User user;

  const LocationPage({ Key key,@required this.user }) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState(user: user);
}

class _LocationPageState extends State<LocationPage> {

  _LocationPageState({this.user});

  User user;

  Stream<CheckIn> verifyStatus() =>
      Stream.periodic(Duration(seconds: 1)).asyncMap((_) => getIsCheckIn());

  Future<CheckIn> getIsCheckIn() async{
    var uri = Uri.parse("${hostname}/timeline/checkin.php?userID=${user.userID}");
    var response = await http.get(uri);

    CheckIn checkIn = checkInFromJson(response.body);
    return checkIn;
  }

  Widget getWidget(CheckIn checkIn) {
    switch(checkIn.isCheckout){
      case true:
        return CheckInPage(user: user);
      case false:
        return CheckOutPage(user: user, checkIn: checkIn,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[400],
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFF5F5F5),
            padding: EdgeInsets.all(16),
            child: StreamBuilder(
              stream: verifyStatus(),
              builder: (context, snapshotStream) {
                switch(snapshotStream.connectionState) {
                  case ConnectionState.waiting :
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default :
                    if (snapshotStream.hasError) {
                      return Center(
                        child: Text("Error is occured"),
                      );
                    }
                    CheckIn checkIn = snapshotStream.data;
                    bool isCheckIn = checkIn.isCheckout;
                    return Column(
                      children: [

                        isCheckIn ?
                            Text(
                              'CHECK IN',
                              style: GoogleFonts.kanit(
                                color: Colors.lightBlue[400],
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                              ),
                            )
                            :
                            Text(
                              'CHECK OUT',
                              style: GoogleFonts.kanit(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                              ),
                            ),

                        Expanded(
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: checkIn.isCheckout ? Colors.blue[700] : Colors.red[600], width: 4),
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text(
                                    "สถานที่",
                                    style: GoogleFonts.kanit(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue
                                    ),
                                  ),

                                  Divider(),

                                  getWidget(checkIn),


                                ],
                              ),
                            )
                        ),

                      ],
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}