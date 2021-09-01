import 'package:covidapp/models/UserModel.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages/Timeline.dart';
import 'package:covidapp/pages_show/Location.dart';
import 'package:covidapp/pages_show/Profile_User.dart';
import 'package:covidapp/service/user_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {


  final String userID;
  final String userStatus;

  const HomePage({
    Key key,
    @required this.userID,
    @required this.userStatus }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(userID: userID, userStatus: userStatus);
}

class _HomePageState extends State<HomePage> {

  _HomePageState({this.userID, this.userStatus});

  String userID;
  String userStatus;

  int _currentIndex = 0;

  Widget getPage(int index, User user) {
    switch (index) {
      case 0:
        print("Select Page : HomePageTwo");
        return HomePageTwo(user: user);
        break;
      case 1:
        print("Select Page : CheckInPage");
        return LocationPage(user: user);
        break;
      case 2:
        print("Select Page : TimelinePage");
        return TimelinePage(user: user);
        break;
      case 3:
        print("Select Page : ProfileUser");
        return ProfileUser(user: user);
        break;
    }
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    print("initState -> Username is : " + userID);
  }

  Stream<User> getUserDetail(String userID, String status) async*{
    User user = await UserService().getUserDetail(userID, status);
    yield user;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getUserDetail(userID, userStatus),
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return Center(
                child: Text("Some error is Occurred."),
              );
            }
            User user = snapshot.data;
            return Scaffold(
              body: getPage(_currentIndex, user),
              bottomNavigationBar: BottomNavigationBar(
                onTap: onTappedBar,
                currentIndex: _currentIndex,
                backgroundColor: Colors.lightBlue[400],
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      // backgroundColor: Color(0xffA2DAFF),
                      backgroundColor: Colors.lightBlue[400],
                      title: _currentIndex == 0 ? Text(
                        'Home', style: GoogleFonts.kanit(fontSize: 16),) : Text('')
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.location_on),
                      backgroundColor: Colors.lightBlue[400],
                      title: _currentIndex == 1 ? Text(
                        'Check in', style: GoogleFonts.kanit(fontSize: 16),) : Text('')
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history),
                      backgroundColor: Colors.lightBlue[400],
                      title: _currentIndex == 2 ? Text(
                        'TimeLine', style: GoogleFonts.kanit(fontSize: 16),) : Text('')
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      backgroundColor: Colors.lightBlue[400],
                      title: _currentIndex == 3 ? Text(
                        'Profile', style: GoogleFonts.kanit(fontSize: 16),) : Text('')
                  ),
                ],
              ),
            );
        }
      });
  }
}