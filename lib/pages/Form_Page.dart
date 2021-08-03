import 'package:covidapp/main.dart';
import 'package:covidapp/pages/Capture_Face.dart';
import 'package:covidapp/pages/Container_Page.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class FormPage extends StatefulWidget {
  String username;
  String email;
  String password;

  FormPage(String username, String email, String password) {
    this.username = username;
    this.email = email;
    this.password = password;
  }

  @override
  _FormPageState createState() => _FormPageState(username, email, password);
}

class _FormPageState extends State<FormPage> {
  String username;
  String email;
  String password;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController studentID = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController faculty = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController person = TextEditingController();

  _FormPageState(String username, String email, String password) {
    this.username = username;
    this.email = email;
    this.password = password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 40),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xffF7F9FA),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: FractionalOffset.center,
              child: Text(
                'กรุณากรอกให้ถูกต้อง',
                style: GoogleFonts.kanit(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xff343434)),
              ),
            ),
            Container(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 530,
                    width: 340,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 5),
                          child: TextFormField(
                            controller: fullname,
                            validator: RequiredValidator(
                                errorText: 'กรุณากรอกชื่อและนามสกุล'),
                            decoration: InputDecoration(
                                hintText: 'ชื่อ-นามสกุลจริง',
                                hintStyle: GoogleFonts.kanit(
                                    color: Color(0xffacacac), fontSize: 20)),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 5),
                          child: TextFormField(
                            controller: studentID,
                            validator: RequiredValidator(
                                errorText: 'กรุณากรอกรหัสนักศึกษาของท่าน'),
                            decoration: InputDecoration(
                                hintText: 'รหัสนักศึกษา',
                                hintStyle: GoogleFonts.kanit(
                                    color: Color(0xffacacac), fontSize: 20)),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 5),
                          child: TextFormField(
                            controller: faculty,
                            validator: RequiredValidator(
                                errorText: 'กรุณากรอกคณะของท่าน'),
                            decoration: InputDecoration(
                                hintText: 'คณะ',
                                hintStyle: GoogleFonts.kanit(
                                    color: Color(0xffacacac), fontSize: 20)),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 5),
                          child: TextFormField(
                            controller: department,
                            validator: RequiredValidator(
                                errorText: 'กรุณากรอกภาควิชาของท่าน'),
                            decoration: InputDecoration(
                              hintText: 'ภาควิชา',
                              hintStyle: GoogleFonts.kanit(
                                  color: Color(0xffacacac), fontSize: 20),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 5),
                          child: TextFormField(
                            controller: address,
                            validator: RequiredValidator(
                                errorText: 'กรุณากรอกที่อยู่'),
                            decoration: InputDecoration(
                                hintText: 'ที่อยู่ตามบัตรประชาชน',
                                hintStyle: GoogleFonts.kanit(
                                    color: Color(0xffacacac), fontSize: 20)),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 5),
                          child: TextFormField(
                            controller: tel,
                            validator: RequiredValidator(
                                errorText: 'กรุณาใส่เบอร์โทรศัพท์'),
                            decoration: InputDecoration(
                                hintText: 'เบอร์โทรศัพท์ที่ติดต่อได้',
                                hintStyle: GoogleFonts.kanit(
                                    color: Color(0xffacacac), fontSize: 20)),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 5),
                          child: TextFormField(
                            controller: person,
                            validator: RequiredValidator(
                                errorText: 'กรุณาใส่ข้อมูลบุคคลที่ติดต่อได้'),
                            decoration: InputDecoration(
                                hintText: 'ข้อมูลบุคคลที่ติดต่อได้',
                                hintStyle: GoogleFonts.kanit(
                                    color: Color(0xffacacac), fontSize: 20)),
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 293,
              height: 42,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Color(0xffA2DAFF),
                onPressed: () {
                  // String gender;
                  // if(formKey.currentState!.validate()){
                  //   if(_selectedChoice == 1){
                  //     gender = 'เพศชาย' ;
                  //     print(gender);
                  //   }
                  //   else if(_selectedChoice == 2){
                  //     gender = 'เพศหญิง' ;
                  //     print(gender);
                  //   }
                  //   else if(_selectedChoice == 3){
                  //     gender = 'อื่นๆ' ;
                  //     print(gender);
                  //   }
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (BuildContext context) {
                  //         return ContainerPage();
                  //       }
                  //     ),
                  //   );
                  // }
                  // TextEditingController name = TextEditingController();
                  // TextEditingController adDress = TextEditingController();
                  // TextEditingController phone = TextEditingController();
                  // TextEditingController aCademy = TextEditingController();
                  // TextEditingController perSon = TextEditingController();
                  if (formKey.currentState.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return CaptureFace(
                            studentID.text,
                            fullname.text,
                            faculty.text,
                            department.text,
                            tel.text,
                            address.text,
                            person.text,
                            username,
                            email,
                            password);
                      }),
                    );
                  }
                },
                child: Text(
                  'ยืนยัน',
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
      ),
    );
  }
}
