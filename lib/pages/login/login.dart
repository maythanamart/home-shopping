import 'package:basicflutter/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var username = TextEditingController();
  var password = TextEditingController();
  var result = '--- Result ---';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3)),
                  child: ClipOval(
                      child: SizedBox.fromSize(
                          size: const Size.fromRadius(48),
                          child: Image.asset(
                            'assets/icon/store-icon.png',
                            width: 100,
                            height: 100,
                          ))),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: username,
                  decoration: const InputDecoration(hintText: 'Username'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (username.text == 'admin' &&
                            password.text == '1234') {
                          result = "success";
                          setUsername(username.text);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
                        } else {
                          result = "fail";
                        }
                      });
                    },
                    child: const Text("Login")),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text("View Username")),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  result,
                  style: const TextStyle(color: Colors.green, fontSize: 25),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> setUsername(textUsername) async {
    print(textUsername);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', textUsername);
  }
}
