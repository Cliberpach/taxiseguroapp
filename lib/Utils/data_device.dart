class DataDevice {
 
  int id;
  String estate;
  String certificado; //aqui su estado ( detenido,movimiento,apagado)
  String placa;
  String marca;
  String modelo;
  String color;
  String lat; //este es Lat
  String lng;  //este es la lng
  String phone;

DataDevice({this.id, this.estate, this.certificado,this.placa,this.marca,this.modelo,this.color,this.lat,this.lng});
}