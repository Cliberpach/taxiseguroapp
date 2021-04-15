import 'package:gpsadmin/Widgets/WMapa.dart';
import 'package:gpsadmin/bloc/loginbloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: true);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/fondo.png'),
                      fit: BoxFit.cover)),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: size.width / 3.2,
                        child: const Image(
                          //width: 250,
                          image: AssetImage('assets/images/icono.png'),
                        ),
                        decoration:
                            const BoxDecoration(shape: BoxShape.circle)),
                    const SizedBox(height: 20),
                    const Text('AseguroPeru',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 50),
                    Card(
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: Column(
                          children: [
                            TextField(
                              controller: bloc.email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.black,
                                  ),
                                  hintText: 'E-Mail'),
                            ),
                            const SizedBox(height: 30),
                            TextField(
                              controller: bloc.password,
                              obscureText: !bloc.visible,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  prefixIcon: const Icon(
                                    Icons.vpn_key_outlined,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        bloc.visible = !bloc.visible;
                                      },
                                      child: Icon(bloc.visible == true
                                          ? MdiIcons.eye
                                          : MdiIcons.eyeOff)),
                                  hintText: 'Contraseña'),
                            ),
                            const SizedBox(height: 30),
                            Consumer<LoginBloc>(
                                builder: (context, bloclogin, widget) {
                              return SizedBox(
                                width: size.width,
                                height: 50,
                                child: ElevatedButton(
                                    child: bloc.loading
                                        ? const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white))
                                        : const Text('INGRESAR'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.orangeAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    onPressed: () async {
                                      var result = await bloc.login();
                                      switch (result) {
                                        case Statuslogin.success:
                                          return Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeMapa()));
                                          break;
                                        case Statuslogin.error:
                                          return showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Error'),
                                              content: const Text(
                                                  'Usuario o contraseña incorrecta'),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          primary:
                                                              Colors.redAccent),
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                          break;
                                        default:
                                      }
                                    }),
                              );
                            })
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              whatsAppOpen();
            },
            backgroundColor: Colors.green,
            child: const Icon(
              MdiIcons.whatsapp,
              color: Colors.white,
            )));
  }
}

void whatsAppOpen() async {
  var whatsappUrl =
      'whatsapp://send?phone=+51957281730&text=Escriba mensaje para el administrador';
  await canLaunch(whatsappUrl)
      ? launch(whatsappUrl)
      : print('no tiene whatsapp instalado');
}
