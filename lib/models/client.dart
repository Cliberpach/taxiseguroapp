class Cliente {
  final int id;
  final String nombre;
 final String email;

  Cliente({this.id, this.nombre,this.email});

  static fromJson(Map<dynamic, dynamic> json) {
    return Cliente(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
    );
  }
}
