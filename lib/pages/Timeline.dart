
import 'package:covidapp/models/TimelineModel.dart';
import 'package:covidapp/models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class TimelinePage extends StatefulWidget {

  final User user;

  const TimelinePage({Key key,@required this.user}) : super(key: key);

  @override
  _TimelinePageState createState() => _TimelinePageState(user: user);
}

class _TimelinePageState extends State<TimelinePage> {

  _TimelinePageState({this.user});

  User user;
  DateTime selectDate;
  Timeline timeline;

  @override
  void initState() {
    super.initState();
    //first select Today
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    selectDate = DateTime.now();
  }

  String formatDate(DateTime dateSelect){
    return DateFormat('yyyy-MM-dd').format(dateSelect);
  }

  Future<List<PlaceTimeline>> _getAllTimeline() async{
    String date = formatDate(selectDate);
    print("userID : " + user.userID);
    print("Start Selected Date : " + date);
    var urlTimeline = Uri.parse("${hostname}/timeline/getTimeline.php?userID=${user.userID}&searchDate=${date}");
    // http.get(urlTimeline).then((response) {
    //   if(mounted) {
    //     timeline = timelineFromJson(response.body);
    //   }
    //   setState(() {});
    //   if (timeline.message == "success") {
    //     places = timeline.places;
    //   }
    //
    //   print("Length of Place : " + timeline.places.length.toString());
    //   for (var place in timeline.places) {
    //     print("PlaceName of Places : " + place.placeName);
    //   }
    // });
    // var response = await http.get(urlTimeline);
    var response = await http.get(urlTimeline);
    Timeline timeline = timelineFromJson(response.body);
    List<PlaceTimeline> places = [];
    if(timeline.message == "success"){
      places = timeline.places;
      print("Length of Place : ${places}");
      for (var place in places) {
        print("PlaceName of Places : " + place.placeName);
      }
    }
    return places;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.lightBlue[300],
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(16),
            color: Color(0xFFF5F5F5),
            child: Column (
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                ListTile(
                    title: Text(
                      user.username,
                      style: GoogleFonts.kanit(
                          fontSize: 25,
                          //fontWeight: FontWeight.w600,
                          color: Colors.lightBlue[300]),
                    ),
                    subtitle: Text(
                      "Time Line",
                      style: GoogleFonts.kanit(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightBlue),
                    ),
                    trailing: Container(
                      width: 60,
                      height: 60,
                      child: (user.picture == null || user.picture == "") ?
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ) :
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "${hostname}/signup/avataruser/${user.picture}"),
                        backgroundColor: Colors.transparent,
                      ),
                    )
                ),

                GestureDetector(
                  onTap: (){
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2001),
                        maxTime: DateTime.now(),
                        onChanged: (date) {
                          print('Change Date : $date');
                        },
                        theme: DatePickerTheme(
                          itemStyle: GoogleFonts.kanit(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),
                          doneStyle: GoogleFonts.kanit(
                              fontSize: 18
                          ),
                          cancelStyle: GoogleFonts.kanit(
                              fontSize: 18,
                              color: Colors.grey
                          ),
                        ),
                        onConfirm: (date) {
                          print('Confirm Date : $date');
                          setState(() {
                            selectDate = date;
                          });
                          print('Select Date : $selectDate');
                        }, currentTime: selectDate, locale: LocaleType.th
                    );
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text(
                              DateFormat.yMMMMd().format(selectDate),
                              style: GoogleFonts.kanit(
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                            ),
                          ),

                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                                size: 25,
                              )
                          ),

                        ],
                      )
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 16 , top: 32 , right: 16),
                    color: Colors.white,
                    child: FutureBuilder(
                      future: _getAllTimeline(),
                      builder: (context , snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator(),);
                        }
                        else {
                          if(snapshot.hasError){
                            return Center(
                              child: Text(
                                "Some error is occurred",
                                style: GoogleFonts.kanit(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24
                                )
                              ),
                            );
                          }
                          else if (snapshot.data.length == 0) {
                            return Center(
                              child: Text(
                                "???????????????????????????????????????????????????????????????",
                                style: GoogleFonts.kanit(
                                    color: Colors.grey,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            );
                          }
                          else {
                            List<PlaceTimeline> placeTimelineList = snapshot.data;
                            return ListView.builder(
                                itemCount: placeTimelineList.length,
                                itemBuilder: (context, index) {
                                  PlaceTimeline placeTimeline = placeTimelineList[index];
                                  return Container(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              child: Text(
                                                timeLineFormat(placeTimeline),
                                                style: GoogleFonts.kanit(
                                                    color: Colors.blueGrey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              snapshot.data[index].placeName,
                                              style: GoogleFonts.kanit(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  );
                                });
                          }

                        }

                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  verifyTime(int time ) {
    String correctTime = "";
    if(time < 10)
      correctTime = "0" + time.toString();
    else
      correctTime = time.toString();
    return correctTime;
  }

  String timeLineFormat(PlaceTimeline place) {
    String timeIn = verifyTime(place.checkIn.hour) + ":" + verifyTime(place.checkIn.minute);
    String timeOut = place.checkOut != null ? verifyTime(place.checkOut.hour) + ":" + verifyTime(place.checkOut.minute) : null;
    String time = timeOut != null ? timeIn + " - " + timeOut : timeIn;
    return time;
  }

}

