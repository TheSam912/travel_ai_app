import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_ai_app/constant/colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade900,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/travel.png",
                color: navigationShell.currentIndex == 0
                    ? AppColor().primaryColor
                    : Colors.grey.shade600,
                width: 30,
                height: 30,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/cards.png",
                color: navigationShell.currentIndex == 1
                    ? AppColor().primaryColor
                    : Colors.grey.shade600,
                width: 28,
                height: 28,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/profile.png",
                color: navigationShell.currentIndex == 2
                    ? AppColor().primaryColor
                    : Colors.grey.shade600,
                width: 28,
                height: 28,
              ),
              label: ''),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
