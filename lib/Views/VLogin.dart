import 'package:gpsadmin/Widgets/WMapa.dart';
import 'package:gpsadmin/services/endpoint.dart';
import 'package:flutter/material.dart';
import '../services/endpoint.dart' as endpoint;
import '../Utils/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String mensaje = '';
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/digital.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            //aqui le icono de gps asguro
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.only(top: 77.0),
                  child: new CircleAvatar(
                    backgroundColor: Color(0xF81F7F3),
                    child: new Image(
                      width: 250,
                      height: 250,
                      image: new AssetImage("assets/images/fotoini.png"),
                    ),
                  ),
                  width: 170.0,
                  height: 170.0,
                  decoration: BoxDecoration(shape: BoxShape.circle)),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 73),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.only(
                        top: 4,
                        left: 16,
                        right: 16,
                        bottom: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5),
                        ],
                      ),
                      child: TextField(
                        onChanged: (String inputValue) {
                          _email = inputValue;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            hintText: 'E-Mail'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.only(
                        top: 4,
                        left: 16,
                        right: 16,
                        bottom: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5),
                        ],
                      ),
                      child: TextField(
                        onChanged: (String inputValue) {
                          setState(() {
                            _password = inputValue;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            hintText: 'Password'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 6,
                          right: 32,
                        ),
                        child: Text(
                          'RECORDAR PASSWORD',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    new RaisedButton(
                        child: new Text("INGRESAR"),
                        color: Colors.orangeAccent,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0)),
                        onPressed: () async {
                          await Apis()
                              .login(_email, _password, context)
                              .then((_token) {                                
                            if (_token != null) {                              
                              globals.token = _token;
                              getUser(_token, context).then((value) =>
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeMapa())));
                            }
                          });
                          //if (token != null) {
                          //bool ingreso = await Apis().lectura(token, context);
                          //if (ingreso == true) {
                          //final listvehiculo= listDevice(token,40, context);
                          // print("${listvehiculo.toString()}");

                          //globals.tokenS = token;
                          //globals.clienteId = Provider.of<ClientViewModel>(context).client.id;
                          //Navigator.pushReplacementNamed(context, '/VHome');

                          //}
                          //} else {}
                        }),
                    Text(
                      mensaje,
                      style: TextStyle(fontSize: 25.0, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
