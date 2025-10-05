import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:order_up_app/components/app_colors.dart';
import 'package:order_up_app/backend/product_class.dart';

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

  // For price editing
  bool isEditingPrice = false;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(text: widget.product.price.toString());
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.transparent,
      child: Card(
        color: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: Text(
                      widget.product.productName,
                      style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                    )
                  ),
                ),
                // Product Image
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

                const SizedBox(height: 10),

                // Barcode + Category
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text("Barcode: ", style: TextStyle(fontSize: 14)),
                      Text(widget.product.barcode != "" ? widget.product.barcode! : "N/A",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text("Category: ", style: TextStyle(fontSize: 14)),
                      Text(widget.product.category,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Indicators (left) and Price+Stock (right)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Indicators
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.arrow_upward,
                                color: Colors.green, size: 16),
                            SizedBox(width: 4),
                            Text("Price Up"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.remove, color: Colors.grey, size: 16),
                            SizedBox(width: 4),
                            Text("Stable Price"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.arrow_downward,
                                color: Colors.red, size: 16),
                            SizedBox(width: 4),
                            Text("Price Down"),
                          ],
                        ),
                      ],
                    ),

                    // Price + Stock
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // 👇 Edit button above price
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                                isEditingPrice ? Icons.check : Icons.edit,
                                size: 18,
                                color: Colors.blue),
                            onPressed: () {
                              setState(() {
                                if (isEditingPrice) {
                                  widget.product.price = double.parse(priceController.text);
                                }
                                isEditingPrice = !isEditingPrice;
                              });
                            },
                          ),
                        ),

                        // 👇 Price value
                        isEditingPrice
                            ? SizedBox(
                                width: 100,
                                child: TextField(
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.right,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(6),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              )
                            : Text(
                                "Price: ₱${widget.product.price}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),

                        const SizedBox(height: 6),

                        Text(
                          "Stock: ${widget.product.quantity}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Quantity selector
                const Text("Quantity",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
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
                const SizedBox(height: 10),

                // Add Stock button
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
            ),
          ),
        ),
      ),
    );
  }
}