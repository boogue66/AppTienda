import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:tienda/services/services.dart';
import 'package:tienda/widgets/widgets.dart';

class CardSwiper extends StatelessWidget {
  final String? url;
  const CardSwiper({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity * 0.7,
      height: size.height * 0.5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 15),
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemCount: productService.productos.length,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.5,
          autoplay: false,
          itemBuilder: (_, int index) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'galeriaClientes',
                  arguments: 'coleccion'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ProductImage(url: productService.selectProduct.portada),
              ),
            );
          },
        ),
      ),
    );
  }
}
