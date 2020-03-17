import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsadmin/services/positiondevice.dart';
import 'package:provider/provider.dart';
import 'WDrawer.dart';
import 'package:http/http.dart' as http;
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

double _zoom = 11.5;

class _HomeMapaState extends State<HomeMapa> {
  final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(-8.1118, -79.0287), zoom: _zoom);

  Set<Marker> markers;

  @override
  void initState() {
    markers = Set.from([]);
    setState(() {
      _zoom = 10;
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

          Timer.periodic(Duration(seconds: 15), (_){
            print("tick");
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
              //aqui ponemos arreglos en el mapa
              mapType: MapType.normal, ////aqui se arreglan los tipos de mapas
              initialCameraPosition: _kGooglePlex,
              myLocationButtonEnabled: true,

              /// se oculta el boton de mi ubicacion
              markers: Set.from(globals.allMarkers),
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(jsonEncode(mapStyle));
              },
            ),
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
                      _zoom++;
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
                      _zoom--;
                    });
                  },
                  icon: Icon(Icons.zoom_out, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 2.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Busqueda la PLACA - ejemp T5T-123',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
