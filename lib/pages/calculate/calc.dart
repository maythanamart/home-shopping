import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController result = TextEditingController();

  @override
  void initState() {
    super.initState();
    result.text =
        "ซื้อ Apple จำนวน x ผล ราคาผลละ 10 บาท รวมลูกค้าต้องจ่ายทั้งหมด x บาท";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculate Page")),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/cat-cute.png',
                    width: 500,
                    height: 300,
                  ),
                  const Text(
                    "โปรแกรมคำนวณ",
                    style: TextStyle(fontSize: 30),
                  ),
                  TextField(
                    controller: price,
                    decoration: const InputDecoration(
                        labelText: "ราคาสินค้า", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: quantity,
                    decoration: const InputDecoration(
                        labelText: "จำนวนสินค้าที่ต้องการ",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var cal = double.parse(quantity.text) *
                          double.parse(price.text);
                      //print("Apple quantity: ${quantity.text} Total: $cal Bath");
                      setState(() {
                        result.text =
                            "ซื้อ Apple จำนวน ${quantity.text} ผล ราคาผลละ 10 บาท รวมลูกค้าต้องจ่ายทั้งหมด $cal บาท";
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.pink.shade200),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(50, 20, 50, 20)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 30))),
                    child: const Text("คำนวณ"),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    result.text,
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
