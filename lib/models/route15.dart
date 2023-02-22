// To parse this JSON data, do
//
//     final model15 = model15FromJson(jsonString);

import 'dart:convert';

List<Model15> model15FromJson(String str) =>
    List<Model15>.from(json.decode(str).map((x) => Model15.fromJson(x)));

String model15ToJson(List<Model15> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model15 {
  Model15({
    this.placa,
    this.imei,
    this.estado,
    this.lat,
    this.intensidadSenal,
    this.lng,
    this.fecha,
    this.altitud,
    this.velocidad,
    this.nivelCombustible,
    this.volumenCombustible,
    this.horaDelMotor,
    this.direccion,
    this.odometro,
  });

  String placa;
  String imei;
  String estado;
  String lat;
  String intensidadSenal;
  String lng;
  DateTime fecha;
  String altitud;
  String velocidad;
  String nivelCombustible;
  String volumenCombustible;
  String horaDelMotor;
  dynamic direccion;
  String odometro;

  factory Model15.fromJson(Map<String, dynamic> json) => Model15(
        placa: json["placa"],
        imei: json["imei"],
        estado: json["estado"],
        lat: json["lat"],
        intensidadSenal: json["intensidadSenal"],
        lng: json["lng"],
        fecha: DateTime.parse(json["fecha"]),
        altitud: json["altitud"],
        velocidad: json["velocidad"],
        nivelCombustible: json["nivelCombustible"],
        volumenCombustible: json["volumenCombustible"],
        horaDelMotor: json["horaDelMotor"],
        direccion: json["direccion"],
        odometro: json["odometro"],
      );

  Map<String, dynamic> toJson() => {
        "placa": placa,
        "imei": imei,
        "estado": estado,
        "lat": lat,
        "intensidadSenal": intensidadSenal,
        "lng": lng,
        "fecha": fecha.toIso8601String(),
        "altitud": altitud,
        "velocidad": velocidad,
        "nivelCombustible": nivelCombustible,
        "volumenCombustible": volumenCombustible,
        "horaDelMotor": horaDelMotor,
        "direccion": direccion,
        "odometro": odometro,
      };
}
