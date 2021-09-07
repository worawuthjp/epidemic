import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:covidapp/constants.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages_show/Profile_User.dart';
import 'package:covidapp/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  User user;
  String picture;
  String fullname;
  String studentID;
  String faculty;
  String department;
  String tel;
  String address;
  String person;

  EditProfilePage({this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState(user: user);
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user;
  String picture;
  String fullname;
  String studentID;
  String faculty;
  String department;
  String tel;
  String address;
  String person;

  _EditProfilePageState(
      {this.user});

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

    picture = user.picture;
    fullname = user.fullName;
    studentID = user.userID;
    faculty = user.faculty;
    department = user.department;
    tel = user.tel;
    address = user.address;
    person = user.person;

    userfullname = TextEditingController(text: fullname);
    userstudentID = TextEditingController(text: studentID);
    userfaculty = TextEditingController(text: faculty);
    userdepartment = TextEditingController(text: department);
    usertel = TextEditingController(text: tel);
    useraddress = TextEditingController(text: address);
    userperson = TextEditingController(text: person);
    super.initState();
  }


  // void editUserData() {
  //   var url = Uri.parse(
  //       "${hostname}/edit/editUserData.php");
  //   http.post(url, body: {
  //     "user_studentID": userstudentID.text,
  //     "user_fullname": userfullname.text,
  //     "user_faculty": userfaculty.text,
  //     "user_department": userdepartment.text,
  //     "user_tel": usertel.text,
  //     "user_address": useraddress.text,
  //     "user_person": userperson.text,
  //   });
  // }

  Future handleEditUserData() async{
    String isUpdate = await UserService().updateUserProfile(
        userstudentID.text,
        userfullname.text,
        userfaculty.text,
        userdepartment.text,
        usertel.text,
        useraddress.text,
        userperson.text
    );

    User userEdit = User(
      userID: user.userID,
      fullName: userfullname.text,
      faculty: userfaculty.text,
      department: userdepartment.text,
      tel: usertel.text,
      address: useraddress.text,
      person: userperson.text,
      username: user.username,
      email: user.email,
      picture: user.picture,
      status: user.status
    );

    if (isUpdate == "SUCCESS") {
      Navigator.pop(context, userEdit);
    }else if (isUpdate == "ERROR") {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: "ERROR",
              text: "ไม่สามารถแก้ไขข้อมูลส่วนตัวได้"
          )
      );
    }
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
                    'Edit Profile',
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
                child: (user.picture == null || user.picture == "" )?
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 60,
                  ),
                ) :
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      "${hostname}/signup/avataruser/${user.picture}"),
                  backgroundColor: Colors.transparent,
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
                    handleEditUserData();
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
    );
  }
}
