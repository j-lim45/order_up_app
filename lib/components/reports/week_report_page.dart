import 'package:flutter/material.dart';
import 'package:order_up_app/components/misc/app_colors.dart';
import 'package:order_up_app/backend/sale_class.dart';
import 'package:order_up_app/components/reports/sales_table.dart';



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
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SalesTable(theList: theList),
        )
      )
    );
  }
}