import 'package:covidapp/models/UserModel.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages/Timeline.dart';
import 'package:covidapp/pages_show/Location.dart';
import 'package:covidapp/pages_show/Profile_User.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  final User user;

  const HomePage({Key key,@required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(user: user);
}

class _HomePageState extends State<HomePage> {

  _HomePageState({this.user});

  User user;
  int _currentIndex = 0;

  Widget getPage(int index) {
    switch (index) {
      case 0:
        print("Select Page : HomePageTwo");
        return HomePageTwo(user: user);
        break;
      case 1:
        print("Select Page : Location");
        return Location();
        break;
      case 2:
        print("Select Page : TimelinePage");
        return TimelinePage(user: user);
        break;
      case 3:
        print("Select Page : ProfileUser");
        return ProfileUser(
            user.fullName,
            user.picture,
            user.userID,
            user.faculty,
            user.department,
            user.tel,
            user.address,
            user.person);
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
    print("initState -> Username is : " + user.username);
  }

  //
  // final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // backgroundColor: Color(0xffA2DAFF),
              backgroundColor: Colors.blue,
              title: _currentIndex == 0 ? Text(
                'Home', style: GoogleFonts.kanit(fontSize: 16),) : Text('')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              backgroundColor: Colors.blue,
              title: _currentIndex == 1 ? Text(
                'Location', style: GoogleFonts.kanit(fontSize: 16),) : Text('')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              backgroundColor: Colors.blue,
              title: _currentIndex == 2 ? Text(
                'TimeLine', style: GoogleFonts.kanit(fontSize: 16),) : Text('')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              backgroundColor: Colors.blue,
              title: _currentIndex == 3 ? Text(
                'Profile', style: GoogleFonts.kanit(fontSize: 16),) : Text('')
          ),
        ],
      ),
    );
  }
}