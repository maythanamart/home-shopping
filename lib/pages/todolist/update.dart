import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class UpdatePage extends StatefulWidget {
  final dynamic id, title, detail;
  const UpdatePage(this.id, this.title, this.detail);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  dynamic _id;
  final TextEditingController _title = TextEditingController();
  final TextEditingController _detail = TextEditingController();

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    _title.text = widget.title;
    _detail.text = widget.detail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูล'),
        actions: [
          IconButton(
              onPressed: () {
                delete();
                Navigator.pop(context, 'delete');
              },
              icon: const Icon(
                Icons.delete_outline,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Text(
              "To Do List",
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                  labelText: "Title", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _detail,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                  labelText: "Detail", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                // var cal = double.parse(quantity.text) *
                //     double.parse(price.text);
                // //print("Apple quantity: ${quantity.text} Total: $cal Bath");
                // setState(() {
                //   result.text =
                //       "ซื้อ Apple จำนวน ${quantity.text} ผล ราคาผลละ 10 บาท รวมลูกค้าต้องจ่ายทั้งหมด $cal บาท";
                // });
                setState(() {
                  update();
                  Navigator.pop(context, 'edit');
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink.shade200),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(50, 20, 50, 20)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 30))),
              child: const Text("Update"),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Future update() async {
    var url = Uri.http('192.168.1.164:8000', '/api/update-todolist/$_id');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsonData = '{"title":"${_title.text}","detail":"${_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsonData);
  }

  Future delete() async {
    var url = Uri.http('192.168.1.164:8000', '/api/delete-todolist/$_id');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
  }
}
