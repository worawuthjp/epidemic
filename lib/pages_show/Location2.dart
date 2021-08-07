// import 'dart:convert';
//
// import 'package:art_sweetalert/art_sweetalert.dart';
// import 'package:covidapp/constants.dart';
// import 'package:covidapp/models/CheckInModel.dart';
// import 'package:covidapp/models/UserModel.dart';
// import 'package:covidapp/models/map/PlaceMap.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
//
// class LocationPage extends StatefulWidget {
//
//   final User user;
//
//   const LocationPage({Key key,@required this.user}) : super(key: key);
//
//   @override
//   _LocationPageState createState() => _LocationPageState(user: user);
// }
//
// class _LocationPageState extends State<LocationPage> {
//
//   User user;
//   _LocationPageState({this.user});
//
//   List<PlaceMap> placeList;
//
//   Future<CheckIn> currentStatus() async{
//
//     var uri = Uri.parse("${hostname}/timeline/checkin.php?userID=${user.userID}");
//     var response = await http.get(uri);
//     List<PlaceMap> nearbyPlace = await checkInService();
//     // List<PlaceMap> nearbyPlace = dataPlaceTest();
//
//     if(mounted) {
//       placeList = nearbyPlace;
//       print("First Place is : ${placeList[0].placeName}");
//     }
//     CheckIn checkIn = checkInFromJson(response.body);
//     print("isCheckOut: ${checkIn.isCheckout}");
//
//     return checkIn;
//   }
//
//   Future<void> setPlaceList() async{
//     placeList = await checkInService();
//     print("placeList : ${placeList.toString()}");
//   }
//
//   Stream<CheckIn> handleCheck() async* {
//     final uri = Uri.parse("${hostname}/timeline/checkin.php?userID=${user.userID}");
//     final response = await http.get(uri);
//     final body = json.decode(response.body);
//     final checkIn = CheckIn.fromJson(body);
//     print("Status isCheckin => ${checkIn.isCheckout}");
//     if(checkIn.isCheckout) {
//       setPlaceList();
//     }
//     yield checkIn;
//   }
//
//   Future<CheckIn> checkInStatus() async {
//     final uri = Uri.parse("${hostname}/timeline/checkin.php?userID=${user.userID}");
//     final response = await http.get(uri);
//     final body = json.decode(response.body);
//     final checkIn = CheckIn.fromJson(body);
//     return checkIn;
//   }
//
//   List<PlaceMap> dataPlaceTest() {
//
//     List<PlaceMap> placeMap = [];
//     String placeName = "PaTong";
//     for (int i = 0; i < 5; i++) {
//
//       String address = "${i} หมู่ 5 ต.กำแพงแสน อ.กำแพงแสน จ.นครปฐม 73140";
//       PlaceMap place = PlaceMap("ChIJ3xJoEt4d4zARCnYZw32HUXM",
//           "โรงเรียน สารสิทธิ์พิทยาลัย ซอย หน้าสถานีรถฟ Ban Pong District, Ratchaburi, Thailand",
//           address,
//           "https://picsum.photos/250?image=9",
//           "#FF55F6",
//           13.813003,
//           99.87750199999999
//       );
//
//       print("Location: ${place.location.latitude}, ${place.location.longitude}");
//
//       placeName = placeName + " PaTong";
//       placeMap.add(place);
//     }
//
//     return placeMap;
//   }
//
//   Widget getPage(CheckIn checkIn) {
//     if (checkIn.isCheckout) {
//       return CheckinInfo(checkIn);
//     }else {
//       return CheckoutInfo(checkIn);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: handleCheck(),
//         builder: (context, snapshot) {
//           switch(snapshot.connectionState) {
//             case ConnectionState.waiting :
//               return Center(child: CircularProgressIndicator());
//             default :
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text(
//                     "404 Not Found",
//                     style: GoogleFonts.kanit(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30
//                       )
//                     )
//                   );
//               }else {
//                 CheckIn checkIn = snapshot.data;
//                 return Container(
//                   color: Colors.lightBlue[300],
//                   child: SafeArea(
//                     child: Scaffold(
//                         body: Container(
//                           padding: EdgeInsets.all(8),
//                           color: Color(0xFFF5F5F5),
//                           child: getPage(checkIn)
//                         )
//                     ),
//                   ),
//                 );
//               }
//           }
//         }
//     );
//   }
//
//   @override
//   void dispose() {
//
//     super.dispose();
//   }
//
//   Future<List<PlaceMap>> checkInService() async{
//     Position userPosition = await getUserPosition();
//     List<PlaceMap> nearbyPlaceList = await getPlaceNearbyUser(userPosition);
//     return nearbyPlaceList;
//   }
//
//   Future<Position> getUserPosition() async{
//
//     Position userLocation;
//     try {
//       userLocation = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//     } catch (e) {
//       userLocation = null;
//     }
//
//     print("userLocation: ${userLocation.latitude} , ${userLocation.longitude}");
//
//     return userLocation;
//   }
//
//   Future<List<PlaceMap>> getPlaceNearbyUser(Position userLocation) async {
//
//     int radius = 500;
//     var nearbyURL = Uri.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
//         "location=${userLocation.latitude},${userLocation.longitude}"
//         "&radius=${radius.toString()}"
//         "&key=${placeAPI}"
//     );
//     var response = await http.get(nearbyURL);
//     var data = json.decode(response.body);
//
//     List<PlaceMap> placesMap = [];
//     print(data["status"]);
//     if (data["status"] == "OK") {
//       List<String> placeName = [];
//       for(var position in data["results"]){
//         PlaceMap place = placeMapFromJson(position);
//         placeName.add(place.placeName);
//         placesMap.add(place);
//       }
//       print("Place in ${radius} is : ${placeName}");
//     }
//
//     return placesMap;
//   }
//
//   Widget CheckinInfo(CheckIn checkIn) {
//     print("Place All : ${placeList[0].placeName}");
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//
//         Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child: Text(
//             'CHECK IN',
//             style: GoogleFonts.kanit(
//                 fontSize: 50,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.blue),
//           ),
//         ),
//
//         Expanded(
//           child: Container(
//             margin: EdgeInsets.all(8),
//             padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(40),
//                 color: Colors.white
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//
//                     Container(
//                       child: Text(
//                         "สถานที่",
//                         style: GoogleFonts.kanit(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue[300]
//                         ),
//                       ),
//                     ),
//
//                     Divider(),
//
//                     Container(
//                       height: MediaQuery
//                           .of(context)
//                           .size
//                           .height * 0.5,
//                       child: ListView.builder(
//                         itemCount: placeList.length,
//                         itemBuilder: (context, index) {
//                           PlaceMap place = placeList[index];
//                           return GestureDetector(
//                             onTap: () {
//                               //Todo
//                               onTappedCheckin(user.userID, place.location, place.placeName, place.placeID);
//                             },
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                   top: index == 0 ? 0 : 8,
//                                   bottom: index == placeList.length - 1 ? 0 : 8 ),
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topRight,
//                                   end: Alignment.bottomLeft,
//                                   colors: [
//                                     Colors.blue[900],
//                                     Colors.blue[600]
//                                   ]
//                                 ),
//                                 borderRadius: BorderRadius.circular(8)
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 16),
//                                 child: Row(
//                                   children: [
//
//                                     // Expanded(
//                                     //   flex: 1,
//                                     //   child: ClipRRect(
//                                     //     borderRadius: BorderRadius.circular(30),
//                                     //     child:
//                                     //   ),
//                                     // ),
//
//
//
//                                     Expanded(
//                                       child: Padding(                                    // Expanded(
//                                         //   flex: 2,
//                                         //   child: Container(
//                                         //     padding: EdgeInsets.all(8),
//                                         //     width: 80,
//                                         //     height: 80,
//                                         //     decoration: BoxDecoration(
//                                         //       borderRadius: BorderRadius.circular(15),
//                                         //       color: Colors.white
//                                         //     ),
//                                         //     child: Image.network(
//                                         //       place.icon,
//                                         //       width: 80,
//                                         //       height: 80,
//                                         //     ),
//                                         //   ),
//                                         // ),
//                                         padding: const EdgeInsets.only(left: 16),
//                                         child: Container(
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//
//                                               Text(
//                                                 place.placeName,
//                                                 style: GoogleFonts.kanit(
//                                                     fontSize: 24,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.white,
//                                                 ),
//                                                 textAlign: TextAlign.justify,
//                                                 softWrap: false,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//
//                                               Padding(
//                                                 padding: EdgeInsets.symmetric(vertical: 8),
//                                                 child: Text(
//                                                   place.placeAddress,
//                                                   style: GoogleFonts.kanit(
//                                                       fontSize: 14,
//                                                       color: Colors.white
//                                                   ),
//                                                   textAlign: TextAlign.justify,
//                                                   softWrap: false,
//                                                   overflow: TextOverflow.ellipsis,
//                                                 ),
//                                               ),
//
//                                               Divider(),
//
//                                               Container(
//                                                 margin: EdgeInsets.only(top: 8),
//                                                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(16),
//                                                   color: Colors.white
//                                                 ),
//                                                 child: Text(
//                                                   'เช็คอิน',
//                                                   style: GoogleFonts.kanit(
//                                                     color: Colors.blue[800],
//                                                     fontSize: 14
//                                                   )
//                                                 ),
//                                               )
//
//                                             ],
//                                           ),
//                                         )
//                                       ),
//                                     ),
//
//                                   ],
//                                 )
//                               ),
//                             ),
//                           );
//                         },
//                         shrinkWrap: true,
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         )
//
//       ],
//     );
//   }
//
//   Widget CheckoutInfo(CheckIn checkIn) {
//     return Column (
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//
//         Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//           child:  Text(
//             'CHECK OUT',
//             style: GoogleFonts.kanit(
//                 fontSize: 50,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.blue),
//           ),
//         ),
//
//         Container(
//           margin: EdgeInsets.all(8),
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(40),
//               color: Colors.white
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//
//               Column(
//                 children: [
//                   Text(
//                     "สถานที่",
//                     style: GoogleFonts.kanit(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue[300]
//                     ),
//                   ),
//
//                   Divider(),
//
//                   checkIn.placeName != null ?
//                   Text(
//                     checkIn.placeName,
//                     style: GoogleFonts.kanit(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black
//                     ),
//                   )
//                   : Container(),
//
//                 ],
//               ),
//
//               SizedBox(
//                 height: 50,
//               ),
//
//               Column(
//                 children: [
//
//                   checkIn.timeCheckIn != null ?
//
//                   Text(
//                     "เช็คอินเมื่อ " + getTimeCheckIn(checkIn.timeCheckIn),
//                     style: GoogleFonts.kanit(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue
//                     ),
//                   )
//                   : Container(),
//
//                   Container(
//                     margin: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: (){
//                           onTappedCheckOut(user.userID);
//                         },
//                         child: Text(
//                           'เช็คเอาท์',
//                           style: GoogleFonts.kanit(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 30,
//                               color: Colors.white
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                             primary: Colors.red,
//                             padding: EdgeInsets.symmetric(horizontal: 50 , vertical: 25),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(50)
//                             )
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Future<void> onTappedCheckin(String userID,LatLng position , String placeName, String placeID) async {
//
//     var uri = Uri.parse("${hostname}/timeline/checkin.php") ;
//
//     var response = await http.post(uri, body: {
//       "userID" : userID,
//       "lat" : position.latitude.toString(),
//       "long" : position.longitude.toString(),
//       "placeName" : placeName,
//       "placeID" : placeID
//     });
//
//     Map<String, dynamic> data = json.decode(response.body);
//     print(data["msg"]);
//     print(data["isRisk"]);
//     if (data["msg"] == "success" && data["statusCode"] == "200") {
//       if(data["isRisk"]) {
//         ArtSweetAlert.show(
//             context: context,
//             artDialogArgs: ArtDialogArgs(
//               type: ArtSweetAlertType.warning,
//               title: "คุณอยู่ในพื้นที่เสี่ยง",
//               text: "หลังจากเช็คเอาท์กรุณากักตัว 14 วัน",
//             ));
//       }
//     }
//   }
//
//   Future<void> onTappedCheckOut(String userID) async{
//     var uri = Uri.parse("${hostname}/timeline/checkout.php");
//     var response = await http.post(uri, body: {
//       "userID" : userID
//     });
//     Map<String, dynamic> data = json.decode(response.body);
//     print(data["msg"]);
//     if(data["msg"] != "success" || data["statusCode"] == 400 || response.statusCode != 200) {
//       ArtSweetAlert.show(
//           context: context,
//           artDialogArgs: ArtDialogArgs(
//             type: ArtSweetAlertType.warning,
//             title: "ข้อมูลไม่พร้อมใช้งาน",
//             text: "โปรดตรวจสอบอินเทอร์เน็ตของท่าน",
//           ));
//     }
//   }
//
//   String getTimeCheckIn(DateTime timeCheckIn) {
//     return verifyTime(timeCheckIn.hour) + " : " + verifyTime(timeCheckIn.minute) + " น.";
//   }
//
//   String verifyTime(int time ) {
//     String correctTime = "";
//     if(time < 10)
//       correctTime = "0" + time.toString();
//     else
//       correctTime = time.toString();
//     return correctTime;
//   }
//
//
//
// }
//
