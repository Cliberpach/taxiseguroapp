
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpsadmin/Widgets/WMapa.dart';


// Esto es un widget sin estado, quiere decir que no puedes actualizar la vista. generalmente los StatelessWidget se usan en widgets reutilizables tipo plantilla.

class Vistacarros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   

    //MaterialApp solo se usa una vez en el main.drt    
     
    return Scaffold(
         body: Form(
           
        child:HomeMapa(),)

    );
  }

}


