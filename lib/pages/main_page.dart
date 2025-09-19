import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../backend/database_service.dart';
import 'package:order_up_app/components/product_container.dart';
import 'package:order_up_app/pages/home_page.dart';
import 'package:order_up_app/pages/stock_page.dart';
import 'package:order_up_app/pages/reports_page.dart';
import 'package:order_up_app/pages/menu_page.dart';
import 'package:order_up_app/components/bottom_nav_bar.dart';

// This widget is the first thing a user should see after logging in
class AppMainPage extends StatefulWidget {
  const AppMainPage({super.key});

  @override
  State<AppMainPage> createState() => _AppMainPage();
}

class _AppMainPage extends State<AppMainPage> {
  int _selectedNavBarIndex = 0; // Index of the Page on the Bottom Navbar

  final List<Widget> _navBarPages = [HomePage(), StockPage(), ReportsPage(), MenuPage()];

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

  void _onClicked(int index) {
    setState(() {
      _selectedNavBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // App Bar
        appBar: AppBar(backgroundColor: Colors.red, title: Text("Hello")),

        // Body of the column of product listings
        body: _navBarPages[_selectedNavBarIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.camera),
        ),
        bottomNavigationBar: BottomNavBar(currentIndex: _selectedNavBarIndex, onClicked: (int index) {_onClicked(index);})
      ),
    );
  }
}
