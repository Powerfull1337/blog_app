
import 'package:blog_app/features/profile/presentation/pages/profile_page.dart';
import 'package:blog_app/features/profile/presentation/pages/recomendations_users_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedPageIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() => _selectedPageIndex = value);
            },
            children: const [
              RecomendationsUsersPage(),
              ProfilePage(),
            ],
          ),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedPageIndex,
          onTap: _openPage,
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          items: [
            SalomonBottomBarItem(
              icon: const FaIcon(FontAwesomeIcons.newspaper),
              title: const Text('Recomendations'),
              selectedColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              unselectedColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
            ),
            SalomonBottomBarItem(
              icon: const FaIcon(FontAwesomeIcons.user),
              title: const Text('Profile'),
              selectedColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              unselectedColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
            ),
          ],
        ));
  }

  void _openPage(int index) {
    setState(() => _selectedPageIndex = index);
    _pageController.jumpToPage(index);
  }
}
