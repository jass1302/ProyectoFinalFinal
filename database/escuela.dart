import 'package:flutter/material.dart';
import 'package:proyectofinal/main.dart' as m;
import 'package:proyectofinal/vistas/aspirante.dart';

List<Escuela> escuelas = [

];

class Escuela {
  int id;
  final String nombre;
  final String clave;
  final String subnivel_id;
  final String municipio;
  
  Escuela({this.id,this.nombre,this.clave,this.subnivel_id,this.municipio});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'clave': clave,
      'subnivel_id': subnivel_id,
      'municipio': municipio
    };
  }
  @override
  String toString() {
    return 'User{id: $id, nombre: $nombre, clave: $clave,subnivel_id: $subnivel_id,municipio: $municipio}';
  }


}