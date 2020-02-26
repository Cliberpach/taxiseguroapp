class Vehiculo {
  final String id;
  final String placa;

  Vehiculo({this.id, this.placa});

  static fromJson(dynamic json) {
    return Vehiculo(
      id: json['id'],
      placa: json['placa'],
    );
  }
}
