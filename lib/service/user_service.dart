import 'dart:convert';

import 'package:covidapp/constants.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserService {


  Future<User> getUserDetail(String studentID, String status,List<RiskArea> placeRisk) async{
    var urlgetUser = Uri.parse("${hostname}/getdata/getuserdatabase.php?id=${studentID}");
    var response = await http.get(urlgetUser);
    List userJson = json.decode(response.body);
    print(userJson.first);

    Map<String, dynamic> userMap = userJson.first;
    User user = User.fromJson(userMap, status, placeRisk);
    return user;
  }

  Future<Login> login(String username, String password) async {
    var urlLogin = Uri.parse("${hostname}/signin/login.php");
    var response = await http.post(urlLogin,
        body: {"user_username": username, "user_password": password});

    Map<String , dynamic> data = json.decode(response.body);
    Login loginData = Login.fromJson(data);
    return loginData;
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

class Login {

  String userID;
  String status;
  String message;
  String errMsg;
  List<RiskArea> places;

  Login({this.userID, this.status, this.message, this.errMsg, this.places});

  Login.fromJson(Map<String, dynamic> json) {
    userID = (json["userID"] == null) ? null : json["userID"];
    status = (json["status"] == null) ? null : json["status"];
    message = (json["msg"] == null) ? null : json["msg"];
    errMsg = (json["errMsg"] == null) ? null : json["errMsg"];
    places = List<RiskArea>();
    if (json["places"] != null) {

      json["places"].forEach((v) {
        places.add(new RiskArea.fromJson(v));
      });
    }
  }

}

class RiskArea {
  String riskAreaID;
  String riskAreaName;
  String riskAreaDate;
  String placeID;
  String latitude;
  String longtitude;
  DateTime startDate;
  DateTime endDate;
  String adminID;
  String statusID;
  String epidemicID;
  String epidemicTopic;
  String epidemicContent;
  String epidemicImage;
  String epidemicDate;
  String epidemicStatus;

  RiskArea({
    this.riskAreaID,
    this.riskAreaName,
    this.riskAreaDate,
    this.placeID,
    this.latitude,
    this.longtitude,
    this.startDate,
    this.endDate,
    this.adminID,
    this.statusID,
    this.epidemicID,
    this.epidemicTopic,
    this.epidemicContent,
    this.epidemicImage,
    this.epidemicDate,
    this.epidemicStatus
  });

  RiskArea.fromJson(Map<String, dynamic> json) {
    riskAreaID = (json["riskarea_id"] == null) ? null : json["riskarea_id"];
    riskAreaName = (json["riskarea_name"] == null) ? null : json["riskarea_name"];
    riskAreaDate = (json["riskarea_date"] == null) ? null : json["riskarea_date"];
    placeID = (json["placeID"] == null) ? null : json["placeID"];
    latitude  = (json["latitude"] == null) ? null : json["latitude"];
    longtitude = (json["longtitude"] == null) ? null : json["longtitude"];
    startDate = (json["startDate"] == null) ? null : DateTime.parse(json["startDate"]);
    endDate = (json["endDate"] == null) ? null : DateTime.parse(json["endDate"]);
    adminID = (json["admin_id"] == null) ? null : json["admin_id"];
    statusID = (json["status_id"] == null) ? null : json["status_id"];
    epidemicID = (json["epidemic_id"] == null) ? null : json["epidemic_id"];
    epidemicTopic = (json["epidemic_topic"] == null) ? null : json["epidemic_topic"];
    epidemicContent = (json["epidemic_content"] == null) ? null : json["epidemic_content"];
    epidemicImage = (json["epidemic_image"] == null) ? null : json["epidemic_image"];
    epidemicDate = (json["epidemic_date"] == null) ? null : json["epidemic_date"];
    epidemicStatus = (json["epidemic_status"] == null) ? null : json["epidemic_status"];
  }
}