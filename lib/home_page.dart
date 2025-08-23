import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'database_service.dart';

// This is a product container that should hold all important information about a product and it has its own
// card displayed on the home page
class ProductContainer extends StatelessWidget {
  final String productId;
  final String name;
  final String imgUrl;
  final double price;
  final String quantity;

  const ProductContainer({super.key, required this.productId, required this.name, required this.imgUrl, required this.price, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
        width: 150, height: 150,
        child: Column(
          children: [
            Image.network(imgUrl, width: 80, height: 90,),
            Text(productId),
            Text("₱${price.toString()}"),
            Text("Stock: ${quantity.toString()}")
        ],)
      )
      , onTap: () => {},
    );
  }
}



Future<void> getProducts() async {

  // DataSnapshot needs line 2 to function and holds a data from Firebase DB
  DataSnapshot? snapshot = await DatabaseService().read(path: 'test/products');
  print(snapshot?.value);
}

// Returns a container or a listing of a product with info such as product name, price, and quantity
InkWell get containerProduct {
  return InkWell(
    child: Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
        ),
      width: 150, height: 150,
      child: Column(
        children: [
          Image.network('https://imartgrocersph.com/wp-content/uploads/2020/09/Chippy-Barbecue-27g.png', width: 80, height: 90,),
          Text("Chippy"),
          Text("P20"),
          Text("HELLo")
      ],)
    )
    , onTap: () => {getProducts},
  );
}

// This widget is the first thing a user should see after logging in
class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePage();
  
}

class _AppHomePage extends State<AppHomePage> {

  Future<List<Widget>> getContainerList() async {
    List productIdList = await getProductIdList;
    List<Widget> containerList = [];

    // gets attributes of products and places them in each container widget
    for (final productId in productIdList) {
      String name = ((await DatabaseService().read(path: 'products/$productId/name'))?.value).toString();
      String imageUrl = ((await DatabaseService().read(path: 'products/$productId/image_url'))?.value).toString();
      double price = double.parse((await DatabaseService().read(path: 'products/$productId/name'))?.value as String);
      String quantity = ((await DatabaseService().read(path: 'products/$productId/quantity'))?.value).toString();

      containerList.add(ProductContainer(productId: productId, name: name, imgUrl: image_url, price: price, quantity: quantity));
    }

    return containerList;
  }

  Future<List> get getProductIdList async {
    DataSnapshot? snapshot = await DatabaseService().read(path: 'products');
    
    final data = snapshot?.value as Map<Object?, Object?>;
    List<String> productIdList = data.keys.map((keys) => keys.toString()).toList();

    return productIdList;
  }


  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false, // this should work but it doesnt
      home: Scaffold(

        // App Bar
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Hello")
        ),

        // Body of the column of product listings
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  containerProduct,
                  containerProduct,
              ],),
              //ElevatedButton(onPressed: () {getContainerList();}, child: Text("CLICK ME"))
            ]
          ,)
        ,)
      )
    );
  }
}

