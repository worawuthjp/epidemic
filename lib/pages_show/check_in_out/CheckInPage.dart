import 'dart:convert';

import 'package:covidapp/constants.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class CheckInPage extends StatefulWidget {

  final User user;

  const CheckInPage({Key key,@required this.user}) : super(key: key);

  @override
  _CheckInPageState createState() => _CheckInPageState(user: user);
}

class _CheckInPageState extends State<CheckInPage> {

  _CheckInPageState({this.user});
  User user;
  Position userLocation;
  GoogleMapController mapController;
  double currentCameraZoom = 15;
  String id;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Circle> circles = Set.from([Circle(
    circleId: CircleId("0"),
    center: LatLng(7.896195, 98.2954133),
    radius: 500,
  )]);

  Future<Position> _getMyLocation() async{
    try {
      userLocation =await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      userLocation = null;
    }

    getNearbyPlace();

    return userLocation;
  }

  Future<String> getNearbyPlace() async {
    print("UserLatitude : ${userLocation.latitude}, UserLongtitude : ${userLocation.longitude}");
    String nearbyURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${userLocation.latitude},${userLocation.longitude}&radius=500&key=${placeAPI}";
    var response = await http.get(nearbyURL);
    var data = json.decode(response.body);
    List result = data["results"];
    print("Place in 500m is : " + result.toString());
    return "5555";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void toggleZoom(){
    setState(() {
      if (currentCameraZoom  == 15)
        currentCameraZoom = 10;
      else
        currentCameraZoom = 15;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: _getMyLocation(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }
              else {
                return GoogleMap(
                  mapType: MapType.normal,
                    myLocationEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(userLocation.latitude, userLocation.longitude),
                      zoom: 15
                    ),
                    onCameraMove: null,
                    circles: circles,
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: (){
                toggleZoom();
                mapController.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(userLocation.latitude, userLocation.longitude), currentCameraZoom));
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                            "Your Location has been send !\nlat: ${userLocation.latitude} long: ${userLocation.longitude} ")
                      );
                    }
                );
              },
              label: Text("Send Location"),
              icon: Icon(Icons.near_me),
          ),
        ),
      ),
    );
  }
}