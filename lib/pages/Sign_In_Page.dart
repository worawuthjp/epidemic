import 'dart:convert';
import 'dart:typed_data';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:covidapp/home.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:covidapp/pages/Container_Page.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  String urlLogin = hostname + "/signin/login.php";

  Future login() async {
    // var url = Uri.parse(
    //     "http://172.20.10.8/ConnectDBProject/connectApp/signin/login.php");
    // var response = await http.post(url,
    //     body: {"user_username": username.text, "user_password": password.text});

    var response = await http.post(urlLogin,
        body: {"user_username": username.text, "user_password": password.text});

    // var response = await http.post(urlLogin,
    //     body: {"user_username": "Yokwcth", "user_password": "1234"});

    if (response.statusCode != 200) {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.warning,
            title: "Not Response",
            text: "โปรดเช็คอินเทอร์เน็ตของท่าน",
          ));
    }
    else {
      Map<String , dynamic> data = json.decode(response.body);
      if (data["msg"] != "error") {
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.setString('userID', data["userID"]);

        String userID = data["userID"];
        response = await http.get("https://lotto.myminesite.com/getdata/getuserdatabase.php?id=${userID}");
        var userJson = json.decode(response.body);
        print(userJson);

        List<User> users = [];

        for(var u in userJson) {
          User user = User(
              userID: u["user_studentID"],
              fullName: u["user_fullname"],
              faculty: u["user_faculty"],
              department: u["user_department"],
              tel: u["user_tel"],
              address: u["user_address"],
              person: u["user_person"],
              username: u["user_username"],
              email: u["user_email"],
              picture: u["user_img"]
          );

          users.add(user);
        }

        print(users[0].userID);

        setState(() {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return HomePage(user: users[0],);
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
                    validator: RequiredValidator(errorText: 'กรุณากรอกรหัสผ่าน '),
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
