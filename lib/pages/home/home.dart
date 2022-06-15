import 'package:basicflutter/pages/todolist/detail.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                //var data = json.decode(snapshot.data.toString());
                var data = snapshot.data;
                return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return MyBox(
                          data[index]['title'],
                          data[index]['subtitle'],
                          data[index]['image_url'],
                          data[index]['detail']);
                    },
                    itemCount: data.length);
              } else {
                return Container();
              }
            },
            // future:
            //     DefaultAssetBundle.of(context).loadString('assets/data.json'),
            future: getData(),
          )),
    );
  }

  Widget MyBox(String title, String subtitle, String imageURL, String detail) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: 125,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(imageURL),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.30), BlendMode.darken))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(title, subtitle, imageURL, detail)));
                  },
                  child: const Text("ซื้อเลย...",
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ]),
    );
  }

  Future getData() async {
    var url = Uri.https(
        'raw.githubusercontent.com', '/maythanamart/basic-api/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
