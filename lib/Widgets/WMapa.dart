import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'WDrawer.dart';

const mapStyle=[
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#523735"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#c9b2a6"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#dcd2be"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#ae9e90"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#93817c"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a5b076"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#447530"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#fdfcf8"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f8c967"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#e9bc62"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e98d58"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#db8555"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#806b63"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8f7d77"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#b9d3c2"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#92998d"
      }
    ]
  }
]
];
class HomeMapa extends StatefulWidget {
  @override
   _HomeMapaState createState() => _HomeMapaState();
}

class _HomeMapaState extends State<HomeMapa> {
    final CameraPosition _kGooglePlex = CameraPosition(target: LatLng(-8.1118,-79.0287), zoom: 13);
    BitmapDescriptor myIcon;
    
List<Marker> allMarkers=[];

initState() {

    super.initState();
       
          BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(150, 150)),'assets/images/estacion.png')
                .then((onValue){
                myIcon=onValue;
              });
          
  
    allMarkers.add(Marker(
      markerId: MarkerId('PTOA'),
      infoWindow: InfoWindow(
                title: 'T5T-125',
                snippet: "ASEGURO",
              ),
      draggable: true,
      onTap: (){  print('PTO_A');  },
      position: LatLng(-8.11157592,-79.02796108),
      icon: myIcon,
      ///aqui debe ir la poscicion del una unidad
      
    ));
    allMarkers.add(Marker(
      markerId: MarkerId('PTO_B'),
      infoWindow: InfoWindow(
                title: 'T7Y-898',
                snippet: "ASEGURO",
              ),
      draggable: true,
      
      onTap: (){ print('PTOB');
      },
      position: LatLng(-8.11118125,-79.02844102),///aqui debe ir la poscicion del una unidad
    ));
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de vehiculos"),),
      drawer: MenuLateral(),

        body:Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              GoogleMap(
                //aqui ponemos arreglos en el mapa
                mapType: MapType.normal,////aqui se arreglan los tipos de mapas
                initialCameraPosition: _kGooglePlex,
                myLocationButtonEnabled:true,/// se oculta el boton de mi ubicacion
                markers: Set.from(allMarkers),
                onMapCreated: (GoogleMapController controller){controller.setMapStyle(jsonEncode(mapStyle));},
                
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
                    contentPadding: EdgeInsets.only(left: 15.0,top: 15.0),
                    
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