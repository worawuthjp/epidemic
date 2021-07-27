// import 'dart:convert';
// import 'dart:ui';
// import 'package:covidapp/Show_Box.dart';
// import 'package:covidapp/pages/DataRisk.dart';
// import 'package:covidapp/pages/Map_Show.dart';
// import 'package:covidapp/pages/Show_Epidemic_Page.dart';
// import 'package:covidapp/pages/Today_status.dart';
// import 'package:covidapp/pages/Vaccine_Page.dart';
// import 'package:http/http.dart' as http;
// import 'package:covidapp/pages/Risk_Form_Covid.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // class HomeAvatar extends StatefulWidget {
// //   @override
// //   _HomeAvatarState createState() => _HomeAvatarState();
// // }

// // class _HomeAvatarState extends State<HomeAvatar> {
// //   String username = "";

// //   Future getEmail() async {
// //     SharedPreferences preferences = await SharedPreferences.getInstance();
// //     setState(() {
// //       username = preferences.getString('username');
// //     });
// //   }
// //   Future<List> getData() async {
// //     final response =
// //     await http.get("http://192.168.1.153/covid/getdata/getuserdatabase.php?id=${username}");
// //     return json.decode(response.body);
// //   }
// //   @override
// //   void initState() {
// //     getEmail();
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<List>(
// //       future: getData(),
// //       builder: (context, snapshot) {
// //         if (snapshot.hasError) print(snapshot.error);
// //         return snapshot.hasData
// //             ? HomePage(
// //           list: snapshot.data,

// //         )
// //             : Center(
// //           child: CircularProgressIndicator(),
// //         );
// //       },
// //     );

// //   }
// // }

// class HomePage extends StatefulWidget {
//   final List list;

//   HomePage({
//     this.list,
//   });
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool isVisibilityNews = false;
//   bool isVisibilityStatus = true;

//   TodayStatus _todayStatus;

//   String valueChoose;
//   List listItem = ["Item1", "Item2"];

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   Future<void> getData() async {
//     var url = Uri.parse(
//         'http://covid19.th-stat.com/json/covid19v2/getTodayCases.json');
//     var response = await http.get(url);

//     //print(response.body);

//     setState(() {
//       _todayStatus = todayStatusFromJson(response.body);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     //String name = widget.list[1][''];
//     return SafeArea(
//       child: Container(
//         //color: Colors.grey[300],
//         child: ListView(
//           children: [
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
//                       child: RichText(
//                           text: TextSpan(
//                               text: 'Goodmorning\n',
//                               style: TextStyle(
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.lightBlue),
//                               children: const <TextSpan>[
//                             TextSpan(
//                                 text: 'Chanawee',
//                                 style: TextStyle(
//                                     fontSize: 35,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.lightBlue))
//                           ])),
//                     ),
//                     Container(
//                       padding: EdgeInsets.fromLTRB(130, 10, 10, 0),
//                       child: CircleAvatar(
//                         backgroundColor: Colors.lightBlue,
//                         radius: 27,
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(40, 60, 40, 15),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         hintText: 'Search',
//                         hintStyle:
//                             TextStyle(color: Color(0xffacacac), fontSize: 20),
//                         suffixIcon:
//                             Icon(Icons.search, color: Color(0xffA2DAFF)),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide(
//                               color: Colors.white,
//                             ))),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(25, 0, 10, 0),
//                       child: Ink(
//                         decoration: ShapeDecoration(
//                             color: Colors.white,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15))),
//                         child: IconButton(
//                           onPressed: () {
//                             //print(name);
//                             setState(() {
//                               isVisibilityNews = !isVisibilityNews;
//                               isVisibilityStatus = !isVisibilityStatus;
//                             });
//                           },
//                           icon: Image.asset(
//                             'assets/images/news.png',
//                           ),
//                           iconSize: 50,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
//                       child: Ink(
//                         decoration: ShapeDecoration(
//                             color: Colors.white,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15))),
//                         child: IconButton(
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(
//                                 builder: (BuildContext context) {
//                               return VaccinePage();
//                             }));
//                           },
//                           icon: Image.asset(
//                             'assets/images/vaccine.png',
//                           ),
//                           iconSize: 50,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
//                       child: Ink(
//                         decoration: ShapeDecoration(
//                             color: Colors.white,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15))),
//                         child: IconButton(
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(
//                                 builder: (BuildContext context) {
//                               return MapShow();
//                             }));
//                           },
//                           icon: Image.asset(
//                             'assets/images/hospital.png',
//                           ),
//                           iconSize: 50,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
//                       child: Ink(
//                         decoration: ShapeDecoration(
//                             color: Colors.white,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15))),
//                         child: IconButton(
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(
//                                 builder: (BuildContext context) {
//                               return DataRisk();
//                             }));
//                           },
//                           icon: Image.asset(
//                             'assets/images/risk.png',
//                           ),
//                           iconSize: 50,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(42, 4, 0, 0),
//                       child: Text('News',
//                           style:
//                               TextStyle(color: Colors.lightBlue, fontSize: 13)),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(53, 4, 0, 0),
//                       child: Text('Vaccine',
//                           style:
//                               TextStyle(color: Colors.lightBlue, fontSize: 13)),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(43, 4, 0, 0),
//                       child: Text('Hospital',
//                           style:
//                               TextStyle(color: Colors.lightBlue, fontSize: 13)),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(27, 5, 0, 0),
//                       child: Text('Risk assessment',
//                           style:
//                               TextStyle(color: Colors.lightBlue, fontSize: 10)),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 35),
//                 Visibility(
//                   visible: isVisibilityNews,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(27, 0, 0, 0),
//                         child: Text(
//                           'News Today',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 30,
//                               color: Colors.lightBlue),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Stack(
//                   children: [
//                     Column(
//                       children: [
//                         Visibility(
//                           visible: isVisibilityNews,
//                           child: Container(
//                             height: 300,
//                             child: ListView(
//                               scrollDirection: Axis.horizontal,
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.blueAccent,
//                                       borderRadius: BorderRadius.circular(15)),
//                                   margin: EdgeInsets.only(
//                                       left: 30, right: 30, bottom: 30),
//                                   width: 250,
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.greenAccent,
//                                       borderRadius: BorderRadius.circular(15)),
//                                   margin: EdgeInsets.only(
//                                       left: 0, right: 30, bottom: 30),
//                                   width: 250,
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.yellowAccent,
//                                       borderRadius: BorderRadius.circular(15)),
//                                   margin: EdgeInsets.only(
//                                       left: 0, right: 30, bottom: 30),
//                                   width: 250,
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.orangeAccent,
//                                       borderRadius: BorderRadius.circular(15)),
//                                   margin: EdgeInsets.only(
//                                       left: 0, right: 30, bottom: 30),
//                                   width: 250,
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.redAccent,
//                                       borderRadius: BorderRadius.circular(15)),
//                                   margin: EdgeInsets.only(
//                                       left: 0, right: 30, bottom: 30),
//                                   width: 250,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Visibility(
//                       visible: isVisibilityStatus,
//                       child: Container(
//                         padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//                         child: Column(
//                           //crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               width: double.infinity,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                   color: Colors.orange,
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: Text(
//                                 'วันที่อัพเดทผู้ติดเชื้อ' +
//                                     '\n' +
//                                     '${_todayStatus?.updateDate}',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             ShowBox(
//                               width: double.infinity,
//                               height: 120,
//                               title: 'ติดเชื้อสะสม',
//                               total: _todayStatus?.confirmed,
//                               backgroundColor: Colors.pink,
//                               titleSize: 20,
//                               titleHeight: 1.5,
//                               totalSize: 45,
//                               totalHeight: 1.35,
//                               newTotal: _todayStatus?.newConfirmed,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 ShowBox(
//                                   width: 120,
//                                   height: 120,
//                                   title: 'หายแล้ว',
//                                   total: _todayStatus?.recovered,
//                                   backgroundColor: Colors.green,
//                                   titleSize: 20,
//                                   titleHeight: 2,
//                                   totalSize: 25,
//                                   totalHeight: 1.75,
//                                   newTotal: _todayStatus?.newRecovered,
//                                 ),
//                                 ShowBox(
//                                   width: 120,
//                                   height: 120,
//                                   title: 'รักษาอยู่ใน รพ.',
//                                   total: _todayStatus?.hospitalized,
//                                   backgroundColor: Colors.brown,
//                                   titleSize: 16,
//                                   titleHeight: 2.5,
//                                   totalSize: 25,
//                                   totalHeight: 1.75,
//                                   newTotal: _todayStatus?.newHospitalized,
//                                 ),
//                                 ShowBox(
//                                   width: 120,
//                                   height: 120,
//                                   title: 'เสียชีวิต',
//                                   total: _todayStatus?.deaths,
//                                   backgroundColor: Colors.red,
//                                   titleSize: 20,
//                                   titleHeight: 2,
//                                   totalSize: 25,
//                                   totalHeight: 1.75,
//                                   newTotal: _todayStatus?.newDeaths,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
