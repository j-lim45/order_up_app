import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../backend/database_service.dart';
import 'package:order_up_app/components/product_container.dart';
import 'package:order_up_app/components/app_colors.dart';
import 'package:order_up_app/backend/product_class.dart';
import 'package:order_up_app/components/stock_table.dart';
import 'package:order_up_app/components/add_product.dart';


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

  Container tableHeaderContainer(String headerText) {
    TextStyle tableHeaderStyle = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold
    );

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          Text(headerText, style: tableHeaderStyle), 
          FloatingActionButton(
            onPressed: () {
              showDialog(context: context, builder: (BuildContext context) {return AddProduct(category: headerText);});
            }, 
            backgroundColor: AppColors.maroonColor2, 
            child: Icon(Icons.add, 
            color: AppColors.headerColor)
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            tableHeaderContainer('Snacks'),
            StockTable(category: 'snack'),
            tableHeaderContainer('Drinks'),
            StockTable(category: 'drink'),
            tableHeaderContainer('Dishes'),
            StockTable(category: 'dish')
          ],
        )
      )
    );
  }
}
