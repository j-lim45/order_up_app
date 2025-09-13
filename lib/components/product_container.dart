import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../backend/database_service.dart';

// This is a product container that should hold all important information about a product and it has its own
// card displayed on the home page
class ProductContainer extends StatelessWidget {
  final String productId;
  final String name;
  final String imgUrl;
  final double price;
  final String quantity;

  const ProductContainer({
    super.key,
    required this.productId,
    required this.name,
    required this.imgUrl,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
        ),
        width: 150,
        height: 150,
        child: Column(
          children: [
            Image.network(imgUrl, width: 80, height: 90),
            Text(productId),
            Text("₱${price.toString()}"),
            Text("Stock: ${quantity.toString()}"),
          ],
        ),
      ),
      onTap: () => {},
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
      width: 150,
      height: 150,
      child: Column(
        children: [
          Image.network(
            'https://imartgrocersph.com/wp-content/uploads/2020/09/Chippy-Barbecue-27g.png',
            width: 80,
            height: 90,
          ),
          Text("Chippy"),
          Text("P20"),
          Text("HELLo"),
        ],
      ),
    ),
    onTap: () => {getProducts},
  );
}
