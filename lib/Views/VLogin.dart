import 'package:gpsadmin/Widgets/WMapa.dart';
import 'package:gpsadmin/services/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/globals.dart' as globals;

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
                    width: 250.0,
                    height: 250.0,
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
                      Spacer(),
                      new RaisedButton(
                          child: new Text("INGRESAR"),
                          color: Colors.orangeAccent,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(71.0)),
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
                          }),
                      Text(
                        mensaje,
                        style: TextStyle(fontSize: 14.0, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              whatsAppOpen();
            },
            backgroundColor: Colors.green,
            child: Image.asset(
              'assets/images/whatsapp.png',
              color: Colors.white,
            )));
  }
}

//floatingActionButton: Container( height: 100.0, width: 100.0, child: FittedBox( child: FloatingActionButton(onPressed: () {}), ), ),
void whatsAppOpen() async {
  var whatsappUrl =
      "whatsapp://send?phone=+51957281730&text=Escriba mensaje para el administrador";
  await canLaunch(whatsappUrl)
      ? launch(whatsappUrl)
      : print("no tiene whatsapp instalado");
}
