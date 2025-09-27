import 'package:firebase_database/firebase_database.dart';

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

  Future<void> addNewSale({required String name}) async {
    DatabaseReference ref = _firebaseDatabase.ref("sales");
    
    ref.push().set({
    name : {
        "teting"
    }
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


}