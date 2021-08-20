import 'dart:convert';

import 'package:covidapp/constants.dart';
import 'package:covidapp/models/Detail.dart';
import 'package:covidapp/models/Nearby.dart';
import 'package:http/http.dart' as http;

class PlaceService {

  Future<List<Nearby>> getNearby({double lat, double lng}) async {
    double radius = 1000;
    String type = "hospital";

    var url = Uri.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        "location=${lat},${lng}"
        "&radius=$radius"
        "&type=$type"
        "&key=${placeAPI}");
    var response = await http.get(url);
    final data = jsonDecode(response.body);
    final List result = data["results"];
    final String status = data["status"];
    print(result);
    print(status);
    return result.map((e) => Nearby.fromJson(e)).toList();
  }

  Future<Detail> getDetail({String placeID}) async {
    var url = Uri.parse("https://maps.googleapis.com/maps/api/place/details/json?"
        "place_id=${placeID}"
        "&key=${placeAPI}");

    var response = await http.get(url);
    final data = jsonDecode(response.body);
    print(data["result"]);
    print(data["status"]);
    Detail result = Detail.formJson(data["result"]);
    return result;
  }
}