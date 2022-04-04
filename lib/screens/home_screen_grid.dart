import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda/models/models.dart';
import 'package:tienda/screens/screens.dart';
import 'package:tienda/widgets/widgets.dart';
import 'package:tienda/services/services.dart';

class HomeScreenGrid extends StatelessWidget {
  const HomeScreenGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    if (productsService.isLoading) return const LoadinScreen();

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
              child: const Text('¥: 10000',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 240, 100, 150),
                  )),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 300,
            mainAxisSpacing: 0,
            childAspectRatio: 3 / 2),
        itemCount: productsService.productos.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: ProductCard(
            producto: productsService.productos[index],
          ),
          onTap: () {
            productsService.selectProduct =
                productsService.productos[index].copy();
            /* if (productsService.selectProduct.disponible == false) {
              return;
            } */
            Navigator.pushNamed(context, 'producto');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 240, 100, 150),
        child: const Icon(Icons.add),
        onPressed: () {
          productsService.selectProduct =
              Product(disponible: false, nombre: '', puntos: 50);
          Navigator.pushNamed(context, 'producto');
        },
      ),
    );
  }
}
