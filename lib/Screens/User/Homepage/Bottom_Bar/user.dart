// ignore_for_file: must_be_immutable, depend_on_referenced_packages, avoid_returning_null_for_void, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/Core/Constant/string.dart';
import 'package:smarthome/Logic/Providers/userData_provider.dart';
import '../../../../Logic/Modules/userData_model.dart';
import '../../../../Logic/Services/auth_services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import '../../Drawer/DrawerScreens/profile.dart';
import '../../Drawer/drawer.dart';

class UserDash extends StatefulWidget {
  const UserDash({Key? key}) : super(key: key);

  @override
  State<UserDash> createState() => _UserDashState();
}

class _UserDashState extends State<UserDash> {
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
    List otheruserdata = [];

    for (var i = 0; i < userDataList.first.otheruser.length; i++) {
      otheruserdata.add(userDataList.first.otheruser[i].toString());
    }

    // print("otheruserdata " + "${otheruserdata.toList()}");
    List<String> userdataName = [];
    List<String> userdataImage = [];
    checkUserdataExists(List<String> username, List<String> userimage) async {
      for (var i = 0; i < otheruserdata.length; i++) {
        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection('User')
            .doc(otheruserdata.elementAt(i))
            .get();

        username.add(snap.get('Name'));
        userimage.add(snap.get('UserImage'));

        // print(snap.data().toString());
      }
    }

    checkUserdataExists(userdataName, userdataImage);
    // print(userdataName.toList());

    return Scaffold(
      backgroundColor: Colors.white30,
      drawer: const MyDrawer(),
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyProfilePage(),
                ),
              );
            },
            child: WidgetCircularAnimator(
              innerColor: Colors.blue,
              singleRing: true,
              size: 55,
              child: CircleAvatar(
                radius: 10,
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
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Image.asset(
                    "assets/images/menu.png",
                    height: 30,
                    width: 35,
                    color: Colors.black,
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
              children: const [
                Text("All, ", style: TextStyle(fontSize: 25)),
                Text(
                  "Users",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Total ${userdataName.length} active user.",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 380,
              child: ListView.builder(
                itemCount: userdataName.length,
                itemBuilder: (BuildContext context, int index) {
                  return UserListModel(
                    name: userdataName[index],
                    src: userdataImage[index],
                    otheruserid: otheruserdata[index],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AdduserProfileScreenRoute);
              },
              child: Center(
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff339DFA),
                          Color(0xff0367CC),
                        ],
                        stops: [0.0, 1.0],
                        begin: FractionalOffset.centerLeft,
                        end: FractionalOffset.centerRight,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "ADD USER",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserListModel extends StatefulWidget {
  UserListModel(
      {required this.name,
      required this.src,
      required this.otheruserid,
      Key? key})
      : super(key: key);
  String name;
  String src;
  String otheruserid;

  @override
  State<UserListModel> createState() => _UserListModelState();
}

class _UserListModelState extends State<UserListModel> {
  get otheruserid => null;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    User user = authService.getcurrentUser();
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(widget.src),
                      )),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Active user",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      UsereDataProvider()
                          .removeotheruser(user.uid, otheruserid);
                    },
                    child: const Text(
                      "Remove",
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
