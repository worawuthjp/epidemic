import 'package:covidapp/constants.dart';
import 'package:covidapp/pages/Home_page_two.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowNewsDetails extends StatelessWidget {
  final String id;
  final String topic;
  final String content;
  final String picture;
  final String name;
  final String profilePic;

  ShowNewsDetails(
      {this.id,
      this.topic,
      this.content,
      this.picture,
      this.name,
      this.profilePic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[200],
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 30),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    child: RichText(
                      text: TextSpan(
                          text: "$name\n",
                          style: GoogleFonts.kanit(
                              fontSize: 25,
                              //fontWeight: FontWeight.w400,
                              color: Colors.lightBlue[300]),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'News Today',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.lightBlue))
                          ]),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(right: 30),
                    child: CircleAvatar(
                      radius: 27,
                      backgroundImage: NetworkImage(
                          "${hostname}/signup/avataruser/$profilePic"),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  height: 450,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    margin: EdgeInsets.all(20),
                    child: Image.network(
                      "http://172.20.10.8/epidemic/back/backend/upload/$picture",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffA2DAFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePageTwo()));
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_location,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.history,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
