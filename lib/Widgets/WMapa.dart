import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsadmin/services/positiondevice.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'WDrawer.dart';

import '../Utils/globals.dart' as globals;

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

class _HomeMapaState extends State<HomeMapa> {
  Set<Marker> markers;

  @override
  void initState() {
    markers = Set.from([]);
    setState(() {
      globals.zoom = 11.8;
    });
  }

  createMarker(_context) {
    ImageConfiguration configuration = createLocalImageConfiguration(_context);
    BitmapDescriptor.fromAssetImage(
            configuration, "assets/images/markerico.png")
        .then((icon) {
      setState(() {
        globals.myIcon = icon;
        //print(icon);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (globals.consultado == false) {
      globals.consultado = true;
      createMarker(context);
      listDevice(globals.token, globals.user.id, context)
          .then((value) => initState());

      Timer.periodic(Duration(seconds: 15), (_) {
        listDevice(globals.token, globals.user.id, context)
            .then((value) => initState());
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de vehiculos"),
      ),
      drawer: MenuLateral(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: false,
              //aqui ponemos arreglos en el mapa
              mapType: MapType.normal, ////aqui se arreglan los tipos de mapas
              initialCameraPosition: globals.kGooglePlex,

              myLocationButtonEnabled: true,

              /// se oculta el boton de mi ubicacion
              markers: Set.from(globals.allMarkers),
              onMapCreated: (GoogleMapController controller) {
                globals.map_controller = controller;

                controller.setMapStyle(jsonEncode(mapStyle));
              },
            ),
            ////////////////// CAROUSEL
            globals.listdevice.length > 0
                ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: CarouselSlider(
                        enlargeCenterPage: false,
                        autoPlay: true,
                        pauseAutoPlayOnTouch: Duration(seconds: 3),
                        viewportFraction: 0.4,
                        initialPage: 1,
                        items: globals.listdevice.map((dispositivo) {
                          return Builder(builder: (BuildContext context) {
                            return GestureDetector(
                                onTap: () {
                                  print(dispositivo.lat);
                                  //aqui el zomm tonces
                                  setState(() {
                                    globals.map_controller.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: LatLng(
                                            double.parse(dispositivo.lat),
                                            double.parse(dispositivo.lng),
                                          ),
                                          zoom: 18,
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(10.0),
                                  width: 200,
                                  height: 40,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          "assets/images/placa.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Text(
                                    dispositivo.placa,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 23.0, color: Colors.black),
                                  ),
                                ));
                          });
                        }).toList(),
                      ),
                    ),
                  )
                : Offstage(),
            Positioned(
              left: MediaQuery.of(context).size.width - 100,
              top: MediaQuery.of(context).size.height - 250,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      globals.map_controller.animateCamera(
                        CameraUpdate.zoomIn(),
                      );
                    });
                  },
                  icon: Icon(Icons.zoom_in, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width - 100,
              top: MediaQuery.of(context).size.height - 200,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      globals.map_controller.animateCamera(
                        CameraUpdate.zoomOut(),
                      );
                    });
                  },
                  icon: Icon(Icons.zoom_out, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
