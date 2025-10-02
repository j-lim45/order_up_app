import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:order_up_app/backend/product_class.dart';


class StockSearchBar extends StatefulWidget {
  const StockSearchBar({super.key});

  State<StockSearchBar> createState() => _StockSearchBar();
}

class _StockSearchBar extends State<StockSearchBar> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: FirebaseDatabase.instance.ref("products").onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {    // loading indicator while waiting
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {                                      // error
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        // Raw json data from products database
        final data = snapshot.data!.snapshot.value as Map<Object?, Object?>;

        Map<String, String> searchList = {};
        // Loops through each product in the table to add each attribute data into a DataRow
        for (var product in data.entries) {
          final productRow = product.value as Map<Object?, Object?>;
          searchList[product.key.toString()] = productRow['name'].toString();
        }
        

        return SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 20.0),
                ),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController controller) {
            String searchQuery = controller.text;

            if (controller.text == "") {
              return [];
            }

            Map<String, String> searchResults = {}; 

            for (var product in searchList.entries) {
              if (product.value.toLowerCase().contains(searchQuery.toLowerCase())) {
                searchResults[product.key] = product.value;
              }
            }

            return searchResults.entries.map((entry) {

              return ListTile(
                title: Text(entry.value),
                onTap: () {
                  controller.closeView(entry.value);
                  print(entry.key);
                }
              );
            }).toList();

            // return List<ListTile>.generate(5, (int index) {
            //   final String item = 'item $index';
            //   return ListTile(
            //     title: Text(item),
            //     onTap: () {
            //       setState(() {
            //         controller.closeView(item);
            //       });
            //     },
            //   );
            // });
          },
        );
      }
    );
  }
}