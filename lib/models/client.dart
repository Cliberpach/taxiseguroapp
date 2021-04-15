class Cliente {
  final int id;
  final String name;
 final String email;

  // ignore: sort_constructors_first
  Cliente({this.id, this.name,this.email});

  static Cliente fromJson(Map<dynamic, dynamic> json) {
    return Cliente(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
