import 'package:basicflutter/pages/calculate/calc.dart';
import 'package:basicflutter/pages/setting/setting.dart';
import 'package:basicflutter/pages/home/home.dart';
import 'package:basicflutter/pages/todolist/todolist.dart';
import 'package:flutter/material.dart';

class MyAppPage extends StatefulWidget {
  const MyAppPage({Key? key}) : super(key: key);

  @override
  State<MyAppPage> createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  int _currentIndex = 0;
  final tabs = [
    const HomePage(),
    const CalculatePage(),
    const TodoListPage(),
    const SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Hello MyApp")),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: "Calculate"),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: "To Do"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting")
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
