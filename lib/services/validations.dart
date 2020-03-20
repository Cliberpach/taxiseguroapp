import 'package:flutter/material.dart';


validateName(String value){
  if(value.isEmpty){
    return 'Nombre no puede estar vacío';
  }}

validateEmail(String value) {
  if (value.isEmpty) {
    return 'El campo Email no puede estar vacío!';
  }
  // Regex para validación de email
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);
  if (regExp.hasMatch(value)) {
    return null;
  }
  return 'El Email suministrado no es válido. Intente otro correo electrónico';
}

validatePassword(String value){
  if(value.isEmpty){
    return 'El campo Contraseña no puede estar vacío';
  }
  // Use cualquier tamaño de contraseña que usted quiera aquí
  if(value.length<6){
    return 'El tamaño de la contraseña debe ser más de 6 carácteres';
  }
}