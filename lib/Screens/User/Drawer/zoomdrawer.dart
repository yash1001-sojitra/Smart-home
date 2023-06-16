// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:flutter_zoom_drawer/config.dart';
import 'package:smarthome/Screens/User/Drawer/drawer.dart';
import 'package:smarthome/Screens/User/Homepage/Bottom_Bar/home.dart';

class Zoomdrawer extends StatefulWidget {
  const Zoomdrawer({Key? key}) : super(key: key);

  @override
  State<Zoomdrawer> createState() => _ZoomdrawerState();
}

class _ZoomdrawerState extends State<Zoomdrawer> {
  final drawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: drawerController,
        style: DrawerStyle.style1,
        menuScreen: const MyDrawer(),
        mainScreen: const HomeDash(),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        menuBackgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width * (0.65),
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      ),
    );
  }
}
