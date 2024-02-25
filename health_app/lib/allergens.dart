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
  final String image;
  final List<String> allergies;

  const Allergens({
    required Key key,
    required this.name,
    required this.ingredients,
    required this.whichAllergens,
    required this.canEat,
    required this.image,
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
                      SizedBox(height: 5),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              width: 40.0,
                            ),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(widget.name,
                                      style: TextStyle(fontSize: 20)),
                                ),
                              ],
                            ),
                            Spacer(),
                            FloatingActionButton.small(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              backgroundColor: ThemeClass().primaryColor,
                              foregroundColor: ThemeClass().bColor,
                              child: const Icon(
                                Icons.close,
                              ),
                            ),
                          ]),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Spacer(),
                              Container(
                                constraints: BoxConstraints(maxHeight: 200),
                                child: Image.network(widget.image),
                              ),
                              const Spacer(),
                              Text(
                                widget.canEat,
                                style: TextStyle(
                                    fontSize: 35,
                                    fontFamily: 'Hind',
                                    fontWeight: FontWeight.bold,
                                    color: widget.canEat ==
                                            'This is safe for consumption'
                                        ? ThemeClass().gcolor
                                        : ThemeClass().rcolor),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                widget.whichAllergens,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Hind',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                widget.ingredients,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Hind',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ])),
          ),
        ),
      ),
    );
  }
}
