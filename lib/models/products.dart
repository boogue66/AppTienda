import 'dart:convert';

class Product {
  Product(
      {required this.disponible,
      required this.nombre,
      this.portada,
      required this.puntos,
      this.id});

  bool disponible;
  String nombre;
  String? portada;
  int puntos;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        disponible: json["disponible"],
        nombre: json["nombre"],
        portada: json["portada"],
        puntos: json["puntos"],
      );

  Map<String, dynamic> toMap() => {
        "disponible": disponible,
        "nombre": nombre,
        "portada": portada,
        "puntos": puntos,
      };

  Product copy() => Product(
        disponible: disponible,
        nombre: nombre,
        portada: portada,
        puntos: puntos,
        id: id,
      );
}
