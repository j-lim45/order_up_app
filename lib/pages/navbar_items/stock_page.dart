import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../backend/database_service.dart';
import 'package:order_up_app/components/product_container.dart';
import 'package:order_up_app/components/app_colors.dart';
import 'package:order_up_app/backend/product_class.dart';
import 'package:order_up_app/components/stock_table.dart';


class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPage();
}

class _StockPage extends State<StockPage> {

  // ?????????? Possibly unused ??????????????? //
  Future<List<Product>> getContainerList() async {
    List productIdList = await getProductIdList;
    List<Product> productList = [];

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

      productList.add(
        Product(
          productId: productId, 
          productName: name, 
          productImgUrl: imageUrl, 
          quantity: int.parse(quantity), 
          price: price.toDouble()
        )
      );
    }

    return productList;
  }

  Future<List> get getProductIdList async {
    DataSnapshot? snapshot = await DatabaseService().read(path: 'products');

    final data = snapshot?.value as Map<Object?, Object?>;
    List<String> productIdList = data.keys
        .map((keys) => keys.toString())
        .toList();
    return productIdList;
  }
  // ?????????????????????????? //

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Row(children: [Text('Snacks'), FloatingActionButton(onPressed: () {})],),
            StockTable(category: 'snack'),
            Text("Drinks"),
            StockTable(category: 'drink'),
            Text("Dishes"),
            StockTable(category: 'dish')
          ],
        )
      )
    );
  }
}
