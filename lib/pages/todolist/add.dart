import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController title = TextEditingController();
  TextEditingController detail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Text(
              "To Do List",
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              controller: title,
              decoration: const InputDecoration(
                  labelText: "Title", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: detail,
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
                  postTodo();
                  Navigator.pop(context, 'add');
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink.shade200),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(50, 20, 50, 20)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 30))),
              child: const Text("Add"),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Future postTodo() async {
    var url = Uri.http('192.168.1.164:8000', '/api/add-todolist');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsonData = '{"title":"${title.text}","detail":"${detail.text}"}';
    var response = await http.post(url, headers: header, body: jsonData);
    // print("Result: ");
    // print(response.body);
    // var result = json.decode(response.body);
    // return result;
  }
}
