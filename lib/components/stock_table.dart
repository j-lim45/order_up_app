import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class StockTable extends StatelessWidget {
  const StockTable({super.key});

  @override
  Widget build(BuildContext context) {
    // StreamBuilder is used to update the table everytime data is changed in realtime
    return StreamBuilder<DatabaseEvent>(
      stream: FirebaseDatabase.instance.ref("products").onValue,      // the current data of the products database
      builder: (context, snapshot) {                                  // the actual widget where the data is to be placed in
        if (snapshot.connectionState == ConnectionState.waiting) {    // loading indicator while waiting
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {                                      // error
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData) {                                      // No products in table
          return Center(child: Text("No products available"));
        }

        // Raw json data from products database
        final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

        // Convert to DataRow list (direct, no model class)
        final List<DataRow> productRows = [];

        // Loops through each product in the table to add each attribute data into a DataRow
        for (var product in data.entries) {
          final productRow = product.value as Map<Object?, Object?>;

          productRows.add(
            DataRow(cells: [
              DataCell(Text(productRow['name'].toString())),
              DataCell(Text(productRow['price'].toString())),
              DataCell(Text(productRow['quantity'].toString()))
            ]),
          );
        }

        return DataTable(
          columns: [
            DataColumn(label: Text('PRODUCT')),
            DataColumn(label: Text("PRICE")),
            DataColumn(label: Text("QUANTITY"))
          ],
          rows: productRows,
        );
      },
    );
  }
}