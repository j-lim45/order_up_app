import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:order_up_app/components/app_colors.dart';
import 'package:order_up_app/backend/product_class.dart';
import 'package:order_up_app/backend/sale_class.dart';
import 'package:order_up_app/components/week_report_card.dart';


class SaleTable extends StatelessWidget {

  const SaleTable({super.key});

  Future<List<Widget>> getList() async {
    List<Widget> test = [];


    return test;
  }
  
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<DatabaseEvent>(
      stream: FirebaseDatabase.instance.ref("sales").onValue, 
      builder: (context, snapshot) {                                 
        if (snapshot.connectionState == ConnectionState.waiting) { 
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {                              
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData) {                                    
          return Center(child: Text("No sales available"));
        }

        final salesMap = snapshot.data!.snapshot.value as Map<Object?, Object?>;

        final List<Sale> salesList = [];
        for (var sale in salesMap.entries) {

          final saleValue = sale.value as Map?;
          salesList.add(Sale(
            saleId: sale.key.toString(),
            productId: (saleValue?['product_id'].toString())!,
            quantity: int.parse((saleValue?['quantity'].toString())!),
            dateTime: DateTime.fromMillisecondsSinceEpoch(int.parse((saleValue?['timestamp'].toString())!)),
            unitPrice: double.parse((saleValue?['unitPrice'].toString())!)
          ));
        }

        Map<DateTime, List<Sale>> salesWeekDivision = {};
        for (Sale sale in salesList) {
          DateTime mondayOfWeek = sale.dateTime.subtract(Duration(days: sale.dateTime.weekday - 1));
          mondayOfWeek = DateTime(
            mondayOfWeek.year,
            mondayOfWeek.month,
            mondayOfWeek.day,
            0,
            0,
            0,
            0,
          );

          (salesWeekDivision[mondayOfWeek] ??= []).add(sale); 
        }

        List<WeekReportCard> container = [];
        for (var i in salesWeekDivision.entries) {
          DateTime endRange = i.key.add(Duration(days: 6));
          String startDate = "${i.key.year}-${i.key.month.toString().padLeft(2, '0')}-${i.key.day.toString().padLeft(2, '0')}";
          String endDate = "${endRange.year}-${endRange.month.toString().padLeft(2, '0')}-${endRange.day.toString().padLeft(2, '0')}";

          container.insert(0,
            WeekReportCard(theList: i.value, startDateWeek: i.key)
          );
        }

        return Column(
          children: container
        );
      },
    );
  }
}