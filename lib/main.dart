import 'package:basicflutter/pages/login/login.dart';
import 'package:basicflutter/pages/myapp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Shopping App",
        home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _body = const CircularProgressIndicator();
  String? text = '';
  @override
  void initState() {
    super.initState();
    getUsername().then((value) {
      if (text == null) {
        setState(() => _body = const LoginPage());
      } else {
        setState(() => _body = const MyAppPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  Future<void> getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      text = pref.getString('username');
    });
  }
}
