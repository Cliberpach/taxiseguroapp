class User{
  int id;
  String uuid;
  String nombre;
  String email;

  // ignore: sort_constructors_first
  User({this.id, this.uuid, this.nombre, this.email});

  //static fromJson(Map<String, dynamic> json) 
  //=> User(accessToken: json['access_token']);
}