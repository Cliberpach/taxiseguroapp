import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewCourier {
  void showMyDialog(BuildContext context,LatLng posicion) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
            content:   Container(
                    height: 450,
                    width: 650,
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: GoogleMap(
                    zoomGesturesEnabled: true,
                    tiltGesturesEnabled: false,
                    mapType: MapType.normal,
                    compassEnabled: true,
                    zoomControlsEnabled: false,
                    initialCameraPosition:
                        CameraPosition(target: posicion, zoom: 17),
                    myLocationButtonEnabled: true,
                    markers: <Marker>{
                      Marker(markerId: MarkerId('1'),
                      icon: BitmapDescriptor.defaultMarker,
                      position: posicion
                      )
                    },
                    //markers: Set.from(blocmap.allMarkers),
                    // onMapCreated: (GoogleMapController controller) {
                    //   blocmap.mapcontroller = controller;
                    // },
                    onCameraMove: (cameramove) {
                      //blocmap.changuevisibledi();
                    },
                  ),
                    )
                    ),
              actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                   primary: Theme.of(context).primaryColor
                   ),
                onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text('Salir'))
              ],
            ));
  }
}
