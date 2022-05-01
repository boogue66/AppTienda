import 'dart:convert';

class Product {
  Product(
      {required this.disponible,
      required this.nombre,
      this.portada,
      required this.puntos,
      this.id,
      required this.coleccion});

  bool disponible;
  String nombre;
  String? portada;
  int puntos;
  String? id;
  List<Coleccion> coleccion;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        disponible: json["disponible"],
        nombre: json["nombre"],
        portada: json["portada"],
        puntos: json["puntos"],
        coleccion: List<Coleccion>.from(
            json["coleccion"].map((x) => Coleccion.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "disponible": disponible,
        "nombre": nombre,
        "portada": portada,
        "puntos": puntos,
        "coleccion": List<dynamic>.from(coleccion.map((x) => x.toMap())),
      };

  Product copy() => Product(
        disponible: disponible,
        nombre: nombre,
        portada: portada,
        puntos: puntos,
        coleccion: coleccion,
        id: id,
      );
}

class Coleccion {
  Coleccion({
    required this.id,
    required this.nombre,
    required this.portada,
  });

  int id;
  String nombre;
  String portada;

  factory Coleccion.fromJson(String str) => Coleccion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Coleccion.fromMap(Map<String, dynamic> json) => Coleccion(
        id: json["id"],
        nombre: json["nombre"],
        portada: json["portada"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "portada": portada,
      };

  Coleccion copy() => Coleccion(
        id: id,
        nombre: nombre,
        portada: portada,
      );
}
