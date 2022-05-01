import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda/screens/screens.dart';
import 'package:tienda/widgets/product_card_coleccion.dart';
//import 'package:tienda/widgets/widgets.dart';
import 'package:tienda/services/services.dart';
import 'package:tienda/models/models.dart';

class ColleccionScreen extends StatelessWidget {
  final Coleccion? coleccion;
  final String? url;
  const ColleccionScreen({Key? key, this.url, this.coleccion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int saldoInicial = 1000;
    int credits = saldoInicial;
    final productService = Provider.of<ProductsService>(context);
    final colecciones = productService.selectProduct.coleccion;
    if (productService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        title: const Text(
          'モデル',
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 240, 100, 150)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TextButton(
              onPressed: () {},
              child: Text('¥: $credits',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 240, 100, 150),
                  )),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0.0,
          childAspectRatio: 3 / 3,
        ),
        itemCount: colecciones.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: ProductCardColeccion(
            coleccion: colecciones[index],
          ),
          onTap: () {
            /* productService.selectProduct.coleccion = productService.selectProduct.coleccion[index].copy()
                    as List<Coleccion>; */
            /* if (productsService.selectProduct.disponible == false) {
              return;
            } */
            Navigator.pushNamed(context, 'productoClientes');
          },
        ),
      ),
    );
  }
}
