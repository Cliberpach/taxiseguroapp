class User{
  final String id;
  final String accessToken;

  User({this.id, this.accessToken});

  static fromJson(Map<String, dynamic> json) => User(accessToken: json['access_token']);
}