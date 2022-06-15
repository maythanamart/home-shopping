import 'package:basicflutter/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Setting Page")),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (_, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    removeUsername().then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    });
                  },
                  onLongPress: () {},
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                ),
              );
            }));
  }

  Future<void> removeUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('username');
  }
}
