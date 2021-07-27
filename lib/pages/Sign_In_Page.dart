import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:covidapp/pages/Container_Page.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    var url = Uri.parse(
        "http://172.20.10.8/ConnectDBProject/connectApp/signin/login.php");
    var response = await http.post(url,
        body: {"user_username": username.text, "user_password": password.text});
    var data = json.decode(response.body);

    if (data != "Error") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('username', data);
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HomePageTwo();
        }));
      });
    } else {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.warning,
            title: "ไม่สามารถเข้าสู่ระบบได้",
            text: "โปรดตรวจสอบความถูกต้องของ \n username และ password ของท่าน",
          ));
    }
  }

  // void validate(){
  //   if(formKey.currentState!.validate()){
  //     print('validate');
  //   }else{
  //     print('Not validate');
  //   }
  // }

  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[275],
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: SizedBox(height: 100),
                ),
                Text(
                  'Sign In',
                  style: GoogleFonts.kanit(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff33A9EF),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: username,
                    autofocus: true,
                    validator: RequiredValidator(errorText: 'กรุณากรอกชื่อ '),
                    decoration: InputDecoration(
                      hintText: 'Username Or E-mail',
                      prefixIcon: Icon(Icons.account_circle_rounded),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    //keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: password,
                    obscureText: isHiddenPassword,
                    validator:
                        RequiredValidator(errorText: 'กรุณากรอกรหัสผ่าน '),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.visibility),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 350,
                  height: 55,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Color(0xffA2DAFF),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        login();
                      }
                    },
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.kanit(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
