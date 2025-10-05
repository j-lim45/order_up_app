import 'package:firebase_database/firebase_database.dart';
import 'package:order_up_app/backend/product_class.dart';

class DatabaseService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  // Create (update)
  Future<void> create({
    required String path, // oath of the file
    required Map<String, dynamic> data // data to write
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.set(data);
  }

  Future<DataSnapshot?> read({required String path}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    final DataSnapshot snapshot = await ref.get();
    return snapshot.exists ? snapshot : null;
  }

  Future<void> update({
    required String path,
    required Map<String, dynamic> data
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.update(data);
  }

  Future<void> addNewSale({required String id, required int quantityToDeduct, required unitPrice}) async {
    DatabaseReference salesRef = _firebaseDatabase.ref("sales");
    Product product = await getProduct(key: id);

    update(path: "products/$id", data: {"quantity": product.quantity-quantityToDeduct});
    salesRef.push().set({
      'product_id': id,
      'quantity'  : quantityToDeduct,
      'timestamp'  : ServerValue.timestamp,
      'unitPrice'  : unitPrice,
    });
  }

  Future<void> addProduct({
    required String name,
    required double price,
    required int quantity,
    required String category,
    required String imageUrl,
    required String barcodeNo
    }) async {
    DatabaseReference ref = _firebaseDatabase.ref("products");
    
    ref.push().set({
      'name'      : name,
      'price'     : price,
      'quantity'  : quantity,
      'category'  : category,
      'image_url' : imageUrl,
      'barcode_num' : barcodeNo
    });
  }

  Future<Product> getProduct({required String key}) async {
    DataSnapshot? productSnapshot = await DatabaseService().read(path: "products/${key}");
    Map<Object?, Object?> productMap = productSnapshot!.value as Map<Object?, Object?>;

    return Product(
      productId: key, 
      productName: productMap['name'].toString(), 
      productImgUrl: productMap['image_url'].toString(), 
      quantity: int.parse(productMap['quantity'].toString()), 
      price: double.parse(productMap['price'].toString()),
      barcode: productMap['barcode_num'].toString() 
    );
  }
}