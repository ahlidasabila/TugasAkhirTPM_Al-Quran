import 'package:finalproject/components/palettes.dart';
import 'package:finalproject/pages/kesanpesan.dart';
import 'package:finalproject/pages/moneyconverter.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    const Homepage(),
    const MoneyConverterPage(),
    const KesanPesanPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: Theme(
          data: ThemeData(canvasColor: Palette.mainColor),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calculate_sharp), label: 'Money Converter'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mail), label: 'Kesan Pesan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.group), label: 'Profile'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xffF9FBE7),
            unselectedItemColor: Color(0xff000000),
            onTap: _onItemTapped,
          ),
        ));
  }
}
