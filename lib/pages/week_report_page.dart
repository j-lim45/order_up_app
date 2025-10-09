import 'package:flutter/material.dart';
import 'package:order_up_app/components/app_colors.dart';
import 'package:order_up_app/backend/sale_class.dart';

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
      body: Text("Report")
    );
  }
}

class SalesTable extends StatelessWidget {
  final List<Sale> theList;

  const SalesTable({super.key, required this.theList});
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [DataColumn(label: Text("Product")), DataColumn(label: Text("Date")), DataColumn(label: Text("Quantity"))],
      rows: [],
    );
  }
}
