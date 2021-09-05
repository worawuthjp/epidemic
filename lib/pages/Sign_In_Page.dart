import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:covidapp/home.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:covidapp/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  String urlLogin = "${hostname}/signin/login.php";

  // Future login() async {
  //   print("location");
  //
  //   var response = await http.post(urlLogin,
  //       body: {"user_username": username.text, "user_password": password.text});
  //
  //   print(response.statusCode);
  //   Map<String , dynamic> data = json.decode(response.body);
  //   if (response.statusCode != 200) {
  //     ArtSweetAlert.show(
  //         context: context,
  //         artDialogArgs: ArtDialogArgs(
  //           type: ArtSweetAlertType.warning,
  //           title: "Not Response",
  //           text: "โปรดเช็คอินเทอร์เน็ตของท่าน",
  //         ));
  //   }
  //   else {
  //     if (data["msg"] != "error") {
  //
  //       String userID = data["userID"];
  //       var urlgetUser = Uri.parse("${hostname}/getdata/getuserdatabase.php?id=${userID}");
  //       response = await http.get(urlgetUser);
  //       List userJson = json.decode(response.body);
  //       print(userJson.first);
  //
  //       Map<String, dynamic> userMap = userJson.first;
  //
  //         User user = User(
  //             userID: userMap["user_studentID"],
  //             fullName: userMap["user_fullname"],
  //             faculty: userMap["user_faculty"],
  //             department: userMap["user_department"],
  //             tel: userMap["user_tel"],
  //             address: userMap["user_address"],
  //             person: userMap["user_person"],
  //             username: userMap["user_username"],
  //             email: userMap["user_email"],
  //             picture: userMap["user_img"],
  //             status: data["status"]
  //         );
  //
  //       print("Username : => ${user.userID}");
  //
  //       setState(() {
  //         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //           return HomePage(user: user,);
  //         }));
  //       });
  //     } else {
  //       ArtSweetAlert.show(
  //           context: context,
  //           artDialogArgs: ArtDialogArgs(
  //             type: ArtSweetAlertType.warning,
  //             title: "ไม่สามารถเข้าสู่ระบบได้",
  //             text: "โปรดตรวจสอบรหัสผ่าน หรือ อีเมลล์ของท่าน",
  //           ));
  //     }
  //   }
  // }

  Future handleLogin(String username, String password) async{
    Map<String, dynamic> loginDetail = await UserService().login(username, password);
    if (loginDetail["msg"] != "error") {
      String userID = loginDetail["userID"];
      String status = loginDetail["status"];

      setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HomePage(userID: userID, userStatus: status,);
        }));
      });
    }
    else{
      String message = loginDetail["errMsg"];
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.warning,
          title: "Login FAIL",
          text: message,
        ));
    }
  }

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
                    textInputAction: TextInputAction.next,
                    //keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: password,
                    obscureText: isHiddenPassword,
                    validator: RequiredValidator(errorText: 'กรุณากรอกรหัสผ่าน '),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.visibility),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    textInputAction: TextInputAction.done,
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
                    onPressed: () async{
                      if (formKey.currentState.validate()) {
                        handleLogin(username.text, password.text);
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
