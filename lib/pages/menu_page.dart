import 'package:flutter/material.dart';
import 'package:order_up_app/components/product_container.dart';
import 'package:firebase_database/firebase_database.dart';
import '../backend/database_service.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
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

  @override
  Widget build(BuildContext build) {
    return Text("YOU ARE IN MAIN PAGE");
  }
}
