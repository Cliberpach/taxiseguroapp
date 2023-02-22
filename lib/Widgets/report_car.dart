import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsadmin/bloc/loginbloc.dart';
import 'package:provider/provider.dart';
class PageReportCar extends StatelessWidget {
  final String placa;

  // ignore: sort_constructors_first
  PageReportCar({Key key, this.placa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reload = Provider.of<LoginBloc>(context, listen: true);
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        //reload.isStopped2 = false;
        //await reload.callapi2();
        Navigator.pop(context);
      },
      child: Scaffold(
          //backgroundColor: Colors.red,
          appBar: AppBar(
            title: Text('Reporte de $placa'),
          ),
          body: Container(
              padding: const EdgeInsets.all(5),
              height: size.height,
              width: size.width,
              child:  Column(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Fecha',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Container(
                                width: 150,
                                child: BsSelectBox(
                                  hintText: 'Seleccionar',
                                  controller: reload.select1,
                                  onChange: (value) {
                                    reload.selectbox(value.getValue());
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('H. inicio',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              InkWell(
                                onTap: () async {
                                  var selectedTime =
                                      const TimeOfDay(hour: 00, minute: 00);
                                  final picked2 = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (picked2 != null) selectedTime = picked2;
                                  var hour = selectedTime.hour.toString();
                                  var minute = selectedTime.minute.toString();
                                  var initime = '$hour:$minute';
                                  print(initime);
                                  reload.horaini.text = initime;
                                },
                                child: Container(
                                  width: 60,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey[200]),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    keyboardType: TextInputType.text,
                                    controller: reload.horaini,
                                    decoration: const InputDecoration(
                                        disabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        contentPadding:
                                            EdgeInsets.only(top: 0.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('H. fin',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              InkWell(
                                onTap: () async {
                                  var selectedTime =
                                      const TimeOfDay(hour: 00, minute: 00);
                                  final picked2 = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (picked2 != null) selectedTime = picked2;
                                  var hour = selectedTime.hour.toString();
                                  var minute = selectedTime.minute.toString();
                                  var initime = '$hour:$minute';
                                  print(initime);
                                  reload.horafin.text = initime;
                                },
                                child: Container(
                                  width: 60,
                                  height: 50,
                                  //margin: const EdgeInsets.only(top: 30),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey[200]),
                                  child: TextField(
                                    //style: const TextStyle(fontSize: 40),
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    keyboardType: TextInputType.text,
                                    controller: reload.horafin,
                                    decoration: const InputDecoration(
                                        disabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        contentPadding:
                                            EdgeInsets.only(top: 0.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(''),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Theme.of(context).primaryColor),
                                    onPressed: () {
                                      
                                      reload.getreporte();
                                    
                                    },
                                    child: const Text('Generar')),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(child: Container(
                        child: Consumer<LoginBloc>
                        (builder: (context, bloc, widget) {
                      switch (bloc.estadoreport) {
                        case 0:
                          return const Center(
                              child: CircularProgressIndicator());
                          break;
                        case 1:
                          return Expanded(
                            child: GoogleMap(
                              polylines: bloc.polyline,
                              zoomGesturesEnabled: true,
                              tiltGesturesEnabled: false,
                              mapType: MapType.normal,
                              compassEnabled: true,
                              zoomControlsEnabled: false,
                              initialCameraPosition: CameraPosition(
                                  target: bloc.cameralatlong, zoom: 13),
                              myLocationButtonEnabled: true,
                              markers:bloc.markers,
                              // markers: Set.from(blocmap.allMarkers),
                              onMapCreated: (GoogleMapController controller) {
                                bloc.controller.complete(controller);
                              },
                              cameraTargetBounds:
                                  CameraTargetBounds(bloc.boundmapsreport),
                            ),
                          );
                          break;

                        case 2:
                          return Center(
                              child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: Image.asset(
                                        'assets/images/Nosearchnosearch.webp')),
                                // ignore: lines_longer_than_80_chars
                                const Text(
                                  'No se encontraron datos disponibles para generar el reporte',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ));
                          break;
                        default:
                          return Container();
                      }
                    }))),
                  ],
                
               ))),
    );
  }
}
