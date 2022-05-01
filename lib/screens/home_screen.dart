import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda/screens/screens.dart';
import 'package:tienda/widgets/widgets.dart';
import 'package:tienda/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    if (productsService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Model´s',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TextButton(
              onPressed: () {},
              child: const Text('¥: 100',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          /* IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ), */
        ],
      ),
      body: ListView.builder(
        itemCount: productsService.productos.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: ProductCard(
            producto: productsService.productos[index],
          ),
          onTap: () {
            productsService.selectProduct =
                productsService.productos[index].copy();
            Navigator.pushNamed(context, 'producto');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
