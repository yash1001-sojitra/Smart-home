// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:smarthome/Screens/User/models/devices_model.dart';
import '../../../Logic/Modules/userData_model.dart';
import '../../../Logic/Services/auth_services/auth_service.dart';
import '../Drawer/drawer.dart';

class AddDevices extends StatefulWidget {
  const AddDevices({Key? key}) : super(key: key);

  @override
  State<AddDevices> createState() => _AddDevicesState();
}

class _AddDevicesState extends State<AddDevices> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    User user = authService.getcurrentUser();
    List<UserData> userDataList = [];
    final userDataListRaw = Provider.of<List<UserData>?>(context);
    userDataListRaw?.forEach((element) {
      if (user.uid == element.id) {
        userDataList.add(element);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MyDrawer(),
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userDataList.first.userimage),
              radius: 70,
            ),
          ),
        ),
        elevation: 0,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Image.asset(
                    "assets/images/menu.png",
                    height: 30,
                    width: 30,
                  ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: const [
                Text("Active ", style: TextStyle(fontSize: 25)),
                Text(
                  "Device",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                Text(
                  "Total 6 active devices.",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              // height: 170,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        _modalBottomSheetMenu();
                      },
                      child: const DevicesModel());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        context: context,
        builder: (builder) {
          return Stack(children: [
            Container(
                height: 350.0,
                color: const Color(0xFF737373),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff255ED6),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0))),
                  child: Column(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 31,
                      height: 6,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: const Text("Search Nearby Devices…",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                        child: RippleAnimation(
                            repeat: true,
                            color: Colors.white,
                            minRadius: 60,
                            ripplesCount: 10,
                            child: Container()))
                  ]),
                )),
          ]);
        });
  }
}
