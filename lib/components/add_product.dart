import 'package:flutter/material.dart';
import 'package:order_up_app/backend/database_service.dart';

class AddProduct extends StatefulWidget {
  final String category;
  const AddProduct({super.key, required this.category});

  @override
  State<AddProduct> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();

  onClickedAddProduct() async {
    // Please add validation soon.
    // await DatabaseService().create(path: 'products', data: );
    String categoryData;

    if (widget.category=="Snacks")      categoryData = 'snack';
    else if (widget.category=='Drinks') categoryData = 'drink';
    else if (widget.category=='Dishes') categoryData = 'dish';
    else                                categoryData = 'null';

    await DatabaseService().addProduct(
      name: productNameController.text, 
      price: double.parse(priceController.text), 
      quantity: 0, 
      category: categoryData, 
      imageUrl: imageController.text,
      barcodeNo: barcodeController.text
      );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adds New ${widget.category}'),
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

            TextField(
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