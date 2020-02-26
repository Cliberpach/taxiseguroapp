class Client {
  final String id;
  final String nombre;
 final String email;

  Client({this.id, this.nombre,this.email});

  static fromJson(dynamic json) {
    return Client(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
    );
  }
}
