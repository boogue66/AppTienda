import 'dart:io';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;
  const ProductImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: queryData.size.height * 0.7,
        child: Opacity(
          opacity: 0.7,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: getImage(url),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(5, 5)),
          ]);

  Widget getImage(String? picture) {
    if (picture == null) {
      return const Image(
        image: AssetImage('assets/images/no-image.png'),
        fit: BoxFit.cover,
      );
    }

    if (picture.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('assets/images/jar-loading.gif'),
        image: NetworkImage(url!),
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
