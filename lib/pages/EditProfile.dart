import 'package:covidapp/constants.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages_show/Profile_User.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  String picture;
  String fullname;
  String studentID;
  String faculty;
  String department;
  String tel;
  String address;
  String person;

  EditProfilePage(
      {this.picture,
      this.fullname,
      this.studentID,
      this.faculty,
      this.department,
      this.tel,
      this.address,
      this.person});

  @override
  _EditProfilePageState createState() => _EditProfilePageState(
      picture: picture,
      fullname: fullname,
      studentID: studentID,
      faculty: faculty,
      department: department,
      tel: tel,
      address: address,
      person: person);
}

class _EditProfilePageState extends State<EditProfilePage> {
  String picture;
  String fullname;
  String studentID;
  String faculty;
  String department;
  String tel;
  String address;
  String person;

  _EditProfilePageState(
      {this.picture,
      this.fullname,
      this.studentID,
      this.faculty,
      this.department,
      this.tel,
      this.address,
      this.person});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userfullname;
  TextEditingController userstudentID;
  TextEditingController userfaculty;
  TextEditingController userdepartment;
  TextEditingController usertel;
  TextEditingController useraddress;
  TextEditingController userperson;

  @override
  void initState() {
    userfullname = TextEditingController(text: fullname);
    userstudentID = TextEditingController(text: studentID);
    userfaculty = TextEditingController(text: faculty);
    userdepartment = TextEditingController(text: department);
    usertel = TextEditingController(text: tel);
    useraddress = TextEditingController(text: address);
    userperson = TextEditingController(text: person);
    super.initState();
  }

  void editUserData() {
    var url = Uri.parse(
        "${hostname}/edit/editUserData.php");
    http.post(url, body: {
      "user_studentID": userstudentID.text,
      "user_fullname": userfullname.text,
      "user_faculty": userfaculty.text,
      "user_department": userdepartment.text,
      "user_tel": usertel.text,
      "user_address": useraddress.text,
      "user_person": userperson.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 30)),
                  Text(
                    'Edit Proflie',
                    style: GoogleFonts.kanit(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 30)),
                  Text(
                    '$studentID',
                    style: GoogleFonts.kanit(
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black),
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
                        width: 341,
                        height: 500,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(31))),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
                            child: TextField(
                              controller: userfullname,
                              decoration: InputDecoration(
                                  labelText: "ชื่อ-นามสกุล",
                                  suffixIcon: Icon(Icons.person),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                          //   child: TextField(
                          //     controller: userstudentID,
                          //     decoration: InputDecoration(
                          //         labelText: "รหัสนักศึกษา",
                          //         suffixIcon: Icon(Icons.phone_iphone),
                          //         border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(10))),
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: TextField(
                              controller: userfaculty,
                              decoration: InputDecoration(
                                  labelText: "คณะ",
                                  suffixIcon: Icon(Icons.home_work),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: TextField(
                              controller: userdepartment,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.school),
                                  labelText: "ภาควิชา",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: TextField(
                              controller: usertel,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.phone_iphone),
                                  labelText: "เบอร์โทรศัพท์ที่ติดต่อได้",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: TextField(
                              controller: useraddress,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.home),
                                  labelText: "ที่อยู่ปัจจุบัน",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: TextField(
                              controller: userperson,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.person_search),
                                  labelText: "ข้อมูลบุคคลที่ติดต่อได้",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    // editUserData();
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //   return ProfileUser(
                    //
                    //       userfullname.text,
                    //       picture,
                    //       userstudentID.text,
                    //       userfaculty.text,
                    //       userdepartment.text,
                    //       usertel.text,
                    //       useraddress.text,
                    //       userperson.text);
                    // }));
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  label: Text(
                    'ยืนยัน',
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
              )
            ],
          ),
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
