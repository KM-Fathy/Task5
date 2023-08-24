import 'package:flutter/material.dart';
import 'package:task_5/ui/screens/page1.dart';
import 'package:task_5/ui/screens/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int initialIndex = 0;

  void pageSwitch(int index) {
    setState(() {
      initialIndex = index;
    });
  }

  List<Widget> pages = [
    const Page1(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[initialIndex],
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xff300046),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xff8391a1),
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (index) {
            pageSwitch(index);
          },
          currentIndex: initialIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile')
          ],
        ),
      ),
    );
  }
}
