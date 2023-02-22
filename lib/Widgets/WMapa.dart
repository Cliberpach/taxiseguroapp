import 'dart:convert';

import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsadmin/Widgets/Wnotification.dart';
import 'package:gpsadmin/Widgets/report_car.dart';
import 'package:gpsadmin/bloc/loginbloc.dart';
import 'package:gpsadmin/models/vehiculo.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'WDrawer.dart';

const mapStyle = [
  [
    {
      "elementType": "geometry",
      "stylers": [
        {"color": "#ebe3cd"}
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#523735"}
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {"color": "#f5f1e6"}
      ]
    },
    {
      "featureType": "administrative",
      "elementType": "geometry.stroke",
      "stylers": [
        {"color": "#c9b2a6"}
      ]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "geometry.stroke",
      "stylers": [
        {"color": "#dcd2be"}
      ]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#ae9e90"}
      ]
    },
    {
      "featureType": "landscape.natural",
      "elementType": "geometry",
      "stylers": [
        {"color": "#dfd2ae"}
      ]
    },
    {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [
        {"color": "#dfd2ae"}
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#93817c"}
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry.fill",
      "stylers": [
        {"color": "#a5b076"}
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#447530"}
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
        {"color": "#f5f1e6"}
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "geometry",
      "stylers": [
        {"color": "#fdfcf8"}
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {"color": "#f8c967"}
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry.stroke",
      "stylers": [
        {"color": "#e9bc62"}
      ]
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry",
      "stylers": [
        {"color": "#e98d58"}
      ]
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry.stroke",
      "stylers": [
        {"color": "#db8555"}
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#806b63"}
      ]
    },
    {
      "featureType": "transit.line",
      "elementType": "geometry",
      "stylers": [
        {"color": "#dfd2ae"}
      ]
    },
    {
      "featureType": "transit.line",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#8f7d77"}
      ]
    },
    {
      "featureType": "transit.line",
      "elementType": "labels.text.stroke",
      "stylers": [
        {"color": "#ebe3cd"}
      ]
    },
    {
      "featureType": "transit.station",
      "elementType": "geometry",
      "stylers": [
        {"color": "#dfd2ae"}
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry.fill",
      "stylers": [
        {"color": "#b9d3c2"}
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {"color": "#92998d"}
      ]
    }
  ]
];

class HomeMapa extends StatefulWidget {
  @override
  _HomeMapaState createState() => _HomeMapaState();
}

class _HomeMapaState extends State<HomeMapa> with WidgetsBindingObserver {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FlutterLocalNotificationsPlugin fltNotification;
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  @override
  void initState() {
    notitficationPermission();
    initMessaging();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void getToken() async {
    print(await messaging.getToken());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        setState(() {});
        print('===================================================Inactive');
        break;
      case AppLifecycleState.paused:
        setState(() {});
        print('========================Paused');
        break;
      case AppLifecycleState.resumed:
        setState(() {});
        print('=========================================Resumed');
        break;
      case AppLifecycleState.detached:
        setState(() {});
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final blocmap = Provider.of<LoginBloc>(context, listen: true);
    blocmap.mapcontroller?.setMapStyle(jsonEncode(mapStyle));
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Container(
          width: 220,
          //height: 35,
          child: BsSelectBox(
            searchable: false,
            padding: const EdgeInsets.all(8),
            hintText: blocmap.totalvehiculodrop,
            controller: blocmap.vehiculosdroplist,
            onChange: (value) async {
              blocmap.visibledi = false;
              Vehiculo vehiculo = value.getValue();
              if (vehiculo.imei == '0') {
                blocmap.moveCamera(-8.1118, -79.0287, 12.0);
                // blocmap.getroute();
                blocmap.isStopped2 = true;
                blocmap.isStopped = false;
                
                blocmap
                  ..getvehiculos()
                  ..callapi();

                print("======TODOS=============");
                blocmap.polylinelist = {};
                blocmap.moveCamera2(-8.1118, -79.0287, 12);
              } else {
                blocmap.isStopped = true;
                blocmap.isStopped2 = false;
                blocmap.placar = vehiculo.placa;
                blocmap.dispositivo = vehiculo.imei;
                blocmap.vehiculosinplaca = Vehiculo(
                    lat: vehiculo.lat,
                    lng: vehiculo.lng,
                    placa: vehiculo.placa);
                blocmap
                  ..getroute15()
                  ..callapi2();
                //blocmap.mapcontroller.setMapStyle(jsonEncode(mapStyle));
              }
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
                onTap: () {
                  blocmap.getnotification();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WNotification()));
                },
                child: const Icon(MdiIcons.bellOutline)),
          )
        ],
      ),
      drawer: MenuLateral(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            GoogleMap(
              onTap: (latlong) {
                blocmap.changuevisibledi();
              },
              polylines: blocmap.polylinelist,
              // ignore: sdk_version_set_literal
              // polylines: {
              //   Polyline(
              //     polylineId: PolylineId('1'),
              //     color: Colors.red,
              //     points: blocmap.polylinelist
              //         .map((e) => LatLng(e.latitude, e.longitude))
              //         .toList(),
              //   ),
              // },
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: false,
              mapType: blocmap.stylemap == false
                  ? MapType.normal
                  : MapType.satellite,
              compassEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: blocmap.kGooglePlex,
              myLocationButtonEnabled: true,
              markers: Set.from(blocmap.allMarkers),
              onMapCreated: (GoogleMapController controller) {
                blocmap.mapcontroller = controller;
              },
              onCameraMove: (cameramove) {
                //blocmap.changuevisibledi();
              },
              cameraTargetBounds: CameraTargetBounds(blocmap.boundmaps),
            ),
            Positioned(
                right: 20,
                bottom: 70,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        blocmap.stylemap = !blocmap.stylemap;
                        print(blocmap.stylemap);
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.layers_outlined, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        blocmap.mapcontroller
                            .animateCamera(CameraUpdate.zoomIn());
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.zoom_in, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        blocmap.mapcontroller.animateCamera(
                          CameraUpdate.zoomOut(),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.zoom_out, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Consumer<LoginBloc>(builder: (context, bloc, widget) {
                      return bloc.destinationrout.latitude == 0
                          ? Container()
                          : GestureDetector(
                              onTap: () async {
                                var estado = await bloc.locationGPS();
                                switch (estado) {
                                  case 1:
                                    return showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'La opción de GPS se encuentra desactivado'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.blueAccent),
                                            onPressed: () {
                                              bloc.statusgps =
                                                  StatusGPS.initialgps;
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
                                  case 2:
                                    return showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'El permiso de Geolocalización esta desactivado'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.blueAccent),
                                            onPressed: () {
                                              bloc.statusgps =
                                                  StatusGPS.initialgps;
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
                                  case 3:
                                    await blocmap.getposition();
                                    break;
                                  default:
                                }
                              },
                              child: const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blueAccent,
                                child: Text('Ir',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            );
                    }),
                    const SizedBox(height: 10),
                    blocmap.visibledi
                        ? GestureDetector(
                            onTap: () {
                              // blocmap.estadoreport = 0;
                              blocmap.isStopped = true;
                              blocmap.isStopped2 = true;
                              blocmap.estadoreport = 3;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PageReportCar(
                                          placa: blocmap.placar)));
                            },
                            child: const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blueAccent,
                                child: Icon(MdiIcons.chartBoxOutline,
                                    color: Colors.white)))
                        : Container(),
                    const SizedBox(height: 30),
                    blocmap.visibledi
                        ? GestureDetector(
                            onTap: () async {
                              final googleMapslocationUrl =
                                  "http://www.google.com/maps?layer=c&cbll=${blocmap.streetview.latitude},${blocmap.streetview.longitude}";
                              print(googleMapslocationUrl);
                              final encodedURl =
                                  Uri.encodeFull(googleMapslocationUrl);
                              if (await canLaunch(encodedURl)) {
                                await launch(encodedURl);
                              } else {
                                print('Could not launch $encodedURl');
                              }
                            },
                            child: const CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.orange,
                              child: Icon(MdiIcons.googleStreetView,
                                  color: Colors.white),
                            ),
                          )
                        : Container(),
                  ],
                )),
            blocmap.visibledi
                ? Positioned(
                    top: -3,
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.speed, color: Colors.blueAccent),
                            Text('Velocidad: ${blocmap.velocidad}'),
                            const SizedBox(width: 30),
                            const Icon(Icons.signal_cellular_alt,
                                color: Colors.blueAccent),
                            Text('Señal: ${blocmap.senal}%')
                          ],
                        ),
                      ),
                    ))
                : Container(),
            // const Positioned(
            //   bottom: 20,
            //   child: Wlistvehiculos(),
            // ),
            Consumer<LoginBloc>(builder: (__, bloc, widget) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 900),
                top: bloc.visibledi == false ? 0 : 70,
                child: Align(
                    alignment: Alignment.center,
                    child: bloc.visibledi == false
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              bloc.changuevisibledi();
                            },
                            child: Card(
                              elevation: 2,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                color: Colors.white,
                                //height: 100,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Placa : ${bloc.placa}'),
                                    const SizedBox(height: 10),
                                    Text('Dirección :  ${bloc.direccion}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          )),
              );
            })
          ],
        ),
      ),
    );
  }

  void initMessaging() {
    var androiInit = const AndroidInitializationSettings('app_icon');
    var initSetting = InitializationSettings(android: androiInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initSetting);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // ignore: omit_local_variable_types
      RemoteNotification notification = message.notification;
      // ignore: omit_local_variable_types
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
      //showNotification();
    });
  }

  void notitficationPermission() async {
    // ignore: omit_local_variable_types
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
