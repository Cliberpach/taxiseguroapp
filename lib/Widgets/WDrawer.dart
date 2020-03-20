import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/globals.dart' as globals;

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///aqui yermina

    return Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(
              globals.user.nombre,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              globals.user.email,
              style: TextStyle(color: Colors.black),
            ),
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
                children: [
                  Text(globals.apagado.toString() + "   " + 'Apagado'),
                  Icon(Icons.drive_eta)
                ]),
            //al final de la imagen se debe mostrar el total de vehiculos que tine este usuario
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(globals.movi.toString() + "   " + 'En Movimiento'),
                  Icon(Icons.directions_run)
                ]),
            //se bede mostrar la cantidad de unnidades que estan en movimiento
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(globals.detenido.toString() + "   " + 'Detenido'),
                  Icon(Icons.stop)
                ]),
            ////se bede mostrar la cantidad de unnidades que estan detenidos
          ),
          Divider(),
          ListTile(
            title: Text("Mapa de Flota"),
            onTap: () {
              print("entroooooooooooooooo");
              //String fixed4 = d.toStringAsFixed(4); // 1.5900
              String fixedlatNor = globals.latNor.toStringAsFixed(6); // 1.590000
              String fixedlngNor = globals.lngNor.toStringAsFixed(6); // 1.590000
              String fixedlatSur = globals.latSur.toStringAsFixed(6); // 1.590000
              String fixedlngSur = globals.lngSur.toStringAsFixed(6); // 1.590000
              globals.latNor=double.parse(fixedlatNor);
              globals.lngNor=double.parse(fixedlngNor);
              globals.latSur=double.parse(fixedlatSur);
              globals.lngSur=double.parse(fixedlngSur);
                print('final');
              print(globals.latNor);
              print(globals.lngNor);
              print(globals.latSur);
              print(globals.lngSur);
                print('final');
              globals.map_controller.animateCamera(CameraUpdate.newLatLngBounds(
                LatLngBounds(
                  southwest: LatLng(-8.129606, -79.032827),
                  northeast: LatLng(-7.725112, -79.306912),
                ),
                10.0,
              ));
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text("WhatsApp"),
            onTap: () {
              whatsAppOpen();

              ///felimente ya esta :)
            },
          ),
          Divider(),
          ListTile(
            title: Text("Salir"),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}

void whatsAppOpen() async {
  var whatsappUrl =
      "whatsapp://send?phone=+51957281730&text=Escriba mensaje para el administrador";
  await canLaunch(whatsappUrl)
      ? launch(whatsappUrl)
      : print("no tiene whatsapp instalado");
}
