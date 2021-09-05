import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:covidapp/models/Nearby.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:covidapp/service/place_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class CheckInPage extends StatefulWidget {

  final User user;
  const CheckInPage({Key key,@required this.user}) : super(key: key);

  @override
  _CheckInPageState createState() => _CheckInPageState(user: user);
}

class _CheckInPageState extends State<CheckInPage> {
  
  FlutterLocalNotificationsPlugin localNotification = FlutterLocalNotificationsPlugin();

  _CheckInPageState({this.user});
  User user;
  bool isLoading = false;
  int flag = 0;
  List<Nearby> placeList;
  Nearby placeSelect;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future initialize() async {
    var androidInitialize = AndroidInitializationSettings('ic_launcher');
    var iOSInitialize = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    await localNotification.initialize(initializationSettings);
  }

  sendNotification() async {
    var androidDetails = AndroidNotificationDetails('channelId',
        'Local Notification', 'This is the description of the Notification, you can write anything',
    color: Colors.blue,
    enableLights: true,
    enableVibration: true,
    largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    styleInformation: MediaStyleInformation(
      htmlFormatContent: true, htmlFormatTitle: true
    ),
    importance: Importance.max);

    var iOSDetails = IOSNotificationDetails();

    var generalNotificationDetails = NotificationDetails(
      android: androidDetails, iOS: iOSDetails);

    await localNotification.show(0, "สถานะการเช็คอิน",
        'คุณอยู่ในพื้นที่เสี่ยง โปรดกักตัว 14 วัน', generalNotificationDetails);
  }
  
