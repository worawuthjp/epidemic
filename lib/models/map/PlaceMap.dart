import 'dart:convert';

import 'package:covidapp/models/map/PhotoMap.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

PlaceMap placeMapFromJson(Map<String, dynamic> map) => PlaceMap.fromJson(map);

class PlaceMap {
  String placeID;
  String placeName;
  String placeAddress;
  String icon;
  String iconBackgroundColor;
  LatLng location;
  // LatLng position;
  
  factory PlaceMap.fromJson(Map<String, dynamic> json) {
    return PlaceMap(
        json["place_id"],
        json["name"],
        json["vicinity"],
        json["icon"],
        json["icon_background_color"],
        json["geometry"]["location"]["lat"],
        json["geometry"]["location"]["lng"]
    );
  }

  PlaceMap(String placeID, String placeName, String placeAddress, String icon, String iconBackgroundColor, double latitude, double longitude) {
    this.placeID = placeID == null ? null : placeID;
    this.placeName = placeName == null ? null : placeName;
    this.placeAddress = placeAddress == null ? null : placeAddress;
    this.icon = icon == null ? null : icon;
    this.iconBackgroundColor = iconBackgroundColor == null ? null : iconBackgroundColor;
    this.location = latitude == null || longitude == null ? null : LatLng(latitude, longitude);
  }

  static Future<Position> getUserPosition() async{

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

  static Future<List<PlaceMap>> getPlaceNearbyUser() async {
    Position userLocation = await getUserPosition();

    int radius = 500;
    var nearbyURL = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
            "location=${userLocation.latitude},${userLocation.longitude}"
            "&radius=${radius.toString()}"
            "&key=${placeAPI}"
    );
    List<PlaceMap> placesMap = [];
    final response = await http.get(nearbyURL);
    var data = json.decode(response.body);
    print(data["status"]);
    if (data["status"] == "OK") {
      List<String> placeName = [];
      for (var position in data["results"]) {
        PlaceMap place = placeMapFromJson(position);
        placeName.add(place.placeName);
        placesMap.add(place);
      }
      print("Place in ${radius} meters is : ${placeName}");
      return placesMap;
    }
  }
}