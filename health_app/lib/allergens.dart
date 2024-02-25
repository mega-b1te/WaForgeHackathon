import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class Allergens extends StatefulWidget {
  const Allergens({super.key});

  @override
  State<Allergens> createState() => AllergensState();
}

class AllergensState extends State<Allergens> {

  int _selectedIndex = 0;
  String name = 'Initial Name';
  String ingredients = 'Initial Ingredients';
  String whichAllergens = 'Initial No Allergens';
  String canEat = 'You can Eat';
  List<String> allergies = ["Peanut", "Egg", "Sugar"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              ingredients,
              style: const TextStyle(fontSize: 10),
            ),
            Text(
              canEat,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              whichAllergens,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
