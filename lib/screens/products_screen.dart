import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tienda/widgets/widgets.dart';
import 'package:tienda/services/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tienda/ui/input_decorations.dart';
import 'package:tienda/providers/product_form_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

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
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
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
                  //*Boton de la camara
                  Positioned(
                    top: 15,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image =
                            await _picker.pickImage(source: ImageSource.camera);

                        final XFile? file = XFile(image!.path);
                        if (file == null) {
                          //print('No selecciono nada');
                          return;
                        }
                        //print('Tenemos image$file');
                        productService.updateSelectedProducImage(file.path);
                      },
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  //*Boton para la galeria
                  Positioned(
                    top: 15,
                    right: 70,
                    child: IconButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 100);
                        final XFile? file = XFile(image!.path);
                        if (file == null) {
                          //print('No selecciono nada');
                          return;
                        }
                        //|print('Tenemos image$file');
                        productService.updateSelectedProducImage(file.path);
                      },
                      icon: const Icon(
                        Icons.image,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              _Productform()
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        isExtended: true,
        elevation: 10,
        child: productService.isSaving
            ? const CircularProgressIndicator(color: Colors.pink)
            : const Icon(
                Icons.save_outlined,
                color: Colors.pinkAccent,
                size: 35,
              ),
        onPressed: productService.isSaving
            ? null
            : () async {
                if (!productForm.isValidForm()) return;
                final String? imageUrl = await productService.uploadImage();
                if (imageUrl != null) productForm.producto.portada = imageUrl;
                await productService.saveOrCreateProduct(productForm.producto);
              },
      ),
    );
  }
}

class _Productform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            const SizedBox(
              height: 0,
            ),
            TextFormField(
              initialValue: product.nombre,
              onChanged: (value) => product.nombre = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Nombre del producto',
                labelText: 'Nombre:',
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            TextFormField(
              initialValue: '${product.puntos}',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)$'))
              ],
              onChanged: (value) {
                if (int.tryParse(value) == null) {
                  product.puntos = 0;
                } else {
                  product.puntos = int.parse(value);
                }
              },
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '\$ 100',
                labelText: 'Puntos:',
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            SwitchListTile.adaptive(
              activeColor: Colors.pink,
              title: const Text('Disponible'),
              value: product.disponible,
              onChanged: productForm.updateDisponibilidad,
            ),
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
