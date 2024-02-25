import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_app/theme.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:health_app/home.dart';

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
      //appBar: AppBar(),
      body: Container(
        color: ThemeClass().primaryColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ThemeClass().wColor,
                borderRadius: BorderRadius.circular(40.0)),
            child: Container(
              //color: ThemeClass().bColor,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          width: 40.0,
                        ),
                        const Spacer(),
                        Row(
                          children: <Widget>[
                            ListView(
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: Text(
                                    widget.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        FloatingActionButton.small(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyHomePage(),
                              ),
                            );
                          },
                          backgroundColor: ThemeClass().primaryColor,
                          foregroundColor: ThemeClass().bColor,
                          child: const Icon(
                            Icons.close,
                          ),
                        ),
                      ]),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //const Spacer(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
