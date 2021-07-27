// To parse this JSON data, do
//
//     final todayStatus = todayStatusFromJson(jsonString);

import 'dart:convert';

TodayStatus todayStatusFromJson(String str) =>
    TodayStatus.fromJson(json.decode(str));

String todayStatusToJson(TodayStatus data) => json.encode(data.toJson());

class TodayStatus {
  TodayStatus({
    this.confirmed,
    this.recovered,
    this.hospitalized,
    this.deaths,
    this.newConfirmed,
    this.newRecovered,
    this.newHospitalized,
    this.newDeaths,
    this.updateDate,
    this.devBy,
  });

  int confirmed;
  int recovered;
  int hospitalized;
  int deaths;
  int newConfirmed;
  int newRecovered;
  int newHospitalized;
  int newDeaths;
  String updateDate;
  String devBy;

  factory TodayStatus.fromJson(Map<String, dynamic> json) => TodayStatus(
        confirmed: json["Confirmed"] == null ? null : json["Confirmed"],
        recovered: json["Recovered"] == null ? null : json["Recovered"],
        hospitalized:
            json["Hospitalized"] == null ? null : json["Hospitalized"],
        deaths: json["Deaths"] == null ? null : json["Deaths"],
        newConfirmed:
            json["NewConfirmed"] == null ? null : json["NewConfirmed"],
        newRecovered:
            json["NewRecovered"] == null ? null : json["NewRecovered"],
        newHospitalized:
            json["NewHospitalized"] == null ? null : json["NewHospitalized"],
        newDeaths: json["NewDeaths"] == null ? null : json["NewDeaths"],
        updateDate: json["UpdateDate"] == null ? null : json["UpdateDate"],
        devBy: json["DevBy"] == null ? null : json["DevBy"],
      );

  Map<String, dynamic> toJson() => {
        "Confirmed": confirmed == null ? null : confirmed,
        "Recovered": recovered == null ? null : recovered,
        "Hospitalized": hospitalized == null ? null : hospitalized,
        "Deaths": deaths == null ? null : deaths,
        "NewConfirmed": newConfirmed == null ? null : newConfirmed,
        "NewRecovered": newRecovered == null ? null : newRecovered,
        "NewHospitalized": newHospitalized == null ? null : newHospitalized,
        "NewDeaths": newDeaths == null ? null : newDeaths,
        "UpdateDate": updateDate == null ? null : updateDate,
        "DevBy": devBy == null ? null : devBy,
      };
}
