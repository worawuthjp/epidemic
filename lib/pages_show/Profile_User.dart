import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:covidapp/constants.dart';
import 'package:covidapp/main.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:covidapp/pages/EditProfile.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUser extends StatefulWidget {
  final User user;

  const ProfileUser({Key key,@required this.user}) : super(key: key);

  @override
  _ProfileUserState createState() => _ProfileUserState(user: user);
}

class _ProfileUserState extends State<ProfileUser> {

  User user;
  User userEdit;

  _ProfileUserState({this.user});

  Future<List> getData() async {
    String studentID = user.userID;
    var url = Uri.parse(
        "${hostname}/vaccine/getVaccine.php?id=$studentID");
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }
          if (snapshot.hasData) {
            List data = snapshot.data;
            return (userEdit == null)
            ? profileWidget(user, data)
            : profileWidget(userEdit, data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget profileWidget(User user, List detailVaccine) {
    List list = detailVaccine;
    String picture = user.picture;
    String fullname = user.fullName;
    String studentID = user.userID;
    String faculty = user.faculty;
    String department = user.department;
    String tel = user.tel;
    String address = user.address;
    String person = user.person;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 50)),
                  Text(
                    'Profile',
                    style: GoogleFonts.kanit(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      "${hostname}/signup/avataruser/$picture"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      // width: 341,
                        height: 370,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(31))),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 15, 10, 5),
                          child: Row(
                            children: [
                              Text(
                                'ชื่อผู้ใช้งาน :',
                                style: GoogleFonts.kanit(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "$fullname",
                                style: GoogleFonts.kanit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 15, 10, 5),
                          child: Row(
                            children: [
                              Text(
                                'รหัสนักศึกษา :',
                                style: GoogleFonts.kanit(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "$studentID",
                                style: GoogleFonts.kanit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 15, 10, 5),
                          child: Row(
                            children: [
                              Text(
                                'คณะ :',
                                style: GoogleFonts.kanit(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "$faculty",
                                style: GoogleFonts.kanit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 15, 10, 5),
                          child: Row(
                            children: [
                              Text(
                                'ภาควิชา :',
                                style: GoogleFonts.kanit(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "$department",
                                style: GoogleFonts.kanit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 15, 10, 5),
                          child: Row(
                            children: [
                              Text(
                                'เบอร์โทรศัพท์ที่ติดต่อได้ :',
                                style: GoogleFonts.kanit(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "$tel",
                                style: GoogleFonts.kanit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 15, 10, 5),
                          child: Row(
                            children: [
                              Text(
                                'ที่อยู่ปัจจุบัน :',
                                style: GoogleFonts.kanit(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "$address",
                                style: GoogleFonts.kanit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                              )
                            ],
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.all(20),
                          padding: EdgeInsets.fromLTRB(40, 15, 10, 5),
                          child: Row(
                            children: [
                              Text(
                                'ข้อมูลบุคคลที่ติดต่อได้ :',
                                style: GoogleFonts.kanit(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "$person",
                                style: GoogleFonts.kanit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 15, 10, 5),
                          child: Row(
                            children: [
                              Text(
                                'สถานะฉีดวัคซีน :',
                                style: GoogleFonts.kanit(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              list.isEmpty
                                  ? Text(
                                "กรุณาแสดงผลการฉีดวัคซีน",
                                style: GoogleFonts.kanit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffFF0000)),
                              )
                                  : list[0]['user_status'] == "อนุมัติ" ||
                                  list[0]['user_status'] == "ยืนยัน"
                                  ? Text(
                                'ได้รับการยืนยันแล้ว',
                                style: GoogleFonts.kanit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff38FD07)),
                              )
                                  : list[0]['user_status'] == "No" ||
                                  list[0]['user_status'] == "no"
                                  ? Text(
                                "ยังไม่ได้รับการยืนยัน",
                                style: GoogleFonts.kanit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffFF0000)),
                              )
                                  : Text('')
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),

              Container(
                height: 42,
                width: 240,
                child: TextButton(
                  onPressed: () {
                    onTapChangedPassword(user);
                  },
                  child: Center(
                    child: Text(
                      "เปลี่ยนรหัสผ่าน",
                      style: GoogleFonts.kanit(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 5,
              ),
              Container(
                height: 42,
                width: 240,
                child: RaisedButton.icon(
                  onPressed: () async{
                    userEdit = await Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return EditProfilePage(user: user);
                        }));
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: Text(
                    'แก้ไขข้อมูลส่วนตัว',
                    style: GoogleFonts.kanit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Color(0xffA2DAFF),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 42,
                width: 240,
                child: RaisedButton.icon(
                  onPressed: () {
                    logout();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Color(0xffA2DAFF),
                  ),
                  label: Text(
                    'ออกจากระบบ',
                    style: GoogleFonts.kanit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffA2DAFF)),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<void> onTapChangedPassword(User user) async {

    var uri = Uri.parse("${hostname}/reset-password/index.php?userID=${user.userID}");
    var response = await http.get(uri);
    var data = json.decode(response.body);

    bool isSendEmail = data["isSent"];

    if(isSendEmail){
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success,
              title: "รีเซตเรียบร้อย",
              text: "โปรดเปลี่ยนรหัสผ่านในอีเมลล์"
          )
      );
    }
    else{
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "ไม่สามารถรีเซ็ตได้",
          )
      );
    }
  }

}
