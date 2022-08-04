// ignore_for_file: must_be_immutable, depend_on_referenced_packages, avoid_returning_null_for_void, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/Core/Constant/string.dart';
import '../../../../Logic/Modules/userData_model.dart';
import '../../../../Logic/Providers/sign_in_provider.dart';
import '../../../../Logic/Services/auth_services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import '../../Drawer/drawer.dart';

class UserDash extends StatefulWidget {
  const UserDash({Key? key}) : super(key: key);

  @override
  State<UserDash> createState() => _UserDashState();
}

class _UserDashState extends State<UserDash> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context);
    // User user = authService.getcurrentUser();
    // List<UserData> userDataList = [];
    // final userDataListRaw = Provider.of<List<UserData>?>(context);
    // userDataListRaw?.forEach((element) {
    //   if (user.uid == element.id) {
    //     userDataList.add(element);
    //   } else {
    //     return null;
    //   }
    // });
    final sp = context.watch<SignInProvider>();
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
          child: WidgetCircularAnimator(
            innerColor: Colors.blue,
            singleRing: true,
            size: 55,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                backgroundImage: NetworkImage("${sp.imageUrl}"),
                radius: 70,
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
              children: const [
                Text(
                  "Total ${1} active user. ",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 380,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return UserListModel(
                    name: "${sp.name}",
                    src: "${sp.imageUrl}",
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

class UserListModel extends StatelessWidget {
  UserListModel({required this.name, required this.src, Key? key})
      : super(key: key);
  String src;
  String name;
  @override
  Widget build(BuildContext context) {
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
                        image: NetworkImage(src),
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
                    name,
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
                    onTap: () {},
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
