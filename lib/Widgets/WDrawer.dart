
import 'package:gpsadmin/models/client.dart';

import 'package:gpsadmin/viewmodels/client_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class MenuLateral extends StatelessWidget {
    @override
  Widget build(BuildContext context) {     
    final cliente =Provider.of<ClientViewModel>(context).client;
      print("${cliente.name}");
    ///aqui yermina

    return Drawer(        
      child: ListView(        
        children: <Widget>[
        new UserAccountsDrawerHeader(
          
            accountName: Text("${cliente.name}",style: TextStyle(color: Colors.black),),
            accountEmail:Text("${cliente.email}",style: TextStyle(color: Colors.black),),
            decoration: BoxDecoration(
               
                image: DecorationImage(
                    image: new AssetImage("assets/images/ico.png")
                    //fit: BoxFit.cover,

                    )),
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Total de Vehiculos'), Icon(Icons.computer)]),
            //al final de la imagen se debe mostrar el total de vehiculos que tine este usuario
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('En Movimiento'), Icon(Icons.business)]),
            //se bede mostrar la cantidad de unnidades que estan en movimiento
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Detenido'), Icon(Icons.local_taxi)]),
            ////se bede mostrar la cantidad de unnidades que estan detenidos
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Sin Conexion'), Icon(Icons.local_parking)]),
            //se bede mostrar la cantidad de unnidades que estan sin conexion
          ),
          Divider(),
          ListTile(
            title: Text("Mapa de Flota"),
            onTap: () {
              //se bede mostraren el mapa todos los vehiculos del cliente en el ,mapa y modificar el zoom para q se muestren todos
            },
          ),
          ListTile(
            title: Text("Mapa de Unidad"),
            onTap: () {
              //indicar en el buscador que ingrese la placa y lo ubique en el mapa y le de el zoom
            },
          ),
          Divider(),
          ListTile(
            title: Text("Wassap"),
            onTap: () {
              //whatsAppOpen();///felimente ya esta :)
            },
          ),
          ListTile(
            title: Text("Salir"),
            leading: Icon(Icons.exit_to_app),
            onTap: () {},
          ),
          
        ],
        
      ),
      
    );
  }
}
