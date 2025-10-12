import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:order_up_app/components/misc/app_colors.dart';
import 'package:order_up_app/backend/product_class.dart';
import 'package:order_up_app/backend/database_service.dart';

class EditProduct extends StatefulWidget {
  final Product product;

  const EditProduct({
    super.key,
    required this.product
  });

  @override
  State<EditProduct> createState() => _EditProduct();
}

class _EditProduct extends State<EditProduct> {
  int quantity = 0;

  void snackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
}

  // Editing Controllers
  bool isEditingName = false;
  late TextEditingController nameController;

  bool isEditingBarcode = false;
  late TextEditingController barcodeController;

  bool isEditingCategory = false;

  bool isEditingPrice = false;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.productName);
    priceController = TextEditingController(text: widget.product.price.toString());
    barcodeController = TextEditingController(text: widget.product.barcode.toString());
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle attributeTextStyle = TextStyle(
      fontSize: 24
    );

    BoxDecoration notEditingDecoration = BoxDecoration(
      color: const Color.fromARGB(255, 247, 230, 230), 
      border: BoxBorder.all(width: 1), 
      borderRadius: BorderRadius.circular(8)
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.maroonColor, foregroundColor: AppColors.whiteColor,
      ),
      body: Column(
        children: [

          // PRODUCT IMAGE
          widget.product.productImgUrl != "" ? Image.network(
            widget.product.productImgUrl,
            height: 120,
            width: 120,
            fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ) : Image.asset('img/orderuplogo.png', width: 120, height: 120,),

          // PRODUCT NAME
          Row(
            children: [
              Text("Name: ", style: attributeTextStyle),
              isEditingName
              ? Container(
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 224, 224, 224)),
                  width: 200,
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(6),
                      border: OutlineInputBorder(),
                    ),
                  ),
                )
              : Container(
                  decoration: notEditingDecoration,
                  padding: EdgeInsets.all(9),
                  width: 200,
                  child: Text(
                  widget.product.productName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              IconButton(
                icon: Icon(
                    isEditingName ? Icons.check : Icons.edit,
                    size: 18,
                    color: Colors.blue),
                onPressed: () {
                  setState(() {
                    if (isEditingName && widget.product.productName != nameController.text) {
                      DatabaseService().updateName(id: widget.product.productId, name: nameController.text);
                      snackBar('Name updated to ${nameController.text}');
                    } 
                    widget.product.productName = nameController.text;
                    isEditingName = !isEditingName;
                  });
                },
              ),
            ]
          ),



          // PRODUCT BARCODE
          Row(
            children: [
              Text("Barcode: ", style: attributeTextStyle),               
              isEditingBarcode
              ? Container(
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 224, 224, 224)),
                  width: 200,
                  child: TextField(
                    controller: barcodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(6),
                      border: OutlineInputBorder(),
                    ),
                  ),
                )
              : Container(
                  decoration: notEditingDecoration,
                  padding: EdgeInsets.all(9),
                  width: 200,
                  child: Text(
                  widget.product.barcode != "" ? "${widget.product.barcode}" : "N/A",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              IconButton(
                icon: Icon(
                    isEditingBarcode ? Icons.check : Icons.edit,
                    size: 18,
                    color: Colors.blue),
                onPressed: () {
                  setState(() {
                    if (isEditingBarcode && barcodeController.text != widget.product.barcode) {
                      if (RegExp(r'^[0-9]+$').hasMatch(barcodeController.text)) {
                        DatabaseService().updateBarcode(id: widget.product.productId, barcode: barcodeController.text);
                        snackBar('Barcode updated to ${barcodeController.text}');
                      } else {
                        snackBar('Input should have numbers only');
                    }

                    }
                    widget.product.barcode = barcodeController.text;
                    isEditingBarcode = !isEditingBarcode;
                  });
                },
              ),
            ]
          ),

          // PRODUCT CATEGORY
          Row(
            children: [
              Text("Category: ", style: attributeTextStyle),
              DropdownButton<String>(
                value: widget.product.category,
                items: ['snack', "drink", "dish"].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
                onChanged: (String? value) {
                  DatabaseService().updateCategory(id: widget.product.productId, category: value!);
                  snackBar('Category updated to $value.');
                  setState(() {
                    widget.product.category = value;
                  
                  });
                },
              ),
            ],
          ),
         

          // PRODUCT PRICE
          Row(
            children: [
              Text("Price: ₱", style: attributeTextStyle),
              isEditingPrice
              ? Container(
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 224, 224, 224)),
                  width: 100,
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(6),
                      border: OutlineInputBorder(),
                    ),
                  ),
                )
              : Container( 
                  decoration: notEditingDecoration,
                  padding: EdgeInsets.all(9),
                  width: 100,
                  child: Text(
                    "${widget.product.price}",
                    style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold
                    ),
                  )
              ),

              IconButton(
                icon: Icon(
                    isEditingPrice ? Icons.check : Icons.edit,
                    size: 18,
                    color: Colors.blue),
                onPressed: () {
                  setState(() {
                    if (isEditingPrice && double.parse(priceController.text) != widget.product.price) {
                      if (double.parse(priceController.text) > 0) {
                        DatabaseService().updateProductPrice(id: widget.product.productId, price: double.parse(priceController.text));
                        snackBar('Price updated to ₱${priceController.text}');
                      } else {
                        snackBar('Price should be more than ₱0');
                      }
                    }
                    isEditingPrice = !isEditingPrice;
                  });
                },
              ),
            ]
          ),
        

          // PRODUCT STOCK
          Text(
            "Stock: ${widget.product.quantity}",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),



          // QUANTITY
          const Text(
            "Quantity",
            style: TextStyle(
              fontSize: 14, 
              fontWeight: FontWeight.bold
            )
          ),

          // QUANTITY SLIDER
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon:
                    const Icon(Icons.remove_circle, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    if (quantity > 0) quantity--;
                  });
                },
              ),
              Text("$quantity",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.add_circle,
                    color: Color.fromARGB(255, 161, 24, 29)),
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
              ),
            ],
          ),

          // ADD STOCK BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 161, 24, 29),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                DatabaseService().addStock(id: widget.product.productId, quantityToAdd: quantity);

                Navigator.pop(context, {
                  "quantity": quantity,
                  "price": widget.product.price,
                });
              },
              child: const Text(
                "Add Stock",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      )
    );
  }
}