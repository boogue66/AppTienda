import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tienda/screens/screens.dart';
import 'package:tienda/services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsService(),
          lazy: true,
        ),
      ],
      child: MyApp(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store App',
      initialRoute: 'inicioClientes',
      routes: {
        'login': (_) => const LoginScreen(),
        'home': (_) => const HomeScreen(),
        'inicio': (_) => const HomeScreenGrid(),
        'producto': (_) => const ProductScreen(),
        'productoClientes': (_) => const ProductScreenClientes(),
        'inicioClientes': (_) => const HomeScreenGridClientes(),
        'productoSets': (_) => const ProductScreenClientes(),
      },
      theme: ThemeData.light().copyWith(
        //scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 5,
          color: Colors.black,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
