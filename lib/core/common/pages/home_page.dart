import 'package:blog_app/features/blog/presentation/pages/blog/blog_page.dart';
import 'package:blog_app/features/profile/presentation/pages/profile_page.dart';
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
    List<BottomNavigationBarItem> listOfBottomNavigationBarItem = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.note),
        label: 'Blogs',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (value) {
            setState(() => _selectedPageIndex = value);
          },
          children: const [BlogPage(), ProfilePage()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _openPage,
          items: listOfBottomNavigationBarItem),
    );
  }

  void _openPage(int index) {
    setState(() => _selectedPageIndex = index);
    _pageController.jumpToPage(index);
  }
}
