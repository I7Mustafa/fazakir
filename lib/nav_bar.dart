import 'package:fazakir/features/prayer_time/presentation/view/prayer_times.dart';
import 'package:flutter/material.dart';

import 'views/home/home.dart';
import 'views/quran/soura_list.dart';
import 'views/settings/settings.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;

  final screens = [
    const Home(),
    const SouraList(),
    const PrayerTime(),
    const Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: screens),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 14.0),
          ),
        ),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (currentIndex) => setState(
            () => index = currentIndex,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "فذكر",
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_rounded),
              selectedIcon: Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
              ),
              label: "القرءان",
            ),
            NavigationDestination(
              icon: Icon(Icons.mosque_outlined),
              selectedIcon: Icon(
                Icons.mosque,
                color: Colors.white,
              ),
              label: "الأذان",
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: "الأعدادات",
            ),
          ],
        ),
      ),
    );
  }
}
