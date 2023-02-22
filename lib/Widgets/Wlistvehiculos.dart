import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsadmin/bloc/loginbloc.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Wlistvehiculos extends StatelessWidget {
  const Wlistvehiculos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Consumer<LoginBloc>(builder: (context, blocve, widget) {
          return blocve.vehiculos.isEmpty
              ? Container()
              : CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 0.4,
                    enlargeCenterPage: false,
                  ),
                  // enlargeCenterPage: false,
                  // autoPlay: true,
                  // pauseAutoPlayOnTouch: const Duration(seconds: 3),
                  // viewportFraction: 0.4,
                  // initialPage: 1,
                  items: blocve.vehiculos.map((dispositivo) {
                    return Builder(builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          // blocve.destinationrout = LatLng(
                          //     double.parse(dispositivo.lat),
                          //     double.parse(dispositivo.lng));
                          // blocve.moveCamera(double.parse(dispositivo.lat),
                          //     double.parse(dispositivo.lng));
                        },
                        child: Card(
                            child: Container(
                          // padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            dispositivo.color.toString() ==
                                                    'BLANCO'
                                                ? 'assets/images/colorb.png'
                                                : 'assets/images/colorn.png'),
                                        fit: BoxFit.contain)),
                              ),
                              const SizedBox(height: 10),
                              Text(dispositivo.placa.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                      fontSize: 16)),
                              const SizedBox(height: 10),
                              Text(dispositivo.color),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Chip(
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    label: Text(
                                        dispositivo.estadogps.toLowerCase()),
                                    backgroundColor:
                                        dispositivo.estadogps.toString() ==
                                                'Conectado'
                                            ? Colors.greenAccent
                                            : Colors.redAccent),
                              )
                            ],
                          ),
                        )),
                      );
                    });
                  }).toList(),
                );
        }));
    // ListView.builder(
    //     controller: blocve.scrollController,
    //     scrollDirection: Axis.horizontal,
    //     itemCount: blocve.vehiculos.length,
    //     itemBuilder: (context, index) {
    //       return GestureDetector(
    //         onTap: () {
    //           blocve.moveCamera(double.parse(blocve.vehiculos[index].lat),
    //               double.parse(blocve.vehiculos[index].lng));
    //         },
    //         child: Card(
    //             child: Container(
    //           // padding: const EdgeInsets.all(20),
    //           width: MediaQuery.of(context).size.width / 2.3,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Container(
    //                 height: 35,
    //                 decoration: BoxDecoration(
    //                     image: DecorationImage(
    //                         image: AssetImage(
    //                             blocve.vehiculos[index].color.toString() ==
    //                                     'BLANCO'
    //                                 ? 'assets/images/colorb.png'
    //                                 : 'assets/images/colorn.png'),
    //                         fit: BoxFit.contain)),
    //               ),
    //               const SizedBox(height: 10),
    //               Text(blocve.vehiculos[index].placa.toString(),
    //                   style: const TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       color: Colors.blueAccent,
    //                       fontSize: 16)),
    //               const SizedBox(height: 10),
    //               Text(blocve.vehiculos[index].color),
    //               const SizedBox(height: 5),
    //               SizedBox(
    //                 width: MediaQuery.of(context).size.width,
    //                 child: Chip(
    //                     labelStyle: const TextStyle(color: Colors.white),
    //                     label: Text(
    //                         blocve.vehiculos[index].estado.toLowerCase()),
    //                     backgroundColor:
    //                         blocve.vehiculos[index].estado.toString() ==
    //                                 'Conectado'
    //                             ? Colors.greenAccent
    //                             : Colors.redAccent),
    //               )
    //             ],
    //           ),
    //         )),
    //       );
    //     }),
    // );
  }
}
