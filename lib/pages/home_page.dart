import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../backend/database_service.dart';
import 'package:order_up_app/components/product_container.dart';

// This widget is the first thing a user should see after logging in
class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePage();
}

class _AppHomePage extends State<AppHomePage> {
  int _selectedNavBarIndex = 0; // Index of the Page on the Bottom Navbar

  // !!! PLEASE REMOVE THIS SOON !!! ///
  Future<List<Widget>> getContainerList() async {
    List productIdList = await getProductIdList;
    List<Widget> containerList = [];

    // gets attributes of products and places them in each container widget
    for (final productId in productIdList) {
      String name = ((await DatabaseService().read(
        path: 'products/$productId/name',
      ))?.value).toString();
      String imageUrl = ((await DatabaseService().read(
        path: 'products/$productId/image_url',
      ))?.value).toString();
      double price = double.parse(
        (await DatabaseService().read(path: 'products/$productId/name'))?.value
            as String,
      );
      String quantity = ((await DatabaseService().read(
        path: 'products/$productId/quantity',
      ))?.value).toString();

      containerList.add(
        ProductContainer(
          productId: productId,
          name: name,
          imgUrl: imageUrl,
          price: price,
          quantity: quantity,
        ),
      );
    }

    return containerList;
  }

  Future<List> get getProductIdList async {
    DataSnapshot? snapshot = await DatabaseService().read(path: 'products');

    final data = snapshot?.value as Map<Object?, Object?>;
    List<String> productIdList = data.keys
        .map((keys) => keys.toString())
        .toList();

    return productIdList;
  }

  /// !!! !!! ///

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // this should work but it doesnt
      home: Scaffold(
        // App Bar
        appBar: AppBar(backgroundColor: Colors.red, title: Text("Hello")),

        // Body of the column of product listings
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [containerProduct, containerProduct],
              ),
              //ElevatedButton(onPressed: () {getContainerList();}, child: Text("CLICK ME"))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.camera),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              label: "Stock",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.content_paste),
              label: "Reports",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Menu"),
          ],
          selectedItemColor: Colors.amber[800],
          onTap: (int index) {},
        ),
      ),
    );
  }
}
