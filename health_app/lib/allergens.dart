import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class Allergens extends StatefulWidget {
  final String name;
  final String ingredients;
  final String whichAllergens;
  final String canEat;
  final List<String> allergies;

  const Allergens({
    required Key key,
    required this.name,
    required this.ingredients,
    required this.whichAllergens,
    required this.canEat,
    required this.allergies,
  }) : super(key: key);

  @override
  State<Allergens> createState() => AllergensState();
}

class AllergensState extends State<Allergens> {




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
              widget.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              widget.ingredients,
              style: const TextStyle(fontSize: 10),
            ),
            Text(
              widget.canEat,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              widget.whichAllergens,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
            },
            child: const Text('Go back!'),
        ),
          ],
        ),
      ),
    );
  }
}
