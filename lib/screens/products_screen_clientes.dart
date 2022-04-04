import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tienda/widgets/widgets.dart';
import 'package:tienda/services/services.dart';
import 'package:tienda/providers/product_form_provider.dart';

class ProductScreenClientes extends StatelessWidget {
  const ProductScreenClientes({Key? key}) : super(key: key);

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
      backgroundColor: Colors.grey.withOpacity(0.7),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 20,
            left: 10,
            right: 10,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImage(url: productService.selectProduct.portada),
                  _Regresar(),
                ],
              ),
              _Productform()
            ],
          ),
        ),
      ),
    );
  }
}

class _Productform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.producto;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Form(
        key: productForm.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Text(product.nombre),
            Text(product.puntos.toString()),
            const SizedBox(
              height: 0,
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: product.disponible == false,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:
                      const Color.fromARGB(255, 240, 120, 160), // background
                  onPrimary: Colors.black, // foreground
                ),
                onPressed: productService.isSaving
                    ? null
                    : () async {
                        product.disponible = true;
                        if (!productForm.isValidForm()) return;
                        await productService
                            .saveOrCreateProduct(productForm.producto);
                      },
                child: const Text('Desbloquear'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}

class _Regresar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 5,
      child: IconButton(
        iconSize: 45,
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_circle_left_outlined,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
