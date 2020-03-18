class Cliente {
  final int id;
  final String name;
 final String email;

  Cliente({this.id, this.name,this.email});

  static fromJson(Map<dynamic, dynamic> json) {
    return Cliente(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
