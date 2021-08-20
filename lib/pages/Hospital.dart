import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:covidapp/constants.dart';
import 'package:covidapp/models/Detail.dart';
import 'package:covidapp/models/Nearby.dart';
import 'package:covidapp/service/map_service.dart';
import 'package:covidapp/service/place_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Hospital extends StatefulWidget {
  @override
  _HospitalState createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {

  final mapService = MapService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
        create: (context) => mapService.getCurrentPosition(),
      child: MapView()
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({Key key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  BitmapDescriptor iconMarker;

  @override
  void initState() {
    super.initState();
    setIconMarker();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  setIconMarker() async{
    final Uint8List imageMarker = await getBytesFromAsset('assets/images/hospital-icon.png', 100);
    iconMarker = BitmapDescriptor.fromBytes(imageMarker);
  }

  @override
  Widget build(BuildContext context) {

    final userPosition = Provider.of<Position>(context);
    final mapService = MapService();
    return Scaffold(
      body: (userPosition != null && iconMarker != null) ?
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FutureProvider(
              create: (context) => PlaceService().getNearby(lat: userPosition.latitude,lng: userPosition.longitude),
              child: Consumer<List<Nearby>>(
                builder: (_, places, __) {
                  var marker = (places != null) ? mapService.getMarkerToMap(places, iconMarker) : null;
                  return (places != null) ?
                      Stack(
                        children: [

                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: LatLng(userPosition.latitude, userPosition.longitude,),
                                zoom: 15.0
                            ),
                            myLocationEnabled: true,
                            markers: Set<Marker>.of(marker),
                            onMapCreated: mapService.onMapCreated,
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.5,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.blue, Colors.transparent],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter
                                  )
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: places.length,
                                    itemBuilder: (context, index) {
                                      Nearby place = places[index];
                                      return Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(
                                          onTap: (){
                                            mapService.movedCameraToSelectPlace(
                                                LatLng(place.geometry.location.lat, place.geometry.location.lng),
                                                place.name
                                            );
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.3,
                                            width: MediaQuery.of(context).size.height * 0.3,
                                            margin: EdgeInsets.symmetric(vertical: 32, horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.lightBlue[400].withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0, 5)
                                                  ),
                                                ]
                                            ),
                                            child: Column(
                                              children: [
                                                //Todo
                                                Container(
                                                  width: double.infinity,
                                                  height: MediaQuery.of(context).size.height * 0.2,
                                                  child: (place.photos != null) ?
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10),
                                                    ),
                                                    child: FittedBox(
                                                      child: Image.network(
                                                          mapService.getImageNetworkFromMap(
                                                              place.photos.first.photoReference,
                                                              place.photos.first.width
                                                          )
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ): Container(
                                                    width: double.infinity,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10),
                                                      )
                                                    ),
                                                    child: Icon(
                                                      Icons.local_hospital_outlined,
                                                      color: Colors.red,
                                                      size: 120,
                                                    ),
                                                  )
                                                ),

                                                Expanded(
                                                  child:Container(
                                                    margin: EdgeInsets.symmetric(vertical: 16),
                                                    child: Text(
                                                      place.name,
                                                      style: GoogleFonts.kanit(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),

                                                Expanded(
                                                  child:SingleChildScrollView(
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                                      child: Text(
                                                        place.vicinity,
                                                        style: GoogleFonts.kanit(
                                                            color: Colors.grey,
                                                            fontSize: 14
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                
                                                Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                                      child: FutureBuilder(
                                                        future: PlaceService().getDetail(placeID: place.placeId),
                                                        builder: (context, snapshot){
                                                          if (snapshot.hasData){
                                                            Detail placeDetail = snapshot.data;
                                                            return (placeDetail.formatPhoneNumber != null) ?
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [

                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    border: Border.all(color: Colors.green[900], width: 2),
                                                                    shape: BoxShape.circle
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.phone,
                                                                    color: Colors.green[900],
                                                                  ),
                                                                  padding: EdgeInsets.all(4),
                                                                ),

                                                                Padding(
                                                                  padding: EdgeInsets.only(left: 16),
                                                                  child: Text(
                                                                    placeDetail.formatPhoneNumber,
                                                                    style: GoogleFonts.kanit(
                                                                      color: Colors.green[900],
                                                                      fontSize: 16
                                                                    ),
                                                                  ),
                                                                ),

                                                              ],
                                                            ) : Center(
                                                              child: Text(
                                                                "ไม่มีเบอร์โทรติดต่อ",
                                                                style: GoogleFonts.kanit(
                                                                  color: Colors.green[900],
                                                                  fontSize: 16
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          else{
                                                            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green[900]),),);
                                                          }
                                                        }),
                                                    )
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                )
                            ),
                          )

                        ],
                      ) : Center(child: CircularProgressIndicator(),);
                },
              ),
            ),
          ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),)
    );
  }



}

