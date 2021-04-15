import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VSplash extends StatefulWidget {
  VSplash({Key key}) : super(key: key);

  @override
  _VSplashState createState() => _VSplashState();
}

class _VSplashState extends State<VSplash> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    getvalidatesession();
  }

  Future<void> getvalidatesession() async {
    // ignore: omit_local_variable_types
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // ignore: omit_local_variable_types
    bool loginactive = sharedPreferences.getBool('loginactive') ?? false;
    Future.delayed(const Duration(seconds: 2), () {
      if (loginactive == true) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('VHome', (Route<dynamic> route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('VLogin', ModalRoute.withName('myapp'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            height: 150,
            width: 150,
            child: Image.asset('assets/images/icono.png'),
          ),
        ),
      )),
    );
  }
}
