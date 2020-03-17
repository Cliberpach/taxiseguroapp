class Vehiculo {
  String id;
  String estate; //aqui su estado ( detenido,movimiento,apagado)
  String placa;
  String marca;
  String modelo;
  String color;
  String lat; //este es Lat
  String lng; //este es la lng
  String phone;
  Vehiculo(
      {this.id,
      this.estate,
      this.placa,
      this.marca,
      this.modelo,
      this.color,
      this.lat,
      this.lng,
      this.phone});
/*
  factory Vehiculo.fromJson(Map<String, dynamic> json) {
    return new Vehiculo(
      id: json['id'],
      estate: json['operador_gsm'],
      placa: json['placa'],
      marca: json['marca'],
      modelo: json['modelo'],
      color: json['color'],
      lat: json['serial_motor'],
      lng: json['numero_serie'],
      phone: json['phone'],
    );
  }
  */
}
