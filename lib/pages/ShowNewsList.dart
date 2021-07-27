import 'package:covidapp/pages_show/ShowNewsDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowNewsList extends StatefulWidget {
  final String name;
  final String profilePic;

  ShowNewsList({this.name, this.profilePic});

  @override
  _ShowNewsListState createState() =>
      _ShowNewsListState(name: name, profilePic: profilePic);
}

class _ShowNewsListState extends State<ShowNewsList> {
  final String name;
  final String profilePic;

  _ShowNewsListState({this.name, this.profilePic});

  Future<List> getNews() async {
    var url = Uri.parse("http://172.20.10.8/covid/getNews/getNew.php");
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 40),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xffF7F9FA),
        elevation: 0,
      ),
      body: FutureBuilder<List>(
        future: getNews(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }
          if (snapshot.hasData) {
            return News(
              list: snapshot.data,
              name: name,
              profilePic: profilePic,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class News extends StatelessWidget {
  final List list;
  final String name;
  final String profilePic;
  News({this.list, this.name, this.profilePic});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(27, 0, 0, 30),
            child: Text(
              'News Today',
              style: TextStyle(fontSize: 30, color: Colors.lightBlue),
            ),
          ),
          Container(
            height: 300,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list == null ? 0 : list.length,
                itemBuilder: (BuildContext context, int index) {
                  String topic = list[index]['news_topic'];
                  String content = list[index]['news_content'];
                  String id = list[index]['news_id'];
                  String picture = list[index]['news_image'];
                  return Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      child: Image.network(
                        //"http://172.20.10.8/covid/getNews/avataruser/${list[index]['news_image']}",
                        "http://172.20.10.8/epidemic/back/backend/upload/${list[index]['news_image']}",
                        fit: BoxFit.fill,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ShowNewsDetails(
                            id: id,
                            topic: topic,
                            content: content,
                            picture: picture,
                            name: name,
                            profilePic: profilePic,
                          );
                        }));
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
