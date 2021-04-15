// To parse this JSON data, do
//
//     final vehiculo = vehiculoFromJson(jsonString);

import 'dart:convert';

List<Vehiculo> vehiculoFromJson(String str) =>
    List<Vehiculo>.from(json.decode(str).map((x) => Vehiculo.fromJson(x)));

String vehiculoToJson(List<Vehiculo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vehiculo {
  Vehiculo({
    this.id,
    this.nombre,
    this.tipodispositivoId,
    this.imei,
    this.nrotelefono,
    this.operador,
    this.clienteId,
    this.placa,
    this.color,
    this.modelo,
    this.marca,
    this.activo,
    this.estado,
    this.movimiento,
    this.pago,
    this.lat,
    this.lng,
  });

  int id;
  String nombre;
  int tipodispositivoId;
  String imei;
  String nrotelefono;
  String operador;
  int clienteId;
  String placa;
  String color;
  String modelo;
  String marca;
  String activo;
  String estado;
  String movimiento;
  String pago;
  String lat;
  String lng;

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
        id: json['id'],
        nombre: json['nombre'],
        tipodispositivoId: json['tipodispositivo_id'],
        imei: json['imei'],
        nrotelefono: json['nrotelefono'],
        operador: json['operador'],
        clienteId: json['cliente_id'],
        placa: json['placa'],
        color: json['color'],
        modelo: json['modelo'],
        marca: json['marca'],
        activo: json['activo'],
        estado: json['estado'],
        movimiento: json['movimiento'],
        pago: json['pago'],
        lat: json['lat'],
        lng: json['lng'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'tipodispositivo_id': tipodispositivoId,
        'imei': imei,
        'nrotelefono': nrotelefono,
        'operador': operador,
        'cliente_id': clienteId,
        'placa': placa,
        'color': color,
        'modelo': modelo,
        'marca': marca,
        'activo': activo,
        'estado': estado,
        'movimiento': movimiento,
        'pago': pago,
        'lat': lat,
        'lng': lng,
      };
}
