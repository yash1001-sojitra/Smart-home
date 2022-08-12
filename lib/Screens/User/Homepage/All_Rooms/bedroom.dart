// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:smarthome/Screens/User/Device_Adding/add_device.dart';
import 'package:smarthome/Screens/User/models/ac_view_model.dart';
import 'package:smarthome/Screens/User/models/devices_model.dart';
import 'package:smarthome/Screens/User/models/light_view_model.dart';
import 'package:smarthome/Screens/User/models/music_view_model.dart';
import 'package:smarthome/Screens/User/models/security_view_model.dart';
import 'package:smarthome/Screens/User/models/voicedevice_view_model.dart';
import 'package:smarthome/Screens/User/models/wifi_veiw_model.dart';

class BedRoom extends StatefulWidget {
  const BedRoom({Key? key}) : super(key: key);

  @override
  State<BedRoom> createState() => _BedRoomState();
}

class _BedRoomState extends State<BedRoom> {
  @override
  Widget build(BuildContext context) {
    List imageurl = [
      "light.png",
      "music.png",
      "security.png",
      "acmodel.png",
      "wifi.png",
      "siri.png"
    ];
    List viewModel = [
      const LightViewModel(),
      const MusicViewModel(),
      const SecurityViewModel(),
      const AcViewModel(),
      const Wifi_view_model(),
      const Siri_View_Model()
    ];

    int selectedIndex = 0;
    _onSelected(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      drawerEnableOpenDragGesture: true,
      backgroundColor: Colors.white,
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
                  Text("Bed, ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                  Text(
                    "Room",
                    style: TextStyle(fontSize: 25),
                  )
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
                  itemCount: imageurl.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        print(index);
                        _onSelected(index);
                        setState(() {
                          // selectedIndex = index;
                          index == selectedIndex;
                        });
                      },
                      child: AddDevicesModel(
                        color:
                            selectedIndex == index ? Colors.blue : Colors.white,
                        imageurl: imageurl[index],
                      ),
                    );
                  },
                ),
              ),
              viewModel[selectedIndex],
              // const MusicViewModel()
            ],
          ),
        ),
      ),
    );
  }
}
