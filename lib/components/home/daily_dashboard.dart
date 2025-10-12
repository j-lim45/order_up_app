import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:order_up_app/backend/sale_class.dart';
import 'package:order_up_app/components/misc/app_colors.dart';
import 'package:order_up_app/components/stock/edit_product.dart';
import 'package:order_up_app/backend/product_class.dart';
import 'package:order_up_app/backend/database_service.dart';

class DailyDashboard extends StatefulWidget {
  const DailyDashboard({super.key});

  @override
  State<DailyDashboard> createState() => _DailyDashboard();
}

class _DailyDashboard extends State<DailyDashboard> {

  Future<Map<String, Map>> getSales() async {
    List salesList = await DatabaseService().getFirstSale();
    Map<String, Map<String, dynamic>> salesToday = {};
    
    DateTime timeNow = DateTime.now();
    for (Sale sale in salesList) {
      DateTime currentSaleDate = sale.dateTime;
      if (
        currentSaleDate.year==timeNow.year &&
        currentSaleDate.month==timeNow.month &&
        currentSaleDate.day==timeNow.day
      ) {

        salesToday[sale.productId] ??= {
          'quantity': 0,
          'revenue': 0,
        };

        salesToday[sale.productId]!['quantity'] = (salesToday[sale.productId]!['quantity'] ?? 0) + sale.quantity;
        salesToday[sale.productId]!['revenue'] = (salesToday[sale.productId]!['revenue'] ?? 0) + (sale.unitPrice * sale.quantity);
      }

    }

    return salesToday;
  }

  

  getTopRevenue() async {
    Map map = await getSales();
    List entries = map.entries.toList();

    // Sort descending by quantity
    entries.sort((a, b) => (b.value['revenue'] as num).compareTo(a.value['revenue'] as num));

    List topThreeList = entries.take(1).toList();

    return topThreeList[0];
  } 

  Future<List<Container>> getBestContainers() async {
    List<Container> containers = [];
    var topProductRevenue = await getTopRevenue();

    print(topProductRevenue.entry);
    print(topProductRevenue.runtimeType);

    return containers;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: FirebaseDatabase.instance.ref("sales").onValue,
      builder: (context, snapshot) {
        return FutureBuilder<List<Widget>>(
          future: getBestContainers(),
          builder: (context, containerSnapshot) {
            if (containerSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (containerSnapshot.hasError) {
              return Text('Error: ${containerSnapshot.error}');
            }

            return Center(
              child: Container(
                width: 350, height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (containerSnapshot.data == null || containerSnapshot.data!.isEmpty) ? [Text("No sales today.")] : containerSnapshot.data!,
                )
              )
            );
          },
        );
      }
    );
  }
}