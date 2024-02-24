import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = 'Initial Name';
  String ingredients = 'Initial Ingredients';
  String whichAllergens = 'Initial No Allergens';
  List<String> allergies = ["Peanut", "Egg", "Sugar"];

  @override
  Widget build(BuildContext context) {
    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Health App');
    OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
      OpenFoodFactsLanguage.ENGLISH
    ];

    OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.USA;
    return Scaffold(
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
              style: TextStyle(fontSize: 10),
            ),
            Text(
              whichAllergens,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () async {
                var tempString = null;
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                if (res is String) {
                  tempString = res;
                }

                var product = await OpenFoodAPIClient.getProductV3(
                  ProductQueryConfiguration(tempString,
                      version: ProductQueryVersion.v3),
                );

                setState(() {
                  name =
                      "Product: ${product.product!.getProductNameBrand(OpenFoodFactsLanguage.ENGLISH, " ")}";
                  ingredients =
                      product.product!. /*productName!*/ ingredientsText!;
                  List<Ingredient>? ingredientsList =
                      product.product!.ingredients;
                  List<String>? allergensList = [];
                  whichAllergens = "";

                  for (int i = 0; i < allergies.length; i++) {
                    allergensList.add("");
                  }

                  for (int i = 0; i < ingredientsList!.length; i++) {
                    String? currentIngredient = ingredientsList[i].text;

                    for (int j = 0; j < allergies.length; j++) {
                      if (allergensList[j].compareTo("") == 0) {
                        if (currentIngredient!
                            .toUpperCase()
                            .contains(allergies[j].toUpperCase())) {
                          allergensList.insert(
                              j, "Has Allergen: $currentIngredient\n");
                        } else {
                          whichAllergens += allergensList[j];
                          allergensList.insert(
                              j, "No Allergen: ${allergies[j]}\n");
                        }
                      }
                    }
                  }

                  for (int i = 0; i < allergensList.length; i++) {
                    //whichAllergens += allergensList[i];
                  }

                  // for(int i = 0; i < allergies.length; i++){
                  //   if(ingredients.toUpperCase().contains(allergies[i].toUpperCase())){
                  //     whichAllergens += "Has Allergen: ${allergies[i]}\n";
                  //   }else{
                  //     whichAllergens += "No Allergen: ${allergies[i]}\n";
                  //   }
                  // }
                });
              },
              child: const Text('Open Scanner'),
            )
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
