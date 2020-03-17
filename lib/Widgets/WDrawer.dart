import 'package:gpsadmin/viewmodels/client_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../Utils/globals.dart' as globals;

class MenuLateral extends StatelessWidget {
    @override
  Widget build(BuildContext context) {     
    
    ///aqui yermina

    return Drawer(        
      child: ListView(        
        children: <Widget>[
        new UserAccountsDrawerHeader(
          
            accountName: Text(globals.user.nombre,style: TextStyle(color: Colors.black),),
            accountEmail:Text(globals.user.email,style: TextStyle(color: Colors.black),),
            decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 image: DecorationImage(
                    image: new AssetImage("assets/images/fotoini.png"),
                    fit: BoxFit.fill,

                    )),
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('APAGADO'+"   "+globals.apagado.toString()), Icon(Icons.computer)]),
            //al final de la imagen se debe mostrar el total de vehiculos que tine este usuario
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('En Movimiento'+"   "+globals.movi.toString()), Icon(Icons.business)]),
            //se bede mostrar la cantidad de unnidades que estan en movimiento
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Detenido'+"   "+globals.detenido.toString()), Icon(Icons.local_taxi)]),
            ////se bede mostrar la cantidad de unnidades que estan detenidos
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
