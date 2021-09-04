import 'package:covidapp/Show_Box.dart';
import 'package:covidapp/constants.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:covidapp/pages/Hospital.dart';
import 'package:covidapp/pages/QRCodePage.dart';
import 'package:covidapp/pages/Timeline.dart';
import 'package:covidapp/pages_show/Profile_User.dart';
import 'package:covidapp/pages_show/Search_epidemic_page.dart';
import 'package:covidapp/pages/ShowNewsList.dart';
//import 'package:covidapp/pages/Map_Show.dart';
import 'package:covidapp/pages/Today_status.dart';
import 'package:covidapp/pages/Vaccine_Page.dart';

import 'package:covidapp/pages_show/ShowNewsDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'DataRisk.dart';

class HomePageTwo extends StatefulWidget {

  final User user;

  const HomePageTwo({Key key,@required this.user}) : super(key: key);

  @override
  _HomePageTwoState createState() => _HomePageTwoState(user: user);
}

class _HomePageTwoState extends State<HomePageTwo> {

  _HomePageTwoState({this.user});

  User user;
  TodayStatus todayStatus;

  Future getEmail() {
    setState(() {
      String userID = user.userID;
      print("User ID is : " + userID);
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();


  bool isVisibilityNews = false;
  bool isVisibilityStatus = true;

  Future<List> getNews() async {
    var url = Uri.parse("${hostname}/getNews/getNew.php") ;
    var response = await http.get(url);
    return json.decode(response.body);
  }

  Widget showStatusUser(User user) {
    Widget icons;
    Color color;
    switch (user.status) {
      case "มีความเสี่ยงสูง" :
        color = Colors.red;
        icons = Icon(Icons.mood_bad, color: Colors.white, size: 24,);
        break;
      case "เฝ้าระวัง":
        color = Colors.yellow[800];
        icons = Icon(Icons.mood_rounded, color: Colors.white, size: 24,);
        break;
      case "ไม่มีความเสี่ยง":
        color = Colors.green;
        icons =
            Icon(Icons.emoji_emotions_outlined, color: Colors.white, size: 24,);
        break;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 80),
      decoration: BoxDecoration(
          border: Border.all(color: color, width: 3),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                  color: color
              ),
              child: icons
          ),

          Expanded(
            child: Container(
              child: Text(
                user.status,
                style: GoogleFonts.kanit(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )

        ],
      ),
    );
  }

  // Future<List> getData() async {
  //   // var url = Uri.parse(
  //   //     "http://172.20.10.8/ConnectDBProject/connectApp/getdata/getuserdatabase.php?id=${username}");
  //   // var response = await http.get(url);
  //
  //   var response = await http.get("https://lotto.myminesite.com/getdata/getuserdatabase.php?id=${userID}");
  //   return json.decode(response.body);
  // }

  // Future<TodayStatus> getNews() async {
  //   var url = Uri.parse(
  //       'https://covid19.th-stat.com/json/covid19v2/getTodayCases.json');
  //   var response = await http.get(url);
  //   TodayStatus todayStatus = todayStatusFromJson(response.body);
  //   print(response.body);
  //   return todayStatus;
  // }

  @override
  void initState() {
    super.initState();
    getEmail();
    // getNews();
  }

  // @override
  // Widget build(BuildContext context) {
  //
  //   return FutureBuilder(
  //     future: getNews(),
  //     builder: (context, snapshot) {
  //         if(!snapshot.hasData){
  //           return Center(child: CircularProgressIndicator(),);
  //         }else{
  //           if(snapshot.hasError) {
  //             return Center(
  //               child: Text(
  //                 "Some Error is occurred",
  //                 style: GoogleFonts.kanit(
  //                     color: Colors.grey,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 24
  //                 ),
  //               ),
  //             );
  //           }else{
  //             TodayStatus todayStatus = snapshot.data;
  //             int confirmed = todayStatus.confirmed;
  //             int newConfirmed = todayStatus.newConfirmed;
  //             int recovered = todayStatus.recovered;
  //             int newRecovered = todayStatus.newRecovered;
  //             int hospitalized = todayStatus.hospitalized;
  //             int newHospitalized = todayStatus.newHospitalized;
  //             int deaths = todayStatus.deaths;
  //             int newDeaths = todayStatus.newDeaths;
  //             String updateDate = todayStatus.updateDate;
  //             return Items(
  //               user: user,
  //               confirmed: confirmed,
  //               newConfirmed: newConfirmed,
  //               recovered: recovered,
  //               newRecovered: newRecovered,
  //               hospitalized: hospitalized,
  //               newHospitalized: newHospitalized,
  //               deaths: deaths,
  //               newDeaths: newDeaths,
  //               updateDate: updateDate,
  //             );
  //           }
  //         }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getNews(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          if(snapshot.hasError) {
            return Center(
              child: Text(
                "Some Error is occurred",
                style: GoogleFonts.kanit(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
              ),
            );
          }else{
            return homepageWidget(user);
          }
        }
      },
    );
  }

  Widget homepageWidget (User user){
    String now = DateFormat('kk').format(DateTime.now());
    var timeNow = int.parse(now);
    String studentID = user.userID;
    String fullname = user.fullName;
    String faculty = user.faculty;
    String department = user.department;
    String tel = user.tel;
    String address = user.address;
    String person = user.person;
    String username = user.username;
    String email = user.email;
    String picture = user.picture;
    String status = user.status;

    return Container(
        color: Colors.lightBlue[400],
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                        title: timeNow > 11 && timeNow <= 17
                            ? Text(
                          'Good Afternoon',
                          style: GoogleFonts.kanit(
                              fontSize: 25,
                              //fontWeight: FontWeight.w600,
                              color: Colors.lightBlue[300]),
                        )
                            : timeNow > 17 && timeNow <= 23
                            ? Text(
                          'Good Evening',
                          style: GoogleFonts.kanit(
                              fontSize: 25,
                              //fontWeight: FontWeight.w600,
                              color: Colors.lightBlue[300]),
                        )
                            : Text(
                          'Good Morning',
                          style: GoogleFonts.kanit(
                              fontSize: 25,
                              //fontWeight: FontWeight.w600,
                              color: Colors.lightBlue[300]),
                        ),
                        subtitle: Text(
                          username,
                          style: GoogleFonts.kanit(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlue),
                        ),
                        trailing: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue
                          ),
                          // child: CircleAvatar(
                          //   radius: 60,
                          //   backgroundImage: NetworkImage(
                          //       "http://172.20.10.8/ConnectDBProject/connectApp/signup/avataruser/$picture"),
                          //   backgroundColor: Colors.transparent,
                          // ),
                          child: user.picture == null ?
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ) :
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                "${hostname}/signup/avataruser/${user.picture}"),
                            backgroundColor: Colors.transparent,
                          ),
                        )
                    ),

                    user.status != null ?
                    showStatusUser(user): Container(),

                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        child: TextFormField(
                          controller: search,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'ค้นหาข้อมูลโรคระบาด',
                              hintStyle: GoogleFonts.kanit(
                                  color: Color(0xffacacac), fontSize: 18),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return SearchEpidemicPage(
                                            username: username,
                                            picture: picture,
                                            search: search.text,
                                            studentID: studentID,
                                            // gender: gender,
                                            // address: address,
                                            // phone: phone,
                                            // education: education,
                                            // person: person,
                                            // nameUser: name,
                                            // profilePic: picture,
                                          );
                                        }));
                                  },
                                  icon: Icon(Icons.search),
                                  color: Color(0xffA2DAFF)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ))),
                        ),
                      ),
                    ),
                    Row(
                      children: [

                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Ink(
                                decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15))),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => QRCodePage(user: user)));
                                  },
                                  icon: Image.asset(
                                    'assets/images/qr-code.png',
                                  ),
                                  iconSize: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text('QR Code',
                                style: GoogleFonts.kanit(
                                    color: Colors.black54, fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),),

                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Ink(
                                decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15))),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return VaccinePage(username, picture, studentID);
                                        }));
                                  },
                                  icon: Image.asset(
                                    'assets/images/vaccine.png',
                                  ),
                                  iconSize: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text('Vaccine',
                                  style: GoogleFonts.kanit(
                                      color: Colors.black54, fontSize: 13)),
                            ),
                          ],
                        ),),

                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Ink(
                                decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15))),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return Hospital();
                                        }));
                                  },
                                  icon: Image.asset(
                                    'assets/images/hospital.png',
                                  ),
                                  iconSize: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text('Hospital',
                                  style: GoogleFonts.kanit(
                                      color: Colors.black54, fontSize: 13)),
                            ),
                          ],
                        ),),

                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Ink(
                                decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15))),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return DataRisk(username, picture, studentID);
                                        }));
                                  },
                                  icon: Image.asset(
                                    'assets/images/risk.png',
                                  ),
                                  iconSize: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text('Risk\nAssignment',
                                style: GoogleFonts.kanit(
                                    color: Colors.black54, fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),),

                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: FutureBuilder<List>(
                          future: getNews(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print("error");
                            }
                            if (snapshot.hasData) {
                              return News(
                                list: snapshot.data,
                                name: username,
                                profilePic: picture,
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}

class Items extends StatefulWidget {
  final User user;
  final int confirmed;
  final int newConfirmed;
  final int recovered;
  final int newRecovered;
  final int hospitalized;
  final int newHospitalized;
  final int deaths;
  final int newDeaths;
  final String updateDate;

  Items(
      {this.user,
        this.confirmed,
        this.newConfirmed,
        this.recovered,
        this.newRecovered,
        this.hospitalized,
        this.newHospitalized,
        this.deaths,
        this.newDeaths,
        this.updateDate});

  @override
  _ItemsState createState() => _ItemsState(
      user: user,
      confirmed: confirmed,
      newConfirmed: newConfirmed,
      recovered: recovered,
      newRecovered: newRecovered,
      hospitalized: hospitalized,
      newHospitalized: newHospitalized,
      deaths: deaths,
      newDeaths: newDeaths,
      updateDate: updateDate);
}

class _ItemsState extends State<Items> {
  final User user;
  final int confirmed;
  final int newConfirmed;
  final int recovered;
  final int newRecovered;
  final int hospitalized;
  final int newHospitalized;
  final int deaths;
  final int newDeaths;
  final String updateDate;
  _ItemsState(
      {
        this.user,
        this.confirmed,
        this.newConfirmed,
        this.recovered,
        this.newRecovered,
        this.hospitalized,
        this.newHospitalized,
        this.deaths,
        this.newDeaths,
        this.updateDate});

  bool isVisibilityNews = false;
  bool isVisibilityStatus = true;

  Future<List> getNews() async {
    var url = Uri.parse("${hostname}/getNews/getNew.php") ;
    var response = await http.get(url);
    return json.decode(response.body);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();

  Widget showStatusUser(User user){

    Widget icons;
    Color color;
    switch(user.status){
      case "มีความเสี่ยงสูง" :
        color = Colors.red;
        icons = Icon(Icons.mood_bad, color: Colors.white, size: 24,);
        break;
      case "เฝ้าระวัง":
        color = Colors.yellow[800];
        icons = Icon(Icons.mood_rounded, color: Colors.white, size: 24,);
        break;
      case "ไม่มีความเสี่ยง":
        color = Colors.green;
        icons = Icon(Icons.emoji_emotions_outlined, color: Colors.white, size: 24,);
        break;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 80),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 3),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                  color: color
              ),
              child: icons
          ),

          Expanded(
            child: Container(
              child: Text(
                user.status,
                style: GoogleFonts.kanit(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    String now = DateFormat('kk').format(DateTime.now());
    var timeNow = int.parse(now);
    String studentID = user.userID;
    String fullname = user.fullName;
    String faculty = user.faculty;
    String department = user.department;
    String tel = user.tel;
    String address = user.address;
    String person = user.person;
    String username = user.username;
    String email = user.email;
    String picture = user.picture;
    String status = user.status;

    return Container(
      color: Colors.lightBlue[400],
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    title: timeNow > 11 && timeNow <= 17
                        ? Text(
                      'Good Afternoon',
                      style: GoogleFonts.kanit(
                          fontSize: 25,
                          //fontWeight: FontWeight.w600,
                          color: Colors.lightBlue[300]),
                    )
                        : timeNow > 17 && timeNow <= 23
                        ? Text(
                      'Good Evening',
                      style: GoogleFonts.kanit(
                          fontSize: 25,
                          //fontWeight: FontWeight.w600,
                          color: Colors.lightBlue[300]),
                    )
                        : Text(
                      'Good Morning',
                      style: GoogleFonts.kanit(
                          fontSize: 25,
                          //fontWeight: FontWeight.w600,
                          color: Colors.lightBlue[300]),
                    ),
                    subtitle: Text(
                      username,
                      style: GoogleFonts.kanit(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightBlue),
                    ),
                    trailing: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue
                      ),
                      // child: CircleAvatar(
                      //   radius: 60,
                      //   backgroundImage: NetworkImage(
                      //       "http://172.20.10.8/ConnectDBProject/connectApp/signup/avataruser/$picture"),
                      //   backgroundColor: Colors.transparent,
                      // ),
                      child: user.picture == null ?
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ) :
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "${hostname}/signup/avataruser/${user.picture}"),
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  ),

                  user.status != null ?
                  showStatusUser(user): Container(),

                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      child: TextFormField(
                        controller: search,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'ค้นหาข้อมูลโรคระบาด',
                            hintStyle: GoogleFonts.kanit(
                                color: Color(0xffacacac), fontSize: 18),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return SearchEpidemicPage(
                                          username: username,
                                          picture: picture,
                                          search: search.text,
                                          studentID: studentID,
                                          // gender: gender,
                                          // address: address,
                                          // phone: phone,
                                          // education: education,
                                          // person: person,
                                          // nameUser: name,
                                          // profilePic: picture,
                                        );
                                      }));
                                },
                                icon: Icon(Icons.search),
                                color: Color(0xffA2DAFF)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ))),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 10, 0),
                        child: Ink(
                          decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                // isVisibilityNews = !isVisibilityNews;
                                // isVisibilityStatus = !isVisibilityStatus;
                              });

                            },
                            icon: Image.asset(
                              'assets/images/news.png',
                            ),
                            iconSize: 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Ink(
                          decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return VaccinePage(username, picture, studentID);
                                  }));
                            },
                            icon: Image.asset(
                              'assets/images/vaccine.png',
                            ),
                            iconSize: 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Ink(
                          decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return Hospital();
                                  }));
                            },
                            icon: Image.asset(
                              'assets/images/hospital.png',
                            ),
                            iconSize: 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
                        child: Ink(
                          decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return DataRisk(username, picture, studentID);
                                  }));
                            },
                            icon: Image.asset(
                              'assets/images/risk.png',
                            ),
                            iconSize: 50,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(42, 4, 0, 0),
                        child: Text('QR Code',
                            style: GoogleFonts.kanit(
                                color: Colors.black54, fontSize: 13)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(53, 4, 0, 0),
                        child: Text('Vaccine',
                            style: GoogleFonts.kanit(
                                color: Colors.black54, fontSize: 13)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(43, 4, 0, 0),
                        child: Text('Hospital',
                            style: GoogleFonts.kanit(
                                color: Colors.black54, fontSize: 13)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(23, 5, 0, 0),
                        child: Text('Risk Assignment',
                            style: GoogleFonts.kanit(
                                color: Colors.black54, fontSize: 12)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: isVisibilityNews,
                    child: FutureBuilder<List>(
                        future: getNews(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            print("error");
                          }
                          if (snapshot.hasData) {
                            return News(
                              list: snapshot.data,
                              name: username,
                              profilePic: picture,
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),

                  confirmed != null ?
                  Visibility(
                      visible: isVisibilityStatus,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                          children: [
                            ShowBox(
                              width: double.infinity,
                              height: 120,
                              title: 'ติดเชื้อสะสม',
                              text: 'ราย',
                              total: confirmed,
                              backgroundColor: Colors.redAccent.shade700,
                              textSize: 10,
                              titleSize: 20,
                              titleHeight: 1.5,
                              totalSize: 45,
                              totalHeight: 1.35,
                              newTotal: newConfirmed,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ShowBox(
                                  width: 120,
                                  height: 120,
                                  title: 'หายแล้ว',
                                  total: recovered,
                                  backgroundColor: Colors.greenAccent[700],
                                  titleSize: 20,
                                  titleHeight: 2,
                                  totalSize: 25,
                                  totalHeight: 1.75,
                                  newTotal: newRecovered,
                                ),
                                ShowBox(
                                  width: 120,
                                  height: 120,
                                  title: 'รักษาอยู่ใน รพ.',
                                  total: hospitalized,
                                  backgroundColor: Colors.lightBlue[400],
                                  titleSize: 16,
                                  titleHeight: 2.5,
                                  totalSize: 25,
                                  totalHeight: 1.75,
                                  newTotal: newHospitalized,
                                ),
                                ShowBox(
                                  width: 120,
                                  height: 120,
                                  title: 'เสียชีวิต',
                                  total: deaths,
                                  backgroundColor: Colors.grey[700],
                                  titleSize: 20,
                                  titleHeight: 2,
                                  totalSize: 25,
                                  totalHeight: 1.75,
                                  newTotal: newDeaths,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 250),
                              // width: double.infinity,
                              //height: 50,
                              // decoration: BoxDecoration(
                              // color: Colors.orange,
                              // borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                'วันที่อัพเดทผู้ติดเชื้อ' + '\n' + '$updateDate',
                                style: GoogleFonts.kanit(
                                    fontSize: 13,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                  )
                  :
                  Center(
                    child: Text(
                      "ไม่มีข้อมูล",
                      style: GoogleFonts.kanit(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );

  }
}

class News extends StatelessWidget {
  final List list;
  final String name;
  final String profilePic;
  News({this.list, this.name, this.profilePic});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text(
              'News Today',
              style: GoogleFonts.kanit(
                  fontSize: 30,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 300,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list == null ? 0 : list.length,
                itemBuilder: (BuildContext context, int index) {
                  String topic = list[index]['news_topic'];
                  String content = list[index]['news_content'];
                  String id = list[index]['news_id'];
                  String picture = list[index]['news_image'];
                  return Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    margin: EdgeInsets.all(25),
                    child: InkWell(
                      child: Image.network(
                        //"http://172.20.10.8/covid/getNews/avataruser/${list[index]['news_image']}",
                        "${host_back_url}/back/backend/upload/${list[index]['news_image']}",
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return ShowNewsDetails(
                                id: id,
                                topic: topic,
                                content: content,
                                picture: picture,
                                name: name,
                                profilePic: profilePic,
                              );
                            }));
                      },
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}


