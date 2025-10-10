import 'package:flutter/material.dart';
import 'package:order_up_app/components/misc/app_colors.dart';
import 'package:order_up_app/backend/sale_class.dart';
import 'package:order_up_app/components/reports/sales_table.dart';
import 'package:order_up_app/components/reports/category_sales_table.dart';
import 'package:order_up_app/components/reports/best_seller_table.dart';



class WeekReportPage extends StatelessWidget {
  final List<Sale> theList;
  final DateTime startDateWeek;

  const WeekReportPage({super.key, required this.theList, required this.startDateWeek});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.maroonColor, foregroundColor: AppColors.whiteColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text('Category Sales Breakdown'),
            SingleChildScrollView(scrollDirection: Axis.horizontal, child: CategorySalesTable(theList: theList)),
            Text('Best Sellers'),
            SingleChildScrollView(scrollDirection: Axis.horizontal, child: BestSellerTable(theList: theList)),
            Text('All Week Sales'),
            SingleChildScrollView(scrollDirection: Axis.horizontal, child: SalesTable(theList: theList))
          ],
        )
      )
    );
  }
}