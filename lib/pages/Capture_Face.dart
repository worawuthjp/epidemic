
import 'dart:convert';
import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:covidapp/constants.dart';
import 'package:covidapp/pages/Container_Page.dart';
import 'package:covidapp/pages/Sign_In_Page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:covidapp/main.dart';
import 'package:covidapp/pages/Form_Page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

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
  File imgFile;
  final ImagePicker _picker = ImagePicker();

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

  Future getImage(ImageSource source) async {
    // var image = await ImagePickerGC.pickImage(
    //   context: context,
    //   source: source,
    //   cameraIcon: Icon(
    //     Icons.add,
    //     color: Colors.red,
    //   ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    // );
    // setState(() {
    //   _image = File(image.path);
    // });
    var image = await _picker.getImage(source: source);
    setState(() {
      imgFile = File(image.path);
    });
  }

  Future<File> getImageFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future register() async {
    final uri = Uri.parse("${hostname}/signup/signup.php");
    var request = http.MultipartRequest('POST', uri);
    if (imgFile != null) {
      var pic = await http.MultipartFile.fromPath("image", imgFile.path);
      request.files.add(pic);
    }
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

    // var response = await request.send();

    http.Response response = await http.Response.fromStream(await request.send());
    print("Result: ${response.statusCode}");
    print("Response ${response.body}");

    var data = json.decode(response.body);

    if (response.statusCode == 200 && data["isSent"]) {
      print('Insert User info. & Can Sent E-mail');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MyApp(),
        ),
            (route) => false,
      );
    }
    else {
      print('Not Insert User Info.');
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        title: "ลงทะเบียนไม่สำเร็จ",
        text: "กรุณาลองอีกครั้ง"
        )
      );
    }
  }

  @override
  void initState() {
    super.initState();
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
          // Container(
          //   child: CircleAvatar(
          //       backgroundColor: Colors.blue,
          //       radius: 120,
          //       child: imgFile != null
          //           ? Container(
          //             child: CircleAvatar(
          //                 backgroundColor: Colors.white,
          //                 radius: 120,
          //                 child: _image == null
          //                     ? Container(
          //                   // decoration: BoxDecoration(
          //                   //     shape: BoxShape.circle,
          //                   //     image: DecorationImage(
          //                   //         image: Image.file(imgFile)
          //                   //         fit: BoxFit.fill)),
          //                   child: ClipRRect(
          //                       borderRadius: const BorderRadius.all(
          //                           Radius.circular(120)),
          //                       child: FittedBox(
          //                           fit: BoxFit.fill,
          //                           child: Image.file(
          //                             imgFile,
          //                             width: 120,
          //                             height: 120,
          //                           )
          //                       )
          //                   ),
          //                 ) : Container(
          //                   decoration: BoxDecoration(
          //                     shape: BoxShape.circle,
          //                   ),
          //                   child: FittedBox(
          //                       fit: BoxFit.fill,
          //                       child: Icon(
          //                         Icons.person,
          //                         color: Colors.white,
          //                       )
          //                   ),
          //               ),
          //             )
          //
          //               // child: ClipRRect(
          //               //     borderRadius: const BorderRadius.all(
          //               //         Radius.circular(500)),
          //               //     child: Image.file(_image)),
          //           )
          //   )
          // ),

          Container(
            child: imgFile != null ?
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 120,
              backgroundImage: imgFile != null
                ? FileImage(imgFile)
                : Container(
                child: Icon(Icons.add),
              ),
            )
            :
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 120,
              child: Container(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            )

          ),
              // : Container(
              //     child: CircleAvatar(
              //         backgroundColor: Colors.white,
              //         radius: 120,
              //         child: _image == null
              //             ? Container()
              //             : Container(
              //                 decoration: BoxDecoration(
              //                     shape: BoxShape.circle,
              //                     image: DecorationImage(
              //                         image: new FileImage(_image),
              //                         fit: BoxFit.fill)),
              //                 // child: ClipRRect(
              //                 //     borderRadius: const BorderRadius.all(
              //                 //         Radius.circular(500)),
              //                 //     child: Image.file(_image)),
              //               )),
              //   ),
          SizedBox(
            height: 15,
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.47,
            child: RaisedButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[400], width: 2)
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[400],
                        ),
                      ),

                      SizedBox(
                        width: 8,
                      ),

                      Text(
                        "ถ่ายรูป",
                        style: GoogleFonts.kanit(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA2DAFF),
                        ),
                      )
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xffF7F9FA),
            ),
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
                register();
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
