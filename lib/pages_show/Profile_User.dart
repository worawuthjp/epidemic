import 'package:covidapp/main.dart';
import 'package:covidapp/pages/EditProfile.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUser extends StatefulWidget {
  String picture;
  String fullname;
  String studentID;
  String faculty;
  String department;
  String tel;
  String address;
  String person;

  ProfileUser(String fullname, String picture, String studentID, String faculty,
      String department, String tel, String address, String person) {
    this.fullname = fullname;
    this.picture = picture;
    this.studentID = studentID;
    this.faculty = faculty;
    this.department = department;
    this.tel = tel;
    this.address = address;
    this.person = person;
  }

  @override
  _ProfileUserState createState() => _ProfileUserState(
      fullname, picture, studentID, faculty, department, tel, address, person);
}

class _ProfileUserState extends State<ProfileUser> {
  String picture;
  String fullname;
  String studentID;
  String faculty;
  String department;
  String tel;
  String address;
  String person;

  _ProfileUserState(
      String fullname,
      String picture,
      String studentID,
      String faculty,
      String department,
      String tel,
      String address,
      String person) {
    this.fullname = fullname;
    this.picture = picture;
    this.studentID = studentID;
    this.faculty = faculty;
    this.department = department;
    this.tel = tel;
    this.address = address;
    this.person = person;
  }

  Future<List> getData() async {
    var url = Uri.parse(
        "http://172.20.10.8/ConnectDBProject/connectApp/vaccine/getVaccine.php?id=$studentID");
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
            return Items(fullname, picture, studentID, faculty, department, tel,
                address, person, snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Items extends StatefulWidget {
  List list;
  String picture;
  String fullname;
  String studentID;
  String faculty;
  String department;
  String tel;
  String address;
  String person;

  Items(String fullname, String picture, String studentID, String faculty,
      String department, String tel, String address, String person, List list) {
    this.fullname = fullname;
    this.picture = picture;
    this.studentID = studentID;
    this.faculty = faculty;
    this.department = department;
    this.tel = tel;
    this.address = address;
    this.person = person;
    this.list = list;
  }

  @override
  _ItemsState createState() => _ItemsState(fullname, picture, studentID,
      faculty, department, tel, address, person, list);
}

class _ItemsState extends State<Items> {
  List list;
  String picture;
  String fullname;
  String studentID;
  String faculty;
  String department;
  String tel;
  String address;
  String person;

  _ItemsState(String fullname, String picture, String studentID, String faculty,
      String department, String tel, String address, String person, List list) {
    this.fullname = fullname;
    this.picture = picture;
    this.studentID = studentID;
    this.faculty = faculty;
    this.department = department;
    this.tel = tel;
    this.address = address;
    this.person = person;
    this.list = list;
  }

  Future<Null> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        //   backgroundColor: Colors.grey[200],
        //   elevation: 0,
        // ),
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
                    'Proflie',
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
                      "http://172.20.10.8/ConnectDBProject/connectApp/signup/avataruser/$picture"),
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
                height: 10,
              ),
              Container(
                height: 42,
                width: 240,
                child: RaisedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return EditProfilePage(
                        picture: picture,
                        fullname: fullname,
                        studentID: studentID,
                        faculty: faculty,
                        department: department,
                        tel: tel,
                        address: address,
                        person: person,
                      );
                    }));
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MyApp();
                    }));
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
      ),
    );
  }
}
