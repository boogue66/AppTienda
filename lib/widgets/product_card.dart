// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:tienda/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product producto;

  const ProductCard({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: const EdgeInsets.only(top: 25, bottom: 10),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackroundImage(producto.portada),
            _ProductDetaills(
              title: producto.nombre,
              subtitle: producto.puntos.toString() + ' Fotos ',
            ),
            /* Positioned(
              top: 0,
              right: 0,
              child: _ProductPrice(producto.puntos),
            ), */
            if (!producto.disponible)
              Positioned(
                child: _NoAvalible(producto.puntos),
              ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 10,
            ),
          ]);
}

class _NoAvalible extends StatelessWidget {
  final int puntos;
  const _NoAvalible(this.puntos);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Text(
                'DISPONIBLE',
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 240, 120, 160),
                    overflow: TextOverflow.clip),
              ),
              Text(
                '?? $puntos',
                style: const TextStyle(
                    fontSize: 90,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 240, 120, 160),
                    overflow: TextOverflow.clip),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* class _ProductPrice extends StatelessWidget {
  final int puntos;
  const _ProductPrice(this.puntos);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 45,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              topLeft: Radius.circular(5))),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '?? $puntos',
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 240, 100, 150)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
 */
class _ProductDetaills extends StatelessWidget {
  final String title;
  final String subtitle;
  const _ProductDetaills({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        height: 80,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 240, 120, 160)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(19), bottomRight: Radius.circular(19)),
      );
}

class _BackroundImage extends StatelessWidget {
  final String? url;
  const _BackroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        //color: Colors.amberAccent,
        child: url == null
            ? const Image(
                image: AssetImage('assets/images/no-image.png'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/images/jar-loading.gif'),
                image: NetworkImage(url!),
              ),
      ),
    );
  }
}
