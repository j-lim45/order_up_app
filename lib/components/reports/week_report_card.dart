import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../backend/database_service.dart';
import 'package:order_up_app/pages/navbar_items/home_page.dart';
import 'package:order_up_app/components/misc/bottom_nav_bar.dart';
import 'package:order_up_app/pages/week_report_page.dart';
import 'package:order_up_app/backend/sale_class.dart';

class WeekReportCard extends StatefulWidget {
  final List<Sale> theList;
  final DateTime startDateWeek;

  const WeekReportCard({super.key, required this.theList, required this.startDateWeek});

  @override
  State<WeekReportCard> createState() => _WeekReportCard();
}

class _WeekReportCard extends State<WeekReportCard> {

  @override
  Widget build(BuildContext context) {

    DateTime endRange = widget.startDateWeek.add(Duration(days: 6));
    String startDate = "${widget.startDateWeek.year}-${widget.startDateWeek.month.toString().padLeft(2, '0')}-${widget.startDateWeek.day.toString().padLeft(2, '0')}";
    String endDate = "${endRange.year}-${endRange.month.toString().padLeft(2, '0')}-${endRange.day.toString().padLeft(2, '0')}";

    return InkWell(onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => 
        WeekReportPage(
          theList: widget.theList, 
          startDateWeek: widget.startDateWeek)
        )
      );
    },
      child: Container(
        
        width: 380,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(borderRadius:BorderRadius.circular(8), color: Colors.white),
        child: Center(child: Text('$startDate -> $endDate', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),))
      ),
      );
  }
}