  Future<LatLng> getUserLocation() async{

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    Location location = new Location();
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        flag = 0;
      }
    }

    _locationData = await location.getLocation();

    return LatLng(_locationData.latitude, _locationData.longitude);
  }

  Future<List<Nearby>> getPlaceNearbyUser(LatLng latLng) async {
    int radius = 500;
    var nearbyURL = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
            "location=${latLng.latitude},${latLng.longitude}"
            "&radius=${radius.toString()}"
            "&key=${placeAPI}"
    );
    List<Nearby> placeList = [];
    var response = await http.get(nearbyURL);
    var data = json.decode(response.body);
    print(data["status"]);
    if (data["status"] == "OK") {
      List<String> placeName = [];
      for (var position in data["results"]) {
        Nearby place = Nearby.fromJson(position);
        placeName.add(place.name);
        placeList.add(place);
      }
      print("Place in ${radius} meters is : ${placeName}");
      this.placeList = placeList;
    }
    return placeList;
  }

  Future<List<Nearby>> _getHandlePlaceNearby() async{
    LatLng userLocation = await getUserLocation();
    List<Nearby> placeMapList = await getPlaceNearbyUser(userLocation);
    return placeMapList;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 100),
          transitionBuilder: (child, animation) => ScaleTransition(
            child: SizedBox.expand(child: child,),
            scale: animation,
          ),
          child:  handleCheckInPage()
        ),
      ),
    );
  }

  Widget handleCheckInPage() {
    switch(flag){
      case 0 :
        return Container(
            key: Key('1'),
            child: startCheckInPage()
        );
      case 1 :
        return Container(
            key: Key('2'),
            child: selectPlaceCheckInPage()
        );
      case 2 :
        return Container(
            key: Key('3'),
            child: detailCheckInPage(placeSelect)
        );
    }
  }

  Future<bool> checkin(String userID,LatLng latLng , String placeName, String placeID) async {

    var uri = Uri.parse("${hostname}/timeline/checkin.php") ;

    print("Location: ${placeName}");
    print("PlaceID: ${placeID}");

    var response = await http.post(uri, body: {
      "userID" : userID,
      "lat" : latLng.latitude.toString(),
      "long" : latLng.longitude.toString(),
      "placeName" : placeName,
      "placeID" : placeID
    });

    Map<String, dynamic> data = json.decode(response.body);
    String message = data["msg"];
    int status = data["statusCode"];
    bool isRisk = data["isRisk"];
    print("Check-in : message => " + message);
    print("Check-in : isRisk => ${isRisk.toString()}");

    sendNotification();
    await Future.delayed(Duration(seconds: 1));

    return isRisk;
  }

  Widget detailCheckInPage(Nearby placeMap){
    return placeMap != null?
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                  flex: 2,
                    child: Text(
                      manageSpace(placeSelect.name),
                      style: GoogleFonts.kanit(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ),

                Expanded(
                  flex: 3,
                    child: FutureBuilder(
                      future: checkin(user.userID, LatLng(placeMap.geometry.location.lat, placeMap.geometry.location.lng), placeMap.name, placeMap.placeId),
                      builder: (context, snapshotCheckIn) {
                        if (!snapshotCheckIn.hasData){
                          return statusCheckIn("Loading");
                        }
                        else {
                          if(snapshotCheckIn.hasError) {
                            return statusCheckIn("Error");
                          }else{
                            bool isRisk = snapshotCheckIn.data;
                            String state = isRisk ? "Risk" : "Complete";
                            return statusCheckIn(state);
                          }
                        }
                      },
                    )
                )

              ],
            ),
          ),
        )
        :
        Center(
          child: Text(
            manageSpace("ไม่มีข้อมูลสถานที่"),
            style: GoogleFonts.kanit(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.grey
            ),
          ),
        );
  }

  Widget statusCheckIn(String state) {
    Widget widgetIcon;
    String word;
    Color color;
    double width = MediaQuery.of(context).size.width *0.3;
    switch(state){
      case "Loading" :
        color = Colors.lightBlue[400];
        widgetIcon = CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(color));
        word = "กำลังเช็คอิน";
        break;
      case "Error" :
        color = Colors.yellow[800];
        widgetIcon = CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(color));
        word = "Some error is occured";
        break;
      case "Complete" :
        color = Colors.green[600];
        widgetIcon = Icon(
          Icons.file_download_done,
          color: color,
          size: width,
        );
        word = "เช็คอินสำเร็จ";
        break;
      case "Risk" :
        color = Colors.red[600];
        widgetIcon = Icon(
          Icons.warning_amber_rounded,
          color: color,
          size: width,
        );
        word = "เช็คอินสำเร็จ\nพื้นที่มีความเสี่ยง";
        break;
    }
    return showStatusCheckIn(widgetIcon, word, color);
  }

  Widget showStatusCheckIn(Widget widget, String word, Color color) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [

            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: widget,
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                manageSpace(word),
                style: GoogleFonts.kanit(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget startCheckInPage() {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              "โปรดทำการเลือกสถานที่",
              style: GoogleFonts.kanit(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            Container(
                margin: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.blue[900],
                            Colors.blue[600]
                          ]
                      ),
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {
                          ++flag;
                        },
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "เลือกสถานที่",
                              style: GoogleFonts.kanit(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            )

          ],
        ),
    );
  }

  Widget selectPlaceCheckInPage() {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "โปรดเลือกสถานที่ของท่าน",
                style: GoogleFonts.kanit(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
              ),
            ),

            Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: _getHandlePlaceNearby(),
                    builder: (context, snapshotFuture) {
                      if (!snapshotFuture.hasData) {
                        return Center(child: CircularProgressIndicator(),);
                      }
                      else {
                        if (snapshotFuture.hasError) {
                          return Center(child: Text("Some error is occurred."),);
                        }
                        else {
                          List<Nearby> placeMapList = snapshotFuture.data;
                          if(placeMapList.length == 0) {
                            return Center(
                              child: Text(
                                "ไม่มีข้อมูลสถานที่ใกล้เคียง",
                                style: GoogleFonts.kanit(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24
                                ),
                              ),
                            );
                          }
                          return Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.5,
                            child: ListView.builder(
                              itemCount: placeMapList.length,
                              itemBuilder: (context, index) {
                                Nearby place = placeMapList[index];
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: index == 0 ? 0 : 8,
                                      bottom: index == placeMapList.length - 1 ? 0 : 8 ),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.blue[900],
                                            Colors.blue[600]
                                          ]
                                      ),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: (){
                                        placeSelect = place;
                                        ++flag;
                                        print(placeSelect.name);
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 16),
                                          child: Row(
                                            children: [

                                              Expanded(
                                                child: Padding(                                    // Expanded(

                                                    padding: const EdgeInsets.only(left: 16),
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [

                                                          Text(
                                                            manageSpace(place.name),
                                                            style: GoogleFonts.kanit(
                                                              fontSize: 24,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white,
                                                            ),
                                                            maxLines: 3,
                                                            textAlign: TextAlign.start,
                                                          ),

                                                          Padding(
                                                            padding: EdgeInsets.symmetric(vertical: 8),
                                                            child: Text(
                                                              manageSpace(place.vicinity),
                                                              style: GoogleFonts.kanit(
                                                                  fontSize: 14,
                                                                  color: Colors.white
                                                              ),
                                                              textAlign: TextAlign.justify,
                                                              softWrap: false,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),

                                                          Divider(),

                                                          Container(
                                                            margin: EdgeInsets.only(top: 8),
                                                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(16),
                                                                color: Colors.white
                                                            ),
                                                            child: Text(
                                                                'เช็คอิน',
                                                                style: GoogleFonts.kanit(
                                                                    color: Colors.blue[800],
                                                                    fontSize: 14
                                                                )
                                                            ),
                                                          )

                                                        ],
                                                      ),
                                                    )
                                                ),
                                              ),

                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                            ),
                          );
                        }
                      }
                    }
                  )
                )
            ),

          ],
        ),
    );
  }

  String manageSpace(String str){
    return str.trim().replaceAll("[ ]+", " ");
  }
}

