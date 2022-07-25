// ignore_for_file: depend_on_referenced_packages, import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bar/fancy_bar.dart';
import 'package:smarthome/Screens/User/Homepage/Bottom_Bar/home.dart';
import 'package:smarthome/Screens/User/Homepage/Bottom_Bar/lightning.dart';
import 'package:smarthome/Screens/User/Homepage/Bottom_Bar/settings.dart';
import 'package:smarthome/Screens/User/Homepage/Bottom_Bar/user.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeDash(),
    LightningDash(),
    UserDash(),
    SettingDash()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 70,
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: FancyBottomBar(
            selectedIndex: 0,
            type: FancyType.FancyV1,
            items: [
              FancyItem(
                textColor: Colors.orange,
                title: 'Home',
                icon: const Icon(Icons.home),
              ),
              FancyItem(
                textColor: Colors.red,
                title: 'Light',
                icon: const Icon(Icons.flash_on_outlined),
              ),
              FancyItem(
                textColor: Colors.green,
                title: 'User',
                icon: const Icon(CupertinoIcons.profile_circled),
              ),
              FancyItem(
                textColor: Colors.brown,
                title: 'Settings',
                icon: const Icon(Icons.settings),
              ),
            ],
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)));
  }
}
