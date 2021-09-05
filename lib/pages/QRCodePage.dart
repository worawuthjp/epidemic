import 'package:covidapp/constants.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatefulWidget {

  final User user;

  const QRCodePage({Key key,@required this.user}) : super(key: key);

  @override
  _QRCodePageState createState() => _QRCodePageState(user: user);
}

class _QRCodePageState extends State<QRCodePage> {

  User user;
  _QRCodePageState({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[300],
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(16),
            color: Color(0xFFF5F5F5),
            child: Column (
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      "QR Code",
                      style: GoogleFonts.kanit(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightBlue),
                    ),
                    trailing: Container(
                      width: 60,
                      height: 60,
                      child: user.picture == null ?
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

                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      child: Center(
                        child: Text(
                          "โปรดแสกน QR Code\nเพื่อยืนยันตัวตนก่อนเข้าอาคารเรียน",
                          style: GoogleFonts.kanit(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ),

                Expanded(
                  flex: 5,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: QrImage(
                        data: user.userID,
                        version: QrVersions.auto,
                        size: 250,
                      ),
                    ),
                  )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
