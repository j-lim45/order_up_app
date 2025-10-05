import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../backend/database_service.dart';
import 'package:order_up_app/components/app_colors.dart';
import 'package:order_up_app/backend/product_class.dart';
import 'package:order_up_app/components/stock_table.dart';
import 'package:order_up_app/components/add_product.dart';
import 'package:order_up_app/components/search_bar.dart';


class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPage();
}

class _StockPage extends State<StockPage> {

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
          FloatingActionButton.small(
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
            StockSearchBar(),
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
