import 'package:covidapp/pages/Sign_In_Page.dart';
import 'package:covidapp/pages/Sign_Up_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      backgroundColor: Color(0xffBEE5FF),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/covid.png'),
            Container(
              alignment: FractionalOffset.centerLeft,
              child: SizedBox(
                width: 230,
                height: 70,
                child: Card(
                  color: Color(0xffA2DAFF),
                  child: Text(
                    'Welcome',
                    style: GoogleFonts.kanit(
                      fontSize: 45,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              alignment: FractionalOffset.centerLeft,
              child: SizedBox(
                width: 335,
                height: 50,
                child: Card(
                  color: Color(0xffF4F4F4),
                  child: Text(
                    'Epidemic Management',
                    style: GoogleFonts.kanit(
                      fontSize: 30,
                      color: Color(0xff33A9EF),
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            SizedBox(height: 120),
            SizedBox(
              width: 304,
              height: 60,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xffA2DAFF),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return SignInPage();
                    }),
                  );
                },
                child: Text(
                  'Sign In',
                  style: GoogleFonts.kanit(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 304,
              height: 60,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return SignUpPage();
                    }),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.kanit(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffA2DAFF)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
