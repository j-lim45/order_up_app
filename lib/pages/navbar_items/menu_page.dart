import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../backend/database_service.dart';
import 'package:order_up_app/components/product_container.dart';
import 'package:order_up_app/pages/navbar_items/home_page.dart';
import 'package:order_up_app/components/bottom_nav_bar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Menu Page")
    );
  }
}