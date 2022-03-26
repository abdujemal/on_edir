import 'package:flutter/material.dart';

Color darkOrange = const Color(0xFFf7941f);

Color lightOrange = const Color(0xFFfbaf3a);

Color lightWhite = const Color(0xFF7d7d7f);

Color mainColor = const Color.fromRGBO(9, 32, 66, 1);

Color whiteColor = const Color(0xfff7f7f7);

Color textColor = const Color(0xFFc0cfda);

Color secondColor = const Color.fromRGBO(50, 70, 98, 1);

Gradient btnGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF025d91),
      Color(0xFF1b3c71),
    ]);

Gradient orangeGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [darkOrange, lightOrange]);

Gradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [secondColor, mainColor]);
