import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String name = 'Initial Name';
  String ingredients = 'Initial Ingredients';
  String whichAllergens = 'Initial No Allergens';
  String canEat = 'You can Eat';
  List<String> allergies = ["Peanut", "Egg", "Sugar"];

  void scanStuff(){
    setState((){

    });
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
                  if (product.product != null) {
                    name =
                        "Product: ${product.product?.getBestProductName(OpenFoodFactsLanguage.ENGLISH) /*getProductNameBrand(OpenFoodFactsLanguage.ENGLISH, " ")*/}";
                    ingredients =
                        product.product!. /*productName!*/ ingredientsText!;
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: GNav(

            selectedIndex: _selectedIndex,
            onTabChange: (index){

              if(index == 1){

                setState((){
                _selectedIndex = index;
                });
              }

              
            },
            
              //color: Color.fromARGB(255, 195, 131, 27),
              gap: 9,
              activeColor: Colors.black,
              padding: EdgeInsets.all(16),
              tabBorder: Border(
                  bottom: BorderSide(color: Colors.black, width: 1.5),
                  top: BorderSide(color: Colors.black, width: 1.5),
                  left: BorderSide(color: Colors.black, width: 1.5),
                  right: BorderSide(color: Colors.black, width: 1.5)),
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
