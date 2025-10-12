import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:order_up_app/components/misc/app_colors.dart';
import 'package:order_up_app/backend/product_class.dart';
import 'package:order_up_app/backend/sale_class.dart';
import 'package:order_up_app/components/reports/week_report_card.dart';


class WeeklyReportsColumn extends StatelessWidget {

  const WeeklyReportsColumn({super.key});

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

        Map months = {
          '1': "Jan",
          '2': "Feb",
          '3': "Mar",
          '4': "Apr",
          '5': "May",
          '6': "Jun",
          '7': "Jul",
          '8': "Aug",
          '9': "Sep",
          '10': "Oct",
          '11': "Nov",
          '12': "Dec",
        };
        List<WeekReportCard> container = [];
        for (var i in salesWeekDivision.entries) {
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