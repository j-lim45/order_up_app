import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../backend/database_service.dart';
import 'package:order_up_app/components/product_container.dart';
import 'package:order_up_app/pages/navbar_items/home_page.dart';
import 'package:order_up_app/components/bottom_nav_bar.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPage();
}

class _StockPage extends State<StockPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Stock Page")
    );
  }
}
