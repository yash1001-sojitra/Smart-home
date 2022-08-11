// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:smarthome/Screens/User/Device_Adding/add_device.dart';
import 'package:smarthome/Screens/User/models/ac_view_model.dart';
import 'package:smarthome/Screens/User/models/devices_model.dart';

class Kitchen extends StatefulWidget {
  const Kitchen({Key? key}) : super(key: key);

  @override
  State<Kitchen> createState() => _KitchenState();
}

class _KitchenState extends State<Kitchen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddDevices())),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                children: const [
                  Text("Kitchen",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(children: const [
                Text(
                  "Total 4 Active Devices.",
                  style: TextStyle(color: Colors.grey),
                ),
              ]),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return  DevicesModel();
                  },
                ),
              ),
              const AcViewModel(),
            ],
          ),
        ),
      ),
    );
  }
}
