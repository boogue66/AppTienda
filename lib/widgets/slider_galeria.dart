import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda/models/models.dart';
import 'package:tienda/services/services.dart';

class ColeccionSlider extends StatelessWidget {
  final Coleccion? coleccion;
  final String? url;
  const ColeccionSlider({Key? key, this.url, this.coleccion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        margin: const EdgeInsets.only(top: 0, bottom: 10),
        width: double.infinity,
        height: 400,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              child: Text('Galeria',
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: productService.selectProduct.coleccion.length,
                itemBuilder: (BuildContext context, int index) {
                  return _ColeccionPortada(indexProduct: index);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 3 / 3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ColeccionPortada extends StatelessWidget {
  const _ColeccionPortada({Key? key, required this.indexProduct})
      : super(key: key);
  final int indexProduct;

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'galeriaClientes',
                arguments: 'coleccion'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/no-image.png'),
                image: NetworkImage(productService
                    .selectProduct.coleccion[indexProduct].portada),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            productService.selectProduct.coleccion[indexProduct].nombre,
            maxLines: 2,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
