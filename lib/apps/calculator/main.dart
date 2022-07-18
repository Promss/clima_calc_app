import 'package:flutter/material.dart';
import 'package:navigation_app/apps/calculator/widgets/home_page.dart';
import 'package:navigation_app/apps/calculator/widgets/home_page.dart';
import 'widgets/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  final calcApp = Calc();
  runApp(calcApp);
}

class Calc extends StatelessWidget {
  const Calc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
