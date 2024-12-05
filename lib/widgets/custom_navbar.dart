import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:simple_remainder_app/constants/colors_constants.dart';
import 'package:simple_remainder_app/constants/text_constants.dart';

class CustomNavBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const CustomNavBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: ColorsConstants.bottomNavBgColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: ColorsConstants.greyColor,
      selectedLabelStyle: Theme.of(context).textTheme.titleMedium,
      unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
      unselectedIconTheme: const IconThemeData(size: 25),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Symbols.pending_rounded),
          label: TextConstants.bottomNavBarLabel1,
        ),
        BottomNavigationBarItem(
          icon: Icon(Symbols.check_circle_rounded),
          label: TextConstants.bottomNavBarLabel2,
        ),
      ],
    );
  }
}
