import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchEpidemicDetails extends StatelessWidget {
  final String epidemicID;
  final String epidemicTopic;
  final String epidemicContent;
  final String epidemicPic;
  final String epidemicDate;
  final String username;
  final String picture;

  SearchEpidemicDetails({
    this.epidemicID,
    this.epidemicTopic,
    this.epidemicContent,
    this.epidemicPic,
    this.epidemicDate,
    this.username,
    this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: SafeArea(
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
                              fontSize: 25,
                              //fontWeight: FontWeight.w400,
                              color: Colors.lightBlue[300]),
                          children: <TextSpan>[
                            TextSpan(
                                text: '$epidemicTopic',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.black))
                          ]),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(right: 30),
                    child: CircleAvatar(
                      radius: 27,
                      backgroundImage: NetworkImage(
                          "http://172.20.10.8/ConnectDBProject/connectApp/signup/avataruser/$picture"),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 250,
                  width: 350,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    margin: EdgeInsets.all(20),
                    child: Image.network(
                      "http://172.20.10.8/epidemic/back/backend/epidemic_upload/$epidemicPic",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: 380,
                      height: 400,
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(31)),
                    ),
                    Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          '$epidemicContent',
                          style: GoogleFonts.kanit(color: Colors.black),
                          textAlign: TextAlign.start,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
