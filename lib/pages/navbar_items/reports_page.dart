import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../backend/database_service.dart';
import 'package:order_up_app/pages/navbar_items/home_page.dart';
import 'package:order_up_app/components/bottom_nav_bar.dart';
import 'package:order_up_app/components/reports/reports_column.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPage();
}

class _ReportsPage extends State<ReportsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeeklyReportsColumn()
    );
  }
}
