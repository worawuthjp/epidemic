import 'dart:convert';

import 'package:covidapp/constants.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserService {


  Future<User> getUserDetail(String studentID, String status) async{
    var urlgetUser = Uri.parse("${hostname}/getdata/getuserdatabase.php?id=${studentID}");
    var response = await http.get(urlgetUser);
    List userJson = json.decode(response.body);
    print(userJson.first);

    Map<String, dynamic> userMap = userJson.first;
    User user = User.fromJson(userMap, status);
    return user;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    var urlLogin = Uri.parse("${hostname}/signin/login.php");
    var response = await http.post(urlLogin,
        body: {"user_username": username, "user_password": password});

    Map<String , dynamic> data = json.decode(response.body);
    return data;
  }

  Future<String> updateUserProfile(String studentID, String fullname, String faculty, String department, String tel, String address,  String person) async{
    var uri = Uri.parse("${hostname}/edit/editUserData.php");
    var response = await http.post(uri, body: {
      "user_studentID" : studentID,
      "user_fullname" : fullname,
      "user_faculty" : faculty,
      "user_department" : department,
      "user_tel" : tel,
      "user_address" : address,
      "user_person" : person
    });
    if (response.statusCode == 200) {
     return "SUCCESS";
    }
    else{
      return "ERROR";
    }
  }

}