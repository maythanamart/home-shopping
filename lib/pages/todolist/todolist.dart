import 'package:basicflutter/pages/todolist/add.dart';
import 'package:basicflutter/pages/todolist/update.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List Page"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getData();
                });
              },
              icon: const Icon(
                Icons.refresh_outlined,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddPage()))
                .then((value) {
              setState(() {
                if (value == 'add') {
                  const snackbar =
                      SnackBar(content: Text('Create Successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
                getData();
              });
            });
          },
          child: const Icon(Icons.add)),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                //var data = json.decode(snapshot.data.toString());
                var data = snapshot.data;
                print(">>>>> $data");
                return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return MyBox2(int.parse(data[index]['id'].toString()),
                          data[index]['title'], data[index]['detail']);
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

  Widget MyBox2(int id, String title, String detail) {
    return Card(
      child: ListTile(
        title: Text("Title $title"),
        onTap: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdatePage(id, title, detail)))
              .then((value) {
            setState(() {
              if (value == 'edit') {
                const snackbar = SnackBar(content: Text('Edit Successfully'));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              } else if (value == 'delete') {
                const snackbar = SnackBar(content: Text('Delete Successfully'));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
              getData();
            });
          });
        },
      ),
    );
  }

  Future getData() async {
    var url = Uri.http('192.168.1.164:8000', '/api/all-todolist/');
    var response = await http.get(url);
    var result = json.decode(utf8.decode(response.bodyBytes));
    return result;
  }
}
