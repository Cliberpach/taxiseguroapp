
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:gpsadmin/models/client.dart';
import 'package:gpsadmin/models/user.dart';
import 'package:gpsadmin/viewmodels/client_view_model.dart';
import 'package:http/http.dart' as http;
import '../Utils/globals.dart' as globals;
import 'package:provider/provider.dart';

class Apis{

Future<String> login(String _email,String _password,BuildContext context) async {
    var token;
    String tokenfinal;    
    var response = await http.post(
        'http://www.gpsaseguro.com/api/v1/auth/login?email=$_email&password=$_password');

    if (response.statusCode != 200) {   
      return tokenfinal;
    }else{
      token=jsonDecode(response.body);
     String tokenfinal=token["access_token"];
       return tokenfinal;
    }    
  }
  Future<bool> lectura(String token,BuildContext context) async {
   var prueba;   
       
         var response = await http.get('http://www.gpsaseguro.com/api/v1/auth/user',
              headers: {                
                'Authorization':'Bearer $token'
              }
              );

              if(response.statusCode!=200){
                print("ENTRO");
                return false;
               }else{
                 print("ENTROvalido");
               prueba=jsonDecode(response.body);
               print(prueba["name"]);            
              Provider.of<ClientViewModel>(context, listen: false)
              .setclient(Cliente.fromJson(jsonDecode(response.body)));

                return true;
             
                 
              }  
  }





  

  
  

}


Future<bool> getUser(String token, BuildContext context) async {
    bool result = false;
    var response = await http.get('http://www.gpsaseguro.com/api/v1/auth/user',
        headers: {'Authorization': 'Bearer $token'});
    var datos = json.decode(utf8.decode(response.bodyBytes));

    if (datos != null) {
      print(datos);
      globals.user = new User(
          id: datos["id"],
          uuid: datos["uuid"],
          nombre: datos["name"],
          email: datos["email"]);
          
    }

    return result;
  }