import 'package:flutter/material.dart';

import 'models/devices.dart';

class DeviceData extends StatefulWidget {
  final List devices;

  DeviceData({this.devices});

  @override
  _DeviceDataState createState() => _DeviceDataState();
}

class _DeviceDataState extends State<DeviceData> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: "logo",
                child: Image.asset(
                  "images/logo_dark_screen.png",
                  scale: 1.1,
                ),
              ),
              Flexible(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.devices.length,
                    itemBuilder: (context, index) {
                      Devices device = widget.devices[index];

                      return ListTile(
                        title: Card(
                          child: DeviceTile(
                            deviceName: device.deviceName,
                            createdAt: device.createdAt,
                          ),
                          elevation: 10,
                          color: Colors.white,
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class DeviceTile extends StatelessWidget {
  final String deviceName;
  final String createdAt;

  DeviceTile({this.deviceName, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Device $deviceName",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              )),
          Text(
            "Created At: ${createdAt}",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
