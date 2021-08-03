import 'package:covidapp/pages/Capture_Face.dart';
import 'package:covidapp/pages/Form_Page.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  //TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  void validate() {
    if (formKey.currentState.validate()) {
      print('validate');
    } else {
      print('Not validate');
    }
  }

  TextEditingController _controller = TextEditingController();

  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {

    String passwordString;

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
                  'Sign Up',
                  style: GoogleFonts.kanit(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff33A9EF),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: username,
                  //autofocus: true,
                  validator: RequiredValidator(errorText: 'กรุณากรอกชื่อ'),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.account_circle_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: email,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'กรุณากรอกอีเมลล์'),
                    EmailValidator(errorText: 'กรุณากรอกอีเมลล์ที่ถูกต้อง')
                  ]),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   controller: phone,
                //   validator: RequiredValidator(errorText: 'กรุณากรอกเบอร์โทรศัพท์'),
                //   decoration:
                //   InputDecoration(
                //     hintText: 'Phone' ,
                //     prefixIcon: Icon(Icons.phone_android_rounded) ,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(30)
                //     ),
                //   ),
                //   keyboardType: TextInputType.phone,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                TextFormField(
                  controller: password,
                  obscureText: isHiddenPassword,
                  validator: RequiredValidator(errorText: 'กรุณากรอกรหัสผ่าน'),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onChanged: (value) => passwordString = value,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: confirmpassword,
                  obscureText: isHiddenPassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Confirms Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: InkWell(
                      child: Icon(Icons.visibility),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  validator: (val) => MatchValidator(errorText: 'รหัสผ่านไม่ตรงกัน').validateMatch(val, passwordString)
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 350,
                  height: 55,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Color(0xffA2DAFF),
                    onPressed: () {
                      validate();
                      if (formKey.currentState.validate()) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return FormPage(
                              username.text, email.text, password.text);
                        }));
                      }
                    },
                    child: Text(
                      'Sign Up',
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
        ),
      ),
    );
  }
}
