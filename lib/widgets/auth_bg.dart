import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.grey,
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        _PurpleBox(),
        _HeaderIcon(),
        child,
      ]),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      child: const Icon(
        Icons.account_circle,
        color: Colors.white,
        size: 100,
      ),
    ));
  }
}

class _PurpleBox extends StatelessWidget {
  get bottom => null;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned(
            child: _Burbujas(),
            top: 90,
            left: 30,
          ),
          Positioned(
            child: _Burbujas(),
            top: -40,
            left: 220,
          ),
          Positioned(
            child: _Burbujas(),
            bottom: -50,
            left: 130,
          ),
          Positioned(
            child: _Burbujas(),
            bottom: 120,
            right: 20,
          ),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 151, 1),
        Color.fromRGBO(98, 70, 178, 1)
      ]));
}

class _Burbujas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
