import 'dart:convert';

import 'package:covidapp/models/map/PlaceMap.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class Hospital extends StatefulWidget {
  const Hospital({Key key}) : super(key: key);

  @override
  _HospitalState createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {

  Set<Marker> _markers;
  GoogleMapController _mapController;
  List<PlaceMap> _nearbyLocation;
  Position position;

  void onMapCreate(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<Position> getUserPosition() async{

    Position userLocation;
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      userLocation = null;
    }

    print("userLocation: ${userLocation.latitude} , ${userLocation.longitude}");

    return userLocation;
  }

  Future<void> _addMarkerToMap({Position position, String placeName}) async{
    var point = LatLng(position.latitude, position.longitude);
    _markers.add(Marker(
        markerId: MarkerId(placeName),
        position: point,
        onTap: () async {
          _mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: point,
                  zoom: 12
              )
            )
          );
        }
      )
    );
  }

  CameraPosition onCameraMoved(Position userPosition, double zoom) {
    return CameraPosition(
        target: LatLng(userPosition.latitude, userPosition.longitude),
        zoom: zoom
    );
  }

  Future<List<PlaceMap>> getHospitalNearby({Position userLocation}) async {
    int type;
    int radius = 500;
    var nearbyURL = Uri.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        "location=${userLocation.latitude},${userLocation.longitude}"
        "&radius=${radius.toString()}"
        "&type=${type}"
        "&key=${placeAPI}"
    );
    var response = await http.get(nearbyURL);
    var data = json.decode(response.body);

    List<PlaceMap> placesMap = [];
    print(data["status"]);
    if (data["status"] == "OK") {
      List<String> placeName = [];
      for(var position in data["results"]){
        PlaceMap place = placeMapFromJson(position);
        placeName.add(place.placeName);
        placesMap.add(place);
      }
      print("Place in ${radius} is : ${placeName}");
    }

    return placesMap;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[400],
      child: SafeArea(
        child: Scaffold(
            body: Container(
              // child: FutureBuilder(
              //   future: ,//Todo Something Future
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {

              //     }
              //     return Center(child: CircularProgressIndicator(),);
              //   },
              ),
            )
        ),
      );
  }
}
