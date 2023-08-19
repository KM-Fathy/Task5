import 'package:flutter/material.dart';
import 'package:task_5/ui/screens/page1.dart';
import 'package:task_5/ui/screens/page2.dart';
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
    const Page2(),
    const ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[initialIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xff6f6666),
        backgroundColor: const Color(0xff422b2b),
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
                Icons.add_box,
              ),
              label: 'Counter'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile')
        ],
      ),
    );
  }
}
