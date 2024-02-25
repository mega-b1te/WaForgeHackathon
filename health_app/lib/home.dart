import 'package:flutter/material.dart';
import 'package:health_app/allergens.dart' as display;
import 'package:health_app/profile.dart' as profile;
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:health_app/theme.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = 'Initial Name';
  String ingredients = 'Initial Ingredients';
  String whichAllergens = 'Initial No Allergens';
  String canEat = 'You can Eat';
  List<String> allergies = ["Peanut", "Egg", "Sugar"];

  void scanStuff() {
    setState(() {});
  }

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
      body: Center(),
      bottomNavigationBar: Container(
        color: ThemeClass().secondaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: GNav(
              onTabChange: (index) async {
                if (index == 1) {
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
                    if (product.product != null) {
                      name =
                          "Product: ${product.product?.getBestProductName(OpenFoodFactsLanguage.ENGLISH) /*getProductNameBrand(OpenFoodFactsLanguage.ENGLISH, " ")*/}";

                      if (product.product?.ingredientsText != null) {
                        ingredients = "${product.product?.ingredientsText}";

                        List<Ingredient>? ingredientsList =
                            product.product?.ingredients;
                        List<String>? allergensList = [];
                        whichAllergens = "";

                        for (int i = 0; i < allergies.length; i++) {
                          allergensList.add("");
                        }

                        for (int i = 0; i < ingredientsList!.length; i++) {
                          String? currentIngredient = ingredientsList[i].text;

                          for (int j = 0; j < allergies.length; j++) {
                            //whichAllergens += "${currentIngredient!.toUpperCase()}-${allergies[j].toUpperCase()}/";
                            if (allergensList[j].compareTo("") == 0 ||
                                allergensList[j].contains("No")) {
                              if (currentIngredient!
                                  .toUpperCase()
                                  .contains(allergies[j].toUpperCase())) {
                                allergensList.insert(
                                    j, "Has Allergen: $currentIngredient\n");

                                allergensList.removeAt(j + 1);
                              } else {
                                allergensList.insert(
                                    j, "No Allergen: ${allergies[j]}\n");

                                allergensList.removeAt(j + 1);
                              }
                            }
                          }
                        }

                        for (int i = 0; i < allergensList.length; i++) {
                          if (!allergensList[i].contains("No")) {
                            whichAllergens += allergensList[i];
                          }
                        }

                        if (whichAllergens.compareTo("") == 0) {
                          canEat = "You can eat this";
                        } else {
                          canEat = "You can't eat this";
                        }
                      } else {
                        name = "Error With Scanning";
                        whichAllergens = "";
                        ingredients = "Please Try Again";
                        canEat = "";
                      }
                    } else {
                      name = "Error With Scanning";
                      whichAllergens = "";
                      ingredients = "Please Try Again";
                      canEat = "";
                    }

                    // for(int i = 0; i < allergies.length; i++){
                    //   if(ingredients.toUpperCase().contains(allergies[i].toUpperCase())){
                    //     whichAllergens += "Has Allergen: ${allergies[i]}\n";
                    //   }else{
                    //     whichAllergens += "No Allergen: ${allergies[i]}\n";
                    //   }
                    // }
                  });

                  // setState((){
                  // _selectedIndex = index;
                  // });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => display.Allergens(
                        key: UniqueKey(),
                        name: this.name,
                        ingredients: this.ingredients,
                        whichAllergens: this.whichAllergens,
                        canEat: this.canEat,
                        allergies: this.allergies,
                      ),
                    ),
                  );
                } //else if(index == 2){
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => (profile.Profile()),
                //     ),
                //   );
                // }
              },

              //color: Color.fromARGB(255, 195, 131, 27),
              gap: 9,
              activeColor: ThemeClass().wColor,
              backgroundColor: ThemeClass().secondaryColor,
              padding: const EdgeInsets.all(16),
              // tabBorder: Border(
              //     bottom: BorderSide(color: Colors.black, width: 1.5),
              //     top: BorderSide(color: Colors.black, width: 1.5),
              //     left: BorderSide(color: Colors.black, width: 1.5),
              //     right: BorderSide(color: Colors.black, width: 1.5)),
              tabs: [
                GButton(
                  backgroundColor: ThemeClass().primaryColor,
                  icon: Icons.home,
                  iconColor: ThemeClass().wColor,
                  text: 'Home',
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ThemeClass().wColor,
                      fontFamily: 'Hind'),
                ),
                GButton(
                  backgroundColor: ThemeClass().primaryColor,
                  icon: Icons.camera_alt,
                  iconColor: ThemeClass().wColor,
                  text: 'Scan',
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ThemeClass().wColor,
                      fontFamily: 'Hind'),
                ),
                GButton(
                  backgroundColor: ThemeClass().primaryColor,
                  icon: Icons.person,
                  iconColor: ThemeClass().wColor,
                  text: 'Profile',
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ThemeClass().wColor,
                      fontFamily: 'Hind'),
                ),
              ]),
        ),
      ),
    );
  }
}
