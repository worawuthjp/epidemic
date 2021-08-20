import 'package:flutter/material.dart';

class Detail {
  List<AddressComponent> addressComponents;
  String businessStatus;
  String formatAddress;
  String formatPhoneNumber;
  Geometry geometry;
  String icon;
  String name;
  OpeningHours openingHours;
  List<Photos> photos;
  String placeID;
  PlusCode plusCode;
  dynamic rating;
  String reference;
  List<Review> reviews;
  List<String> types;
  String url;
  int userRatingTotal;
  int utcOffset;
  String vicinity;
  String website;

  Detail({
    this.addressComponents,
    this.businessStatus,
    this.formatAddress,
    this.formatPhoneNumber,
    this.geometry,
    this.icon,
    this.name,
    this.openingHours,
    this.photos,
    this.placeID,
    this.plusCode,
    this.rating,
    this.reference,
    this.reviews,
    this.types,
    this.url,
    this.userRatingTotal,
    this.utcOffset,
    this.vicinity,
    this.website
  });

  Detail.formJson(Map<String, dynamic> json) {
    if (json["address_components"] != null) {
      addressComponents = List<AddressComponent>();
      json["address_components"].forEach((v){
        addressComponents.add(AddressComponent.fromJson(v));
      });
    }else{
      addressComponents = null;
    }
    businessStatus = json["business_status"] ==null ? null : json["business_status"];
    formatAddress = json["formatted_address"] == null ? null : json["formatted_address"];
    formatPhoneNumber = json["formatted_phone_number"] == null ? null : json["formatted_phone_number"];
    geometry = json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]);
    icon = json["icon"] == null ? null : json["icon"];
    name = json["name"] == null ? null : json["name"];
    openingHours = json["opening_hours"] != null ? new OpeningHours.fromJson(json["opening_hours"]) : null;
    if(json["photos"] != null) {
      photos = List<Photos>();
      json["photos"].forEach((v) {
        photos.add(Photos.fromJson(v));
      });
    }
    else{
      photos = null;
    }
    placeID = json["place_id"] == null ? null : json["place_id"];
    plusCode = json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]);
    rating = json["rating"];
    reference = json["reference"];
    if(json["reviews"] != null) {
      reviews = List<Review>();
      json["reviews"].forEach((v) {
        reviews.add(Review.fromJson(v));
      });
    }else{
      reviews = null;
    }
    if (json["types"] != null) {
      types = List<String>();
      json["types"].forEach((v) {
        types.add(v);
      });
    }else{
      types = null;
    }
    url = json["url"] == null ? null : json["url"];
    userRatingTotal = json["user_ratings_total"] == null ? null : json["user_ratings_total"];
    utcOffset = json["utc_offset"] == null ? null : json["utc_offset"];
    vicinity = json["vicinity"] == null ? null : json["vicinity"];
    website = json["website"] == null ? null : json["website"];
  }

}

class AddressComponent {
  String longName;
  String shortName;
  List<String> types;

  AddressComponent({
    this.longName,
    this.shortName,
    this.types
  });

  AddressComponent.fromJson(Map<String, dynamic> json) {
    longName = json["long_name"];
    shortName = json["short_name"];
    if(json["types"] != null){
      types = List<String>();
      json["types"].forEach((v) {
        types.add(v);
      });
    }
  }
}

class Geometry {
  Location location;
  Viewport viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
    viewport = json['viewport'] != null ? new Viewport.fromJson(json['viewport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport.toJson();
    }
    return data;
  }
}

class Location {
  dynamic lat;
  dynamic lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null ? new Location.fromJson(json['northeast']) : null;
    southwest = json['southwest'] != null ? new Location.fromJson(json['southwest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest.toJson();
    }
    return data;
  }
}

class OpeningHours {
  bool openNow;
  List<Period> periods;
  List<String> weeklyText;

  OpeningHours({this.openNow, this.periods, this.weeklyText});

  OpeningHours.fromJson(Map<String, dynamic> json){
    openNow = (json["open_now"] != null) ? json["open_now"] : null;
    if (json["periods"] != null) {
      periods = List<Period>();
      json["periods"].forEach((v){
        periods.add(Period.fromJson(v));
      });
    }
    else{
      periods = List<Period>();
    }

    if(json["weekday_text"] != null) {
      weeklyText = List<String>();
      json["weekday_text"].forEach((v){
        weeklyText.add(v);
      });
    }
    else{
      weeklyText = List<String>();
    }
  }
}

class Period {
  PeriodDate close;
  PeriodDate open;

  Period({this.close, this.open});

  Period.fromJson(Map<String, dynamic> json) {
    close = (json["close"] != null) ? PeriodDate.fromJson(json["close"]) : null;
    open = (json["open"] != null) ? PeriodDate.fromJson(json["open"]) : null;
  }
}

class PeriodDate {

  int day;
  String time;

  PeriodDate({this.day, this.time});

  PeriodDate.fromJson(Map<String, dynamic> json) {
   day = (json["day"] != null) ?  json["day"] : null;
   time = (json["time"] != null) ? json["time"] : null;
  }
}

class Photos {
  dynamic height;
  List<String> htmlAttributions;
  String photoReference;
  dynamic width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['html_attributions'] = this.htmlAttributions;
    data['photo_reference'] = this.photoReference;
    data['width'] = this.width;
    return data;
  }
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    return data;
  }
}

class Review {

  String authorName;
  String authorURL;
  String language;
  String profilePhotoURL;
  dynamic rating;
  String relativeTimeDescription;
  String text;
  dynamic time;

  Review({
    this.authorName,
    this.authorURL,
    this.language,
    this.profilePhotoURL,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.time
  });

  Review.fromJson(Map<String, dynamic> json) {
    authorName = json["Gigagrave"];
    authorURL = json["author_url"];
    language = json["en"];
    profilePhotoURL = json["profile_photo_url"];
    rating = json["rating"];
    relativeTimeDescription = json["relative_time_description"];
    text = json["text"];
    time = json["time"];
  }

}