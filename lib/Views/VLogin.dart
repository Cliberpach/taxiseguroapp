import 'dart:convert';
import 'package:gpsadmin/models/client.dart';
import 'package:gpsadmin/services/endpoint.dart';
import 'package:gpsadmin/viewmodels/client_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:gpsadmin/models/user.dart';
import 'package:gpsadmin/viewmodels/auth_view_model.dart';


class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String mensaje = '';
  String _email;
  String _password;

   //final User user = Provider.of<AuthViewModel>(context).user;


  /*Future _login() async {
    var response = await http.post(
        'http://www.gpsaseguro.com/api/v1/auth/login?email=$_email&password=$_password');

    if (response.statusCode != 200) {
      mensaje = 'Usuario o contrasena incorrecto';
      /*setState(() {
        
      });*/
      return;
    }else{
      print(response.body.toString());
      //_lectura();
      /* Provider.of<AuthViewModel>(context, listen: false)
        .setUser(User.fromJson(jsonDecode(response.body)));*/
    
    setState(() {
       ///estaba penssando ponerlo akiya q cuando se reinicia ya tinene el token para el header
       
    });
    
    //Navigator.pushReplacementNamed(context, '/VHome');
    }
    mensaje = '';

   
  }*/
///token de datos del cliente
/* Future lectura() async {
   var prueba;
   var token="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjJiOGQyMzFlZWQ5YzVmYzFhZWNlMTIyMDEyMzEzMWEzMTJlYzMxY2ZhMTQ1YWM3Y2VjMjFhZWMyMWVlYWE3Y2IzMjc4MjQ0NmRkZjNlYTZkIn0.eyJhdWQiOiIxIiwianRpIjoiMmI4ZDIzMWVlZDljNWZjMWFlY2UxMjIwMTIzMTMxYTMxMmVjMzFjZmExNDVhYzdjZWMyMWFlYzIxZWVhYTdjYjMyNzgyNDQ2ZGRmM2VhNmQiLCJpYXQiOjE1ODMxNzc5OTYsIm5iZiI6MTU4MzE3Nzk5NiwiZXhwIjoxNjE0NzEzOTk2LCJzdWIiOiIzNyIsInNjb3BlcyI6W119.vyLCfnfeP4lXfAkbbjBlEiFc5BvJhhZBvr3WOPVOxbZAp2Rexr6Z5i1KSjZnFgao8Ao77RE72HJhzLJCNCOK2hlmNN5lvIngUQiom1VTtnK_zz9FiLpcbqziVeqs4hkB91LPAweIYoO7_DX9AFanvCDvm1eqtTH-wXQZRfj2hw3H7B100xVlNXd6lAeJfGdmNB8au2qUbxhSsbYnLeCQcTgSRlebUauvgfoGiupnL6ex52s7cSZGi8VIosCPkETwoI03Kn9zNt8ghtdNTEM2UAiOxTkPP3nTMnwsmb3EAmU1lGXvg_qQgXO2unqAUg_zT1em-C5L3tzRtUa78yCU5CC1vaYtKhJVumljd0w_xk7vk1pe_2U6yrVgLwj9ZsrO_GPuTv29X78b-ujoemAg9GY3Z4QjjYKlUyMqBWRNjPT2Su0N88r8ZyUJ3DUnCD9oE1ONoYjrhuHlduvJk4Y6hHSsDpqNWCN4ha3CRVy9r0wDXWZjTnfDr9dRGI4ZN1Pu2N8Xur8xZjKfxL8ylFX4DCpAgceTcP6GkthHa0ndNtS-a0jLEqokkqyNDpf4iFzNFt6WaOHaWI9Y6T2TvzQDzXPsjS17FczPKadlPGWfsQ34H06da9dc8z9cTpEvv3QFw3XcCAUHJ-gLjPpCy16c3w1D-cdN-_A4-pZN3sSfUL0";
     //final User user = Provider.of<AuthViewModel>(context).user;         
         var response = await http.get('http://www.gpsaseguro.com/api/v1/auth/user',
              headers: {                
                'Authorization':'Bearer $token'
              }
              );

              if(response.statusCode!=200){
                print("ENTRO");
               }else{
                 print("ENTRO3333");
                prueba=jsonDecode(response.body);
                print(prueba["name"]); 

              /* Provider.of<ClientViewModel>(context, listen: false)
              .setclient(Client.fromJson(jsonDecode(response.body)));*/
                 
              }
     
              
            }*/


  @override
  
    Widget build(BuildContext context) {
     return  Scaffold(      
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
                      image: new AssetImage("assets/images/iconito.png"),
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
                        onPressed: ()async{
                          String token=await Apis().login(_email,_password,context);
                          if(token!=null){
                              bool ingreso=await Apis().lectura(token,context);
                              if(ingreso==true){
                               
                                  Navigator.pushReplacementNamed(context, '/VHome');
             
                                print("funciona");
                              }
                          }else{

                          }
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
