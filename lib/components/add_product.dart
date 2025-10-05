import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:order_up_app/backend/database_service.dart';

const List<String> categories = ['Snack', "Drink", "Dish"];

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  String categoryPseudoController = categories.first;

  onClickedAddProduct() async {
    String disallowedChars = "@#{};\'\"";
    
    // Please add validation soon.
    await DatabaseService().addProduct(
      name: productNameController.text, 
      price: double.parse(priceController.text), 
      quantity: 0,
      category: categoryPseudoController.toLowerCase(), 
      imageUrl: imageController.text,
      barcodeNo: barcodeController.text
      );
  }

  void changedCategory(String? newValue) {
    setState(() {
      categoryPseudoController = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Product'),
      content: SizedBox(
        width: 300,
        height: 450,
        child: Column(
          children: [
            TextField(
              controller: productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder()
              ),
            ),

            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                hintText: '₱',
                border: OutlineInputBorder()
              ),
            ),

            TextField(
              controller: imageController,
              decoration: InputDecoration(
                labelText: 'Image Link (Optional)',
                border: OutlineInputBorder()
              ),
            ),

            DropdownButton<String>(
              value: categoryPseudoController,
              items: categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
              onChanged: (String? value) {changedCategory(value);},
            ),

            TextField(
              inputFormatters: [],
              controller: barcodeController,
              decoration: InputDecoration(
                labelText: 'Barcode Number (Optional)',
                border: OutlineInputBorder()
              ),
            ),

            FloatingActionButton(onPressed: onClickedAddProduct),

          ],
        )
      )
    );
  }
}