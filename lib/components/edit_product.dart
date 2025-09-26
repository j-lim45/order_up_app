import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:order_up_app/components/app_colors.dart';
import 'package:order_up_app/backend/product_class.dart';


class EditProduct extends StatefulWidget {
  final Product product;

  const EditProduct({super.key, required this.product});

  @override
  State<EditProduct> createState() => _EditProduct();
}

class _EditProduct extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product.productName)
    );
  }
}