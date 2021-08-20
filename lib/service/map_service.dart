import 'package:covidapp/constants.dart';
import 'package:covidapp/models/Nearby.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService {
  
  GoogleMapController mapController;

  Future<Position> getCurrentPosition() async{
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  List<Marker> getMarkerToMap (List<Nearby> placeList, [BitmapDescriptor iconMarker]){
    var markers = List<Marker>();

    BitmapDescriptor icon;
    if(iconMarker != null) {
      icon = iconMarker;
    }
    else{
      icon = BitmapDescriptor.defaultMarker;
    }

    placeList.forEach((place) {
      Marker marker = Marker(
          markerId: MarkerId(place.name),
          draggable: false,
          icon: icon,
          position: LatLng(place.geometry.location.lat, place.geometry.location.lng),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.vicinity
          )
      );

      markers.add(marker);
    });

    return markers;
  }

  String getImageNetworkFromMap(String photoReference, int width){
    return "https://maps.googleapis.com/maps/api/place/photo"
        "?photo_reference=${photoReference}"
        "&maxwidth=${width}"
        "&key=${placeAPI}";
  }

  void onMapCreated(GoogleMapController controller){
    mapController = controller;
  }
  
  void movedCameraToSelectPlace(LatLng latLng, String placeName) {
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 18
          )
        )
    );
    mapController.showMarkerInfoWindow(MarkerId(placeName));
  }
  
}