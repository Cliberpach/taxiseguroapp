class User{
  int id;
  String uuid;
  String nombre;
  String email;

  User({this.id, this.uuid, this.nombre, this.email});

  //static fromJson(Map<String, dynamic> json) => User(accessToken: json['access_token']);
}