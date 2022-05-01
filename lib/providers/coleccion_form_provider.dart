// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tienda/models/models.dart';

class ColeccionFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Coleccion coleccion;
  ColeccionFormProvider(this.coleccion);

  updateDisponibilidad(bool value) {
    print(value);
    notifyListeners();
  }

  bool isValidForm() {
    print(coleccion.nombre);
    print(coleccion.portada);

    return formkey.currentState?.validate() ?? false;
  }
}
