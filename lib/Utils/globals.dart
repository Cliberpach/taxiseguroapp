library gpsadmin.globals;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsadmin/models/user.dart';


String token = '';
User user;
List listdevice = [];///aqui croe el lis global
bool placasok = false;

List<Marker> allMarkers = <Marker>[];
BitmapDescriptor myIcon = BitmapDescriptor.defaultMarker;
int apagado =0;
int detenido=0;
int movi=0;
bool consultado = false;
double zoom = 11.8;
GoogleMapController mapcontroller;
final CameraPosition kGooglePlex = CameraPosition(
  target: const LatLng(-8.1118, -79.0287), zoom: zoom);
double latNor=-1.0;
double lngNor=-1.0;


double latSur=1.0;
double lngSur=-100.0;



