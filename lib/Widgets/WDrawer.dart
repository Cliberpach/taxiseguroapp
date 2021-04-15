import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gpsadmin/bloc/loginbloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture:Container(
              child: Image.asset('assets/images/fotoini.png'),
            ) ,
            accountName: Text(
              bloc.usuario.nombre,
              style: const TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              bloc.usuario.correoElectronico,
              style: const TextStyle(color: Colors.black),
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/fondo.png'),
                  fit: BoxFit.cover,
                )),
          ),
           ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const Expanded(child: Text('Total')),
                 Text(bloc.totalve.toString()),
                 const SizedBox(width: 20),
                  const Icon(MdiIcons.carMultiple)
                ]),
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const Expanded(child: Text('Apagado')),
                 Text(bloc.apagado.toString()),
                 const SizedBox(width: 20),
                  const Icon(MdiIcons.power)
                ]),
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Expanded(child:Text( 'En Movimiento')),
                   Text(bloc.enmovimiento.toString()),
                 const SizedBox(width: 20),
                  const Icon(MdiIcons.carArrowRight)
                ]),
            //se bede mostrar la cantidad de unnidades que estan en movimiento
          ),
          ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Expanded(child:Text('Detenido')),
                    Text(bloc.detenido.toString()),
                      const SizedBox(width: 20),
                  const Icon(MdiIcons.alertOctagonOutline)
                ]),
            ////se bede mostrar la cantidad de unnidades que estan detenidos
          ),
          const Divider(),
          ListTile(
            title: const Text('WhatsApp'),
            onTap: () {
              whatsAppOpen();

              ///felimente ya esta :)
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Salir'),
            leading: const Icon(Icons.exit_to_app),
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
      'whatsapp://send?phone=+51957281730&text=Escriba mensaje para el administrador';
  await canLaunch(whatsappUrl)
      ? launch(whatsappUrl)
      : print('no tiene whatsapp instalado');
}
