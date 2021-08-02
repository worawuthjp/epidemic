import 'dart:convert';

CheckIn checkInFromJson(String str) =>
    CheckIn.fromJson(json.decode(str));

class CheckIn {
    String message;
    int statusCode;
    bool isCheckout;
    String placeID;
    String placeName;
    DateTime timeCheckIn;

    factory CheckIn.fromJson(Map<String, dynamic> json) {
      return CheckIn(
          json["msg"],
          json["statusCode"],
          json["isCheckout"],
          json["placeID"],
          json["placeName"],
          json["time_checkin"]);
    }

    CheckIn(String message, int statusCode, bool isCheckout, String placeID, String placeName, String timeCheckIn) {
      this.message = message == null ? null : message;
      this.statusCode = statusCode == null ? null : statusCode;
      this.isCheckout = isCheckout == null ? null : isCheckout;
      this.placeID = placeID == null ? null : placeID;
      this.placeName = placeName == null ? null : placeName;
      this.timeCheckIn = timeCheckIn == null ? null : DateTime.parse(timeCheckIn);
    }
}