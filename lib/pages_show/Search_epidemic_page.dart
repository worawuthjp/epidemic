import 'package:covidapp/constants.dart';
import 'package:covidapp/pages/Home_page_two.dart';

import 'package:covidapp/pages_show/Search_epidemic_Details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchEpidemicPage extends StatefulWidget {
  final String username;
  final String picture;
  final String search;
  final String studentID;
  // final String gender;
  // final String address;
  // final String phone;
  // final String education;
  // final String person;

  SearchEpidemicPage({
    this.username,
    this.picture,
    this.search,
    this.studentID,
    // this.gender,
    // this.address,
    // this.phone,
    // this.education,
    // this.person
  });

  @override
  _SearchEpidemicPageState createState() => _SearchEpidemicPageState(
        username: username,
        picture: picture,
        search: search,
        studentID: studentID,
        // gender: gender,
        // address: address,
        // phone: phone,
        // education: education,
        // person: person,
      );
}

class _SearchEpidemicPageState extends State<SearchEpidemicPage> {
  final String username;
  final String picture;
  final String search;
  final String studentID;
  // final String gender;
  // final String address;
  // final String phone;
  // final String education;
  // final String person;

  _SearchEpidemicPageState({
    this.username,
    this.picture,
    this.search,
    this.studentID,
    // this.gender,
    // this.address,
    // this.phone,
    // this.education,
    // this.person
  });

  Future<List> getData() async {
    var url = Uri.parse(
        "${hostname}/getEpidemic/getEpidemicFromSearch.php?search=$search");
    var response = await http.get(url);
    return json.decode(response.body);
  }

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
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }
          if (snapshot.hasData) {
            return SearchItems(
              list: snapshot.data,
              username: username,
              picture: picture,
              studentID: studentID,
              // gender: gender,
              // address: address,
              // phone: phone,
              // education: education,
              // person: person,
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

class SearchItems extends StatelessWidget {
  final List list;
  final String username;
  final String picture;
  final String studentID;
  // final String gender;
  // final String address;
  // final String phone;
  // final String education;
  // final String person;
  SearchItems({
    this.list,
    this.username,
    this.picture,
    this.studentID,
    // this.gender,
    // this.address,
    // this.phone,
    // this.education,
    // this.person,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    child: RichText(
                      text: TextSpan(
                          text: "$username\n",
                          style: GoogleFonts.kanit(
                              fontSize: 30,
                              //fontWeight: FontWeight.w400,
                              color: Colors.lightBlue[300]),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'คลิกรูปภาพเพื่ออ่านข้อมูล',
                                style: GoogleFonts.kanit(
                                    fontSize: 20, color: Colors.black)),
                          ]),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(right: 30),
                    child: CircleAvatar(
                      radius: 27,
                      backgroundImage: NetworkImage(
                          "${hostname}/signup/avataruser/$picture"),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(right: 300),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 40,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: list == null ? 0 : list.length,
                    itemBuilder: (BuildContext context, int index) {
                      String epidemicID = list[index]['epidemic_id'];
                      String epidemicTopic = list[index]['epidemic_topic'];
                      String epidemicContent = list[index]['epidemic_content'];
                      String epidemicPic = list[index]['epidemic_image'];
                      String epidemicDate = list[index]['epidemic_date'];
                      return Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return SearchEpidemicDetails(
                                epidemicID: epidemicID,
                                epidemicTopic: epidemicTopic,
                                epidemicContent: epidemicContent,
                                epidemicPic: epidemicPic,
                                epidemicDate: epidemicDate,
                                username: username,
                                picture: picture,
                              );
                            }));
                          },
                          child: Image.network(
                            "${host_back_url}/epidemic/back/backend/epidemic_upload/${list[index]['epidemic_image']}",
                            fit: BoxFit.fill,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        margin: EdgeInsets.all(20),
                      );
                    }),
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
                Icons.location_on,
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
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => ProfilePage(name, picture, id, gender,
                //         address, phone, education, person)));
              },
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
