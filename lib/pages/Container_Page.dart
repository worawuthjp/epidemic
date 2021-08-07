import 'package:covidapp/pages/Home_Page.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:covidapp/pages/Risk_Form_Covid.dart';
import 'package:flutter/material.dart';

class ContainerPage extends StatefulWidget {
  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(children: [
          //HomePage(),
          // HomePageTwo(),
          Container(color: Colors.yellowAccent),
          Container(color: Colors.orangeAccent),
          Container(color: Colors.redAccent)
          //  RiskFormPage()
        ]),
        backgroundColor: Color(0xffA2DAFF),
        bottomNavigationBar: TabBar(
          labelColor: Color(0xffA2DAFF),
          tabs: [
            Tab(
                icon: Icon(
              Icons.home,
              color: Colors.white,
            )),
            Tab(icon: Icon(Icons.add_location, color: Colors.white)),
            Tab(icon: Icon(Icons.history, color: Colors.white)),
            Tab(icon: Icon(Icons.person, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
