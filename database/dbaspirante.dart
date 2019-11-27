import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:proyectofinal/database/db.dart';

final Database  = crearDB();

class Aspirante { // En esta clase creamos la estructura de datos del Usuario
  int id;
  final String nombre;
  final int edad;
  final int genero;
  final String email;
  final String phone;
  final String escuela;
  final String op1;
  final String op2;
  final String op3;
  final DateTime fecha;

  Aspirante({this.id,this.nombre,this.edad,this.genero,this.email,this.phone,this.escuela,this.op1,this.op2,this.op3,this.fecha});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre' : nombre,
      'edad': edad,
      'genero' : genero,
      'email' : email,
      'phone': phone,
      'escuela': escuela,
      'op1':op1,
      'op2':op2,
      'op3':op3,
      'fecha':fecha
    };
  }
  @override
  String toString() {
    return 'Aspirante{id: $id,nombre: $nombre,edad: $edad, genero: $genero,email: $email, phone: $phone,escuela: $escuela, op1: $op1, op2: $op2, op3: $op3, fecha: $fecha}';
  }
}

Future<void> deleteAspirante(int id) async {
  // Get a reference to the database.
  final db = await crearDB();

  // Se remueve el ususario de la base de datos
  await db.delete(
    'aspirante',
    // Se busca mediante ID el usuario de entrada para eliminarlo en la base de datos
    where: "id = ?",
    // Prevenimos inyeccion SQL
    whereArgs: [id],
  );
}

Future<void> updateAspirante(Aspirante asp) async {
  // Get a reference to the database.
  final db = await crearDB();

  // Actualizamos el usuario obtenido.
  await db.update(
    'aspirante',
    asp.toMap(),
    // Nos aseguramos que el usuario de entrada coincida con uno en la base de datos por medio del ID
    where: "id = ?",
    // Se utiliza whereArgs para prevenir una inyecion SQL
    whereArgs: [asp.id],
  );
}

Future<void> insertAspirante(Aspirante asp) async {  // Creamos nuestra funcion para insertar en la tabla
  final db = await crearaspirante();
  List<Map<String, dynamic>> maps = await db.query('aspirante');
  asp.id= maps.length+1;
  // Insertamos el usuario en la tabla correcta.
  // Se usa 'ConflictAlgorithm' por si se inserta el mismo muchas veces
  // asi se reemplaza con el anterior

  // print(db.rawQuery("Select username FROM users WHERE username='$user.username'"));
  await db.insert(
    'aspirante',
    asp.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  
}
Future<List<Aspirante>> aspirantes() async {
  // Get a reference to the database.
  final db = await crearDB();

  // Consultamos la tabla Usuarios en la base de datos
  final List<Map<String, dynamic>> maps = await db.query('aspirante');
  print(maps.length);
  // Convertimos el List<Map<String, dynamic> a una List<User>.
  return List.generate(maps.length, (i) {
    return Aspirante(
      id: maps[i]['id'],
      nombre: maps[i]['nombre'],
      edad: maps[i]['edad'],
      genero: maps[i]['sexo'],
      email: maps[i]['email'],
      phone: maps[i]['phone'],
      escuela: maps[i]['escuela'],
      op1: maps[i]['op1'],
      op2: maps[i]['op2'],
      op3: maps[i]['op3'],
      fecha: maps[i]['fecha']
    );
  });
}