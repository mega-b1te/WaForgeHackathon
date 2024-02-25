import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:health_app/home.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'dart:developer';

class Setup extends StatefulWidget {
  @override
  State<Setup> createState() => SetupState();
}

class SetupState extends State<Setup> {
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 4),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: DropdownSearch<String>.multiSelection(
                items: const [
                  "Peanut",
                  "Tree Nut",
                  "Almonds",
                  'Milk',
                  'Egg',
                  'Shellfish',
                  'Gluten',
                  'Soybean',
                  'Sesame',
                  'Gelatin',
                  'Other'
                ],
                popupProps: const PopupPropsMultiSelection.menu(
                  showSelectedItems: true,
                  //disabledItemFn: (String s) => s.startsWith('I'),
                ),
                onChanged: (values) {
                  setState(() {
                    selectedItems = values;
                  });
                },
                selectedItems: [],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                log(selectedItems.toString());

                if (selectedItems.contains("Other")) {
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyHomePage(UniqueKey(), selectedItems),
                    ),
                  );
                }

                //Navigator.pop(context);
              },
              child: const Text('Save Allergens'),
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}

class MyKey {
  const MyKey();
}
