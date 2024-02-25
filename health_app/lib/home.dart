import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
              whichAllergens,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () async {
                // ignore: prefer_typing_uninitialized_variables
                var tempString;
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
              //color: Color.fromARGB(255, 195, 131, 27),
              gap: 9,
              activeColor: Colors.black,
              padding: EdgeInsets.all(16),
              tabs: [
                GButton(
                  icon: Icons.home,
                  iconColor: Color.fromARGB(255, 113, 70, 0),
                  text: 'Home',
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                GButton(
                  icon: Icons.camera_alt,
                  iconColor: Color.fromARGB(255, 113, 70, 0),
                  text: 'Scan',
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                GButton(
                  icon: Icons.person,
                  iconColor: Color.fromARGB(255, 113, 70, 0),
                  text: 'Food',
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
