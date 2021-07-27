import 'dart:io';
import 'package:covidapp/pages/Sign_In_Page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:covidapp/main.dart';
import 'package:covidapp/pages/Form_Page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

class CaptureFace extends StatefulWidget {
  String studentID;
  String fullname;
  String faculty;
  String department;
  String tel;
  String address;
  String person;
  String username;
  String email;
  String password;

  CaptureFace(
      String studentID,
      String fullname,
      String faculty,
      String department,
      String tel,
      String address,
      String person,
      String username,
      String email,
      String password) {
    this.studentID = studentID;
    this.fullname = fullname;
    this.faculty = faculty;
    this.department = department;
    this.tel = tel;
    this.address = address;
    this.person = person;
    this.username = username;
    this.email = email;
    this.password = password;
  }

  @override
  _CaptureFaceState createState() => _CaptureFaceState(
        studentID,
        fullname,
        faculty,
        department,
        tel,
        address,
        person,
        username,
        email,
        password,
      );
}

class _CaptureFaceState extends State<CaptureFace> {
  File _image;
  File imgFile;

  String studentID;
  String fullname;
  String faculty;
  String department;
  String tel;
  String address;
  String person;
  String username;
  String email;
  String password;

  _CaptureFaceState(
      String studentID,
      String fullname,
      String faculty,
      String department,
      String tel,
      String address,
      String person,
      String username,
      String email,
      String password) {
    this.studentID = studentID;
    this.fullname = fullname;
    this.faculty = faculty;
    this.department = department;
    this.tel = tel;
    this.address = address;
    this.person = person;
    this.username = username;
    this.email = email;
    this.password = password;
  }

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      _image = File(image.path);
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse(
        "http://172.20.10.8/ConnectDBProject/connectApp/signup/signup.php");
    var request = http.MultipartRequest('POST', uri);
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    request.fields['user_studentID'] = studentID;
    request.fields['user_fullname'] = fullname;
    request.fields['user_faculty'] = faculty;
    request.fields['user_department'] = department;
    request.fields['user_tel'] = tel;
    request.fields['user_address'] = address;
    request.fields['user_person'] = person;
    request.fields['user_username'] = username;
    request.fields['user_email'] = email;
    request.fields['user_password'] = password;

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploded');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    } else {
      print('Image Not Uploded');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xffF7F9FA),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
          ),
          Container(
            padding: EdgeInsets.only(left: 40),
            alignment: FractionalOffset.topLeft,
            child: Text(
              'Profile',
              style: GoogleFonts.kanit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff33A9EF)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 40),
            alignment: FractionalOffset.topLeft,
            child: Text(
              'ถ่ายรูปหน้าตรง',
              style: GoogleFonts.kanit(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.black45),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _image == null
              ? Container(
                  child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 120,
                      child: _image == null
                          ? Container()
                          : Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: new FileImage(_image),
                                      fit: BoxFit.fill)),
                              // child: ClipRRect(
                              //     borderRadius: const BorderRadius.all(
                              //         Radius.circular(500)),
                              //     child: Image.file(_image)),
                            )),
                )
              : Container(
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 120,
                      child: _image == null
                          ? Container()
                          : Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: new FileImage(_image),
                                      fit: BoxFit.fill)),
                              // child: ClipRRect(
                              //     borderRadius: const BorderRadius.all(
                              //         Radius.circular(500)),
                              //     child: Image.file(_image)),
                            )),
                ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 50,
            width: 180,
            child: RaisedButton.icon(
                onPressed: () {
                  getImage(ImgSource.Gallery);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xffF7F9FA),
                icon: Icon(
                  Icons.photo_camera,
                  color: Colors.grey[400],
                ),
                label: Text(
                  'ถ่ายรูป',
                  style: GoogleFonts.kanit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffA2DAFF),
                  ),
                )),
          ),
          SizedBox(
            height: 100,
          ),
          SizedBox(
            width: 293,
            height: 42,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Color(0xffA2DAFF),
              onPressed: () {
                uploadImage();
                // print(studentID);
                // print(fullname);
                // print(faculty);
                // print(department);
                // print(tel);
                // print(address);
                // print(person);
                // print(username);
                // print(email);
                // print(password);

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (BuildContext context) {
                //     return MyApp();
                //   }),
                // );
              },
              child: Text(
                'ถัดไป',
                style: GoogleFonts.kanit(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
