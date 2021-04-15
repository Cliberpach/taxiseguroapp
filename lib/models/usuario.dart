// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.id,
    this.nombre,
    this.userId,
    this.tipoDocumento,
    this.documento,
    this.nombreComercial,
    this.direccionFiscal,
    this.direccion,
    this.tipoDocumentoContacto,
    this.documentoContacto,
    this.nombreContacto,
    this.telefonoMovil,
    this.correoElectronico,
    this.whatsapp,
    this.facebook,
    this.activo,
    this.estado,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String nombre;
  int userId;
  String tipoDocumento;
  String documento;
  String nombreComercial;
  String direccionFiscal;
  String direccion;
  String tipoDocumentoContacto;
  String documentoContacto;
  dynamic nombreContacto;
  String telefonoMovil;
  String correoElectronico;
  dynamic whatsapp;
  dynamic facebook;
  String activo;
  String estado;
  DateTime createdAt;
  DateTime updatedAt;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        nombre: json['nombre'],
        userId: json['user_id'],
        tipoDocumento: json['tipo_documento'],
        documento: json['documento'],
        nombreComercial: json['nombre_comercial'],
        direccionFiscal: json['direccion_fiscal'],
        direccion: json['direccion'],
        tipoDocumentoContacto: json['tipo_documento_contacto'],
        documentoContacto: json['documento_contacto'],
        nombreContacto: json['nombre_contacto'],
        telefonoMovil: json['telefono_movil'],
        correoElectronico: json['correo_electronico'],
        whatsapp: json['whatsapp'],
        facebook: json['facebook'],
        activo: json['activo'],
        estado: json['estado'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'user_id': userId,
        'tipo_documento': tipoDocumento,
        'documento': documento,
        'nombre_comercial': nombreComercial,
        'direccion_fiscal': direccionFiscal,
        'direccion': direccion,
        'tipo_documento_contacto': tipoDocumentoContacto,
        'documento_contacto': documentoContacto,
        'nombre_contacto': nombreContacto,
        'telefono_movil': telefonoMovil,
        'correo_electronico': correoElectronico,
        'whatsapp': whatsapp,
        'facebook': facebook,
        'activo': activo,
        'estado': estado,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
