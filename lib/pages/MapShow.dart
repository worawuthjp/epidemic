import 'dart:async';

import 'package:covidapp/constants.dart';
import 'package:covidapp/models/map/PlaceMap.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages/Map_Search.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapShow extends StatefulWidget {
  @override
  _MapShowState createState() => _MapShowState();
}

class _MapShowState extends State<MapShow> {
  Future<List> getMarker() async {
    var url = Uri.parse(
        "${hostname}/maps/getAllMark.php");
    var response = await http.get(url);
    return json.decode(response.body);
  }

  Future<Position> getUserPosition() async{

    Position userLocation;
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      userLocation = null;
    }

    print("userLocation: ${userLocation.latitude} , ${userLocation.longitude}");

    return userLocation;
  }

  Future<List> getHospitalNearbyList(Position userLocation) async{
    String type = "hospital";
    int radius = 10000;
    var url = Uri.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        "location=${userLocation.latitude},${userLocation.longitude}"
        "&radius=${radius.toString()}"
        "&type=${type}"
        "&key=${placeAPI}"
    );
    var response = await http.get(url);
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
      print("${type} in ${radius} is : ${placeName}");
    }

    return placesMap;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List>(
        future: getMarker(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }
          if (snapshot.hasData) {
            return MapsMarker(
              list: snapshot.data,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MapsMarker extends StatefulWidget {
  final List list;

  MapsMarker({this.list});

  @override
  _MapsMarkerState createState() => _MapsMarkerState();
}

class _MapsMarkerState extends State<MapsMarker> {
  Set<Marker> _marker = {};
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController province = TextEditingController();
  TextEditingController district = TextEditingController();
  bool isVisible = false;
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "ค้นหาโรงพยาบาลใกล้ตัวคุณ",
              style: GoogleFonts.kanit(color: Colors.white),
            ),
          ),
          backgroundColor: Color(0xffA2DAFF),
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.arrow_back_ios,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (BuildContext context) {
          //       return HomePageTwo();
          //     }));
          //   },
          // ),
        ),
        body: Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(13.8106463, 100.0368439), zoom: 15),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _marker,
              ),
              // Visibility(
              //     visible: isVisible,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Container(
              //           alignment: Alignment.topCenter,
              //           height: 300,
              //           width: double.infinity,
              //           color: Colors.white,
              //           child: Form(
              //               key: formKey,
              //               child: SingleChildScrollView(
              //                 child: Column(
              //                   children: [
              //                     Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Container(
              //                           alignment: FractionalOffset.bottomLeft,
              //                           padding: EdgeInsets.only(left: 15),
              //                           child: Text(
              //                             '\nจังหวัด',
              //                             style: GoogleFonts.kanit(
              //                                 fontWeight: FontWeight.bold),
              //                           ),
              //                         ),
              //                         IconButton(
              //                             onPressed: () {
              //                               setState(() {
              //                                 isVisible = !isVisible;
              //                               });
              //                             },
              //                             icon: Icon(
              //                               Icons.close,
              //                               size: 25,
              //                             ))
              //                       ],
              //                     ),
              //                     SizedBox(
              //                       height: 77,
              //                       child: Container(
              //                         padding:
              //                             EdgeInsets.fromLTRB(20, 0, 20, 0),
              //                         child: TextFormField(
              //                           controller: province,
              //                           decoration: InputDecoration(
              //                               hintText: 'กรุณาเลือกจังหวัด...',
              //                               hintStyle: GoogleFonts.kanit(
              //                                 fontSize: 15,
              //                               ),
              //                               border: OutlineInputBorder(
              //                                   borderRadius:
              //                                       BorderRadius.circular(15))),
              //                         ),
              //                       ),
              //                     ),
              //                     Container(
              //                       alignment: FractionalOffset.centerLeft,
              //                       padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
              //                       child: Text(
              //                         'อำเภอ',
              //                         style: GoogleFonts.kanit(
              //                             fontWeight: FontWeight.bold),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 77,
              //                       child: Container(
              //                         padding:
              //                             EdgeInsets.fromLTRB(20, 0, 20, 0),
              //                         child: TextFormField(
              //                           controller: district,
              //                           decoration: InputDecoration(
              //                               hintText: 'กรุณาเลือกเขต/อำเภอ...',
              //                               hintStyle: GoogleFonts.kanit(
              //                                 fontSize: 15,
              //                               ),
              //                               border: OutlineInputBorder(
              //                                   borderRadius:
              //                                       BorderRadius.circular(15))),
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 50,
              //                       width: 200,
              //                       child: ElevatedButton(
              //                           onPressed: () {
              //                             Navigator.of(context).push(
              //                                 MaterialPageRoute(builder:
              //                                     (BuildContext context) {
              //                               return MapShowSearch(
              //                                 province: province.text,
              //                                 district: district.text,
              //                               );
              //                             }));
              //                           },
              //                           style: ElevatedButton.styleFrom(
              //                               shape: RoundedRectangleBorder(
              //                                   borderRadius:
              //                                       BorderRadius.circular(12)),
              //                               primary: Color(0xffA2DAFF)),
              //                           child: Text(
              //                             "ค้นหา",
              //                             style: GoogleFonts.kanit(
              //                                 fontSize: 20,
              //                                 fontWeight: FontWeight.bold,
              //                                 color: Colors.white),
              //                             textAlign: TextAlign.center,
              //                           )),
              //                     )
              //                   ],
              //                 ),
              //               )),
              //         ),
              //       ],
              //     ))
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffA2DAFF),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          child: Icon(
            Icons.search,
          ),
        ));
  }
}
