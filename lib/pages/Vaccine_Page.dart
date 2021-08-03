
import 'dart:io';
import 'package:covidapp/constants.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages_show/Vaccine_Complet.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

class VaccinePage extends StatefulWidget {
  String username;
  String picture;
  String studentID;

  VaccinePage(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  @override
  _VaccinePageState createState() =>
      _VaccinePageState(username, picture, studentID);
}

class _VaccinePageState extends State<VaccinePage> {
  File imgFile;

  String username;
  String picture;
  String studentID;
  final ImagePicker _picker = ImagePicker();

  String status = "No";
  String now = DateFormat('yyyy-MM-dd -- HH:mm:ss').format(DateTime.now());

  _VaccinePageState(String username, String picture, String studentID) {
    this.username = username;
    this.picture = picture;
    this.studentID = studentID;
  }

  Future getImage(ImageSource source) async {
    // var image = await Image.pickImage(
    //     context: context,
    //     source: source,
    //     cameraIcon: Icon(
    //       Icons.add,
    //       color: Colors.red,
    //     ));
    var image = await _picker.getImage(source: source);
    setState(() {
      imgFile = File(image.path);
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse(
        "${hostname}/vaccine/addVaccine.php");
    var request = http.MultipartRequest('POST', uri);
    var pic = await http.MultipartFile.fromPath("image", imgFile.path);
    request.files.add(pic);
    request.fields['user_vaccine'] = username;
    request.fields['user_status'] = status;
    request.fields['user_studentID'] = studentID;
    request.fields['user_date'] = now;

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploaded');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VaccineShowPage(username, picture, studentID)));
    } else {
      print("Image Not Uploaded");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[200],
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: RichText(
                    text: TextSpan(
                        text: "$username\n",
                        style: GoogleFonts.kanit(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.lightBlue),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Vaccine Update',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue))
                        ]),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.only(right: 30),
                  child: CircleAvatar(
                    radius: 27,
                    backgroundImage: NetworkImage(
                        "${hostname}/signup/avataruser/$picture"),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.only(right: 65),
              child: Text(
                'ถ่ายรูปเพื่ออัพเดตการฉีดวัคซีนแล้ว',
                style: GoogleFonts.kanit(
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    color: Colors.black45),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            imgFile == null
                ? Container(
                    child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 120,
                        child: imgFile == null
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: new FileImage(imgFile),
                                        fit: BoxFit.fill)),
                              )),
                  )
                : Container(
                    child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 120,
                        child: imgFile == null
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: new FileImage(imgFile),
                                        fit: BoxFit.fill)),
                              )),
                  ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0)),
                SizedBox(
                  height: 40,
                  width: 160,
                  child: RaisedButton.icon(
                      color: Color(0xffF7F9FA),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      icon: Icon(
                        Icons.photo_camera,
                        size: 25,
                        color: Colors.grey[500],
                      ),
                      label: Text(
                        'เลือกรูปภาพ',
                        style: GoogleFonts.kanit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffA2DAFF)),
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 160,
                  height: 40,
                  child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.white,
                      onPressed: () {
                        uploadImage();
                      },
                      icon: Icon(
                        Icons.upload_file,
                        size: 25,
                        color: Colors.grey[500],
                      ),
                      label: Text(
                        'อัปโหลดรูปภาพ',
                        style: GoogleFonts.kanit(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffA2DAFF)),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250,
              height: 42,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Color(0xffA2DAFF),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          VaccineShowPage(username, picture, studentID)));
                },
                icon: Icon(
                  Icons.check_circle_rounded,
                  size: 25,
                  color: Colors.white,
                ),
                label: Text(
                  'เช็คสถานะการฉีดวัคซีน',
                  style: GoogleFonts.kanit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
