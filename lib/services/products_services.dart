// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tienda/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-tienda-36ab8-default-rtdb.firebaseio.com';
  final List<Product> productos = [];
  late Product selectProduct;

  File? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    loadProducts();
  }

  Future loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      productos.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return productos;
  }

  Future saveOrCreateProduct(Product producto) async {
    isSaving = true;
    notifyListeners();

    if (producto.id == null) {
      await createProduct(producto);
    } else {
      await updateProduct(producto);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> createProduct(Product producto) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: producto.toJson());
    final decodeData = json.decode(resp.body);

    producto.id = decodeData['name'];
    productos.add(producto);
    return producto.id!;
  }

  Future<String> updateProduct(Product producto) async {
    final url = Uri.https(_baseUrl, 'products/${producto.id}.json');
    final resp = await http.put(url, body: producto.toJson());
    final decodeData = resp.body;

    print(decodeData);
    final index = productos.indexWhere((element) => element.id == producto.id);
    productos[index] = producto;
    return producto.id!;
  }

  /* void  deleteProduct(Product producto)  {
      // ignore: list_remove_unrelated_type
      productos.remove(producto.id);
      
    } */

  void updateSelectedProducImage(String path) {
    selectProduct.portada = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;
    isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dnhex64cz/image/upload?upload_preset=flutter-store');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }
    newPictureFile = null;
    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];
  }
}
