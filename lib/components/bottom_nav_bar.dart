import 'package:flutter/material.dart';
import 'package:order_up_app/components/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onClicked;

  const BottomNavBar({super.key, required this.currentIndex, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: AppColors.maroonColor,
          unselectedItemColor: AppColors.unselectedItem,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home), 
              label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              label: "Stock",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.content_paste),
              label: "Reports",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), 
              label: "Menu"
            ),
          ],
          onTap: onClicked,
          showUnselectedLabels: true,
        );
  }
}

