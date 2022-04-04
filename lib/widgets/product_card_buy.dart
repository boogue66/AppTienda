import 'package:flutter/material.dart';
import 'package:tienda/models/models.dart';

class ProductCardBuy extends StatelessWidget {
  final Product producto;

  const ProductCardBuy({Key? key, required this.producto}) : super(key: key);

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
            if (!producto.disponible)
              Positioned(
                top: 0,
                left: 0,
                child: _NoAvalible(producto.disponible, producto.puntos,
                    producto.id.toString()),
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
  final bool disponible;
  final int puntos;
  final String id;

  const _NoAvalible(this.disponible, this.puntos, this.id);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Container(
        child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Text(
                  'DISPONIBLE POR',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 240, 120, 160),
                      overflow: TextOverflow.clip),
                ),
                Text(
                  '¥ $puntos',
                  style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 240, 120, 160),
                      overflow: TextOverflow.clip),
                ),
                /* ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:
                        const Color.fromARGB(255, 240, 120, 160), // background
                    onPrimary: Colors.black, // foreground
                  ),
                  onPressed: () {},
                  child: const Text('Desbloquear'),
                ), */
              ],
            ),
          ),
        ),
        width: queryData.size.width * 0.45,
        height: 265,
        decoration: BoxDecoration(
            //color: const Color.fromARGB(255, 240, 120, 160).withOpacity(.8),
            color: Colors.black.withOpacity(.75),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            )),
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
            '¥ $puntos',
            style: const TextStyle(
                fontSize: 45,
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
        height: 55,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 240, 120, 160)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
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
      child: SizedBox(
        width: double.infinity,
        height: 400,
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
