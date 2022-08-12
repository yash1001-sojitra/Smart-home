// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison, avoid_returning_null_for_void, unrelated_type_equality_checks, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/Core/Constant/string.dart';
import 'package:smarthome/Screens/User/Drawer/DrawerScreens/profile.dart';
import '../../../../Logic/Modules/userData_model.dart';
import '../../../../Logic/Services/auth_services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Drawer/drawer.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class HomeDash extends StatefulWidget {
  const HomeDash({Key? key}) : super(key: key);

  @override
  State<HomeDash> createState() => _HomeDashState();
}

class _HomeDashState extends State<HomeDash> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    User user = authService.getcurrentUser();
    List<UserData> userDataList = [];
    final userDataListRaw = Provider.of<List<UserData>?>(context);
    userDataListRaw?.forEach((element) {
      if (user.uid == element.id) {
        userDataList.add(element);
      } else {
        return null;
      }
    });

    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Good Morning';
      }
      if (hour < 17) {
        return 'Good Afternoon';
      }
      return 'Good Evening';
    }

    List roomimage = [
      "livingroommain.png",
      "bedroommain.png",
      "kitchenmain.png"
    ];
    List roomname = ["Living Room", "Bed Room", "Kitchen"];

    List roomnavigation = [
      livingroomScreenRoute,
      bedroomScreenRoute,
      kitchenScreenRoute
    ];

    return Scaffold(
      backgroundColor: Colors.white30,
      drawer: const MyDrawer(),
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyProfilePage(),
              ),
            );
          }),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: WidgetCircularAnimator(
              innerColor: Colors.blue,
              singleRing: true,
              size: 55,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  backgroundImage: userDataList == 0
                      ? const NetworkImage(
                          "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png")
                      : NetworkImage(userDataList.first.userimage),
                  radius: 70,
                ),
              ),
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
                  onPressed: () {},
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Hello, ", style: TextStyle(fontSize: 25)),
                Text(
                  "${userDataList.first.Name}!",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "${greeting()}, ",
                  style: const TextStyle(color: Colors.grey),
                ),
                const Text(
                  "Welcome back.",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, roomnavigation[index]);
                      },
                      child: RoomsListViewModel(
                        roomimage: roomimage[index],
                        roomname: roomname[index],
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomsListViewModel extends StatefulWidget {
  String roomimage;
  String roomname;
  RoomsListViewModel(
      {required this.roomimage, required this.roomname, Key? key})
      : super(key: key);

  @override
  State<RoomsListViewModel> createState() => _RoomsListViewModelState();
}

class _RoomsListViewModelState extends State<RoomsListViewModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/${widget.roomimage}",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.5), Colors.black12]),
            ),
          ),
        ),
        Positioned(
          bottom: 18,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.roomname,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      Shadow(
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Colors.white.withOpacity(0.30),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  "4 Devices",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 1.0,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      Shadow(
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 1.0,
                        color: Colors.white.withOpacity(0.30),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
