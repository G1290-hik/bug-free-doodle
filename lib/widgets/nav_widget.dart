import 'package:flutter/material.dart';

class NavWidget extends StatelessWidget {
  const NavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    Widget getNavigationWidget() {
      if (screenWidth < 600) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: 0,
          onTap: (index) {
            // Handle navigation tap
          },
        );
      } else {
        return NavigationRail(
          selectedIndex: 0,
          onDestinationSelected: (index) {
            // Handle navigation tap
          },
          labelType: NavigationRailLabelType.all,
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.person),
              label: Text('Profile'),
            ),
          ],
        );
      }
    }

    return getNavigationWidget();
  }
}
