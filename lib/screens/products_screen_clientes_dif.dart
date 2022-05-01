import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda/widgets/widgets.dart';
import 'package:tienda/services/services.dart';
import 'package:tienda/providers/product_form_provider.dart';

class ProductScreenClientesDif extends StatelessWidget {
  const ProductScreenClientesDif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectProduct),
      child: _ProductScreenBody(productService: productService),
    );

    //return _ProductScreenBody(productService: productService);
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.withOpacity(0.6),
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              //const CardSwiper(),
              const ColeccionSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
