library gpsadmin.globals;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsadmin/models/user.dart';


String token = "";
User user = null;
List listdevice = new List();///aqui croe el lis global
bool placas_ok = false;

List<Marker> allMarkers = new List<Marker>();
BitmapDescriptor myIcon = BitmapDescriptor.defaultMarker;
int apagado =0;
int detenido=0;
int movi=0;
bool consultado = false;
double zoom = 11.8;
GoogleMapController map_controller;
final CameraPosition kGooglePlex = CameraPosition(target: LatLng(-8.1118, -79.0287), zoom: zoom);
double latNor=-100;
double lngNor=1;
double latSur=1;
double lngSur=1;



