import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        child: Column(
          children: <Widget>[

            DropdownSearch<String>.multiSelection(
                items: ["Peanut", "Tree Nut", "Almonds", 'Milk', 'Egg', 'Shellfish', 'Gluten', 'Soybean', 'Sesame', 'Gelatin', 'Other'],
                popupProps: PopupPropsMultiSelection.menu(
                showSelectedItems: true,
                //disabledItemFn: (String s) => s.startsWith('I'),
              ),
              onChanged: (values){
                setState((){
                  selectedItems = values;
                });
              },
              selectedItems: [],
            ),
            
            ElevatedButton(
              onPressed: () {
                log(selectedItems.toString());

                if(selectedItems.contains("Other")){

                }else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(
                        UniqueKey(),
                        selectedItems
                        
                      ),
                    ),
                  );
                }
                
                //Navigator.pop(context);
              },
              child: const Text('Save Allergens'),
            ),
          ],
        ),
      ),
    );
  }
}
