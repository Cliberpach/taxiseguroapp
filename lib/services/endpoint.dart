
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gpsadmin/models/client.dart';
import 'package:gpsadmin/models/user.dart';
import 'package:gpsadmin/viewmodels/auth_view_model.dart';
import 'package:gpsadmin/viewmodels/client_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class Apis{

Future<String> login(String _email,String _password,BuildContext context) async {
    var token;
    String tokenfinal;
    //final User user  = Provider.of<AuthViewModel>(context).user;   
    var response = await http.post(
        'http://www.gpsaseguro.com/api/v1/auth/login?email=$_email&password=$_password');

    if (response.statusCode != 200) {
     // mensaje = 'Usuario o contrasena incorrecto';
      /*setState(() {
        
      });*/
      return tokenfinal;
    }else{
      token=jsonDecode(response.body);
     String tokenfinal=token["access_token"];
      //print(response.body.toString());
      //_lectura();
       //Provider.of<AuthViewModel>(context,listen: false)
       // .setUser(User.fromJson(jsonDecode(response.body)));
   /* User user=User.fromJson(token);
        print(user.accessToken);*/
    /*setState(() {
       ///estaba penssando ponerlo akiya q cuando se reinicia ya tinene el token para el header
       
    });*/
     return tokenfinal;
    //Navigator.pushReplacementNamed(context, '/VHome');
    }
   // mensaje = '';

   
  }
  Future<bool> lectura(String token,BuildContext context) async {
   var prueba;
   //var token="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjJiOGQyMzFlZWQ5YzVmYzFhZWNlMTIyMDEyMzEzMWEzMTJlYzMxY2ZhMTQ1YWM3Y2VjMjFhZWMyMWVlYWE3Y2IzMjc4MjQ0NmRkZjNlYTZkIn0.eyJhdWQiOiIxIiwianRpIjoiMmI4ZDIzMWVlZDljNWZjMWFlY2UxMjIwMTIzMTMxYTMxMmVjMzFjZmExNDVhYzdjZWMyMWFlYzIxZWVhYTdjYjMyNzgyNDQ2ZGRmM2VhNmQiLCJpYXQiOjE1ODMxNzc5OTYsIm5iZiI6MTU4MzE3Nzk5NiwiZXhwIjoxNjE0NzEzOTk2LCJzdWIiOiIzNyIsInNjb3BlcyI6W119.vyLCfnfeP4lXfAkbbjBlEiFc5BvJhhZBvr3WOPVOxbZAp2Rexr6Z5i1KSjZnFgao8Ao77RE72HJhzLJCNCOK2hlmNN5lvIngUQiom1VTtnK_zz9FiLpcbqziVeqs4hkB91LPAweIYoO7_DX9AFanvCDvm1eqtTH-wXQZRfj2hw3H7B100xVlNXd6lAeJfGdmNB8au2qUbxhSsbYnLeCQcTgSRlebUauvgfoGiupnL6ex52s7cSZGi8VIosCPkETwoI03Kn9zNt8ghtdNTEM2UAiOxTkPP3nTMnwsmb3EAmU1lGXvg_qQgXO2unqAUg_zT1em-C5L3tzRtUa78yCU5CC1vaYtKhJVumljd0w_xk7vk1pe_2U6yrVgLwj9ZsrO_GPuTv29X78b-ujoemAg9GY3Z4QjjYKlUyMqBWRNjPT2Su0N88r8ZyUJ3DUnCD9oE1ONoYjrhuHlduvJk4Y6hHSsDpqNWCN4ha3CRVy9r0wDXWZjTnfDr9dRGI4ZN1Pu2N8Xur8xZjKfxL8ylFX4DCpAgceTcP6GkthHa0ndNtS-a0jLEqokkqyNDpf4iFzNFt6WaOHaWI9Y6T2TvzQDzXPsjS17FczPKadlPGWfsQ34H06da9dc8z9cTpEvv3QFw3XcCAUHJ-gLjPpCy16c3w1D-cdN-_A4-pZN3sSfUL0";
         //final User user = Provider.of<AuthViewModel>(context).user; 
         var response = await http.get('http://www.gpsaseguro.com/api/v1/auth/user',
              headers: {                
                'Authorization':'Bearer $token'
              }
              );

              if(response.statusCode!=200){
                print("ENTRO");
                return false;
               }else{
                 print("ENTRO3333");
               prueba=jsonDecode(response.body);
          print(prueba["name"]);
               Cliente cliente=Cliente.fromJson(prueba);
            print(cliente.id.toString());
            //
            //    
              /* Provider.of<ClientViewModel>(context, listen: false)
              .setclient(Cliente.fromJson(jsonDecode(response.body)));*/

                return true;
             
                 
              }
     
              
            }

}