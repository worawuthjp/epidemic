import 'dart:convert';

import 'package:covidapp/models/map/PhotoMap.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
}