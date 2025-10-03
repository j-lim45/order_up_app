class Product {
  String productId = "";
  String productName = "";
  String productImgUrl = "";
  int quantity = 0;
  double price = 0.0;
  String? barcode;

  Product({
    required this.productId, 
    required this.productName, 
    required this.productImgUrl, 
    required this.quantity, 
    required this.price,
    this.barcode
  });
}