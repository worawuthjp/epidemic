import 'dart:convert';

Timeline timelineFromJson(String str) =>
    Timeline.fromJson(json.decode(str));

class Timeline {

  List<Place> places;
  String message;

  factory Timeline.fromJson(Map<String , dynamic> json) => Timeline(json["places"], json["msg"]);

  Timeline(List places, String message){
    this.message = message;

    List<Place> placeAll = [];

    for(var placeSelect in places) {
      Place place = Place(placeSelect["id"],
          placeSelect["lat"],
          placeSelect["long"],
          placeSelect["place_name"],
          placeSelect["date_checkin"],
          placeSelect["date_checkout"]
      );
      placeAll.add(place);
    }

    this.places = placeAll;
  }
}

class Place {
  String id;
  String latitude;
  String longtitude;
  String placeName;
  DateTime checkIn;
  DateTime checkOut;

  Place(String id, String latitude, String longtitude, String placeName, String checkIn,String checkOut) {
    this.id = id == null ? null : id;
    this.latitude = latitude == null ? null : latitude;
    this.longtitude = longtitude == null ? null : longtitude;
    this.placeName = placeName == null ? null : placeName;
    this.checkIn = checkIn == null ? null : DateTime.parse(checkIn);
    this.checkOut = checkOut == null ? null : DateTime.parse(checkOut);
  }

}

