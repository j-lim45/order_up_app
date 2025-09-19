import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onClicked;

  const BottomNavBar({super.key, required this.currentIndex, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          currentIndex: currentIndex,
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
          selectedItemColor: Colors.amber[800],
          onTap: onClicked,
        );
  }
}

