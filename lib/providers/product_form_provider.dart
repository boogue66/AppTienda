// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tienda/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Product producto;
  ProductFormProvider(this.producto);

  updateDisponibilidad(bool value) {
    print(value);
    producto.disponible = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(producto.nombre);
    print(producto.puntos);
    print(producto.disponible);

    return formkey.currentState?.validate() ?? false;
  }
}
