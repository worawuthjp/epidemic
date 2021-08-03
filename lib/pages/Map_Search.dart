import 'dart:typed_data';

import 'package:covidapp/constants.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapShowSearch extends StatefulWidget {
  final String province;
  final String district;

  MapShowSearch({this.province, this.district});

  @override
  _MapShowSearchState createState() =>
      _MapShowSearchState(province: province, district: district);
}

class _MapShowSearchState extends State<MapShowSearch> {
  final String province;
  final String district;

  _MapShowSearchState({this.province, this.district});

  Future<List> getMarker() async {
    var url = Uri.parse(
        "${hostname}/maps/getMarkFromSearch.php?province=$province&district=$district");
    var response = await http.get(url);
    return json.decode(response.body);
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

  void _onMapCreated(GoogleMapController controller) {
    for (int i = _marker.length; i < widget.list.length; i++) {
      String markerID = widget.list[i]['hospital_id'];
      String latString = widget.list[i]['latitude'];
      double lat = double.parse(latString);
      String lngString = widget.list[i]['longitude'];
      double lng = double.parse(lngString);
      String name = widget.list[i]['hospital_name'];
      setState(() {
        _marker.add(Marker(
            markerId: MarkerId(markerID),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: name, snippet: "-เนื้อหาข้อมูล-")));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String latString = widget.list[0]['latitude'];
    double lat = double.parse(latString);
    String lngString = widget.list[0]['longitude'];
    double lng = double.parse(lngString);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "ค้นหาโรงพยาบาลใกล้ตัวคุณ",
            style: GoogleFonts.kanit(color: Colors.white),
          ),
          backgroundColor: Color(0xffA2DAFF),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return HomePageTwo();
              }));
            },
          ),
        ),
        body: Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: LatLng(lat, lng), zoom: 15),
                onMapCreated: _onMapCreated,
                markers: _marker,
              ),
              Visibility(
                  visible: isVisible,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        height: 300,
                        width: double.infinity,
                        color: Colors.white,
                        child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: FractionalOffset.bottomLeft,
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          '\nจังหวัด',
                                          style: GoogleFonts.kanit(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isVisible = !isVisible;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            size: 25,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 77,
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: TextFormField(
                                        controller: province,
                                        decoration: InputDecoration(
                                            hintText: 'กรุณาเลือกจังหวัด...',
                                            hintStyle: GoogleFonts.kanit(
                                              fontSize: 15,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: FractionalOffset.centerLeft,
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                                    child: Text(
                                      'อำเภอ',
                                      style: GoogleFonts.kanit(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 77,
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: TextFormField(
                                        controller: district,
                                        decoration: InputDecoration(
                                            hintText: 'กรุณาเลือกเขต/อำเภอ...',
                                            hintStyle: GoogleFonts.kanit(
                                              fontSize: 15,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return MapShowSearch(
                                              province: province.text,
                                              district: district.text,
                                            );
                                          }));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            primary: Color(0xffA2DAFF)),
                                        child: Text(
                                          "ค้นหา",
                                          style: GoogleFonts.kanit(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        )),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  ))
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
