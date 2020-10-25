import 'package:flutter/material.dart';

import 'models/sensors.dart';

class SensorData extends StatefulWidget {
  final List sensors;

  SensorData({this.sensors});

  @override
  _SensorDataState createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
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
                    itemCount: widget.sensors.length,
                    itemBuilder: (context, index) {
                      Sensors sensor = widget.sensors[index];

                      return ListTile(
                        title: Card(
                          child: SensorTile(
                            deviceName: sensor.deviceName,
                            lastRecordedValue: sensor.lastRecordedValue,
                            pinNumber: sensor.pinNumber,
                            commandIssued: sensor.commandIssued,
                            lastModified: sensor.lastModified,
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

class SensorTile extends StatelessWidget {
  final String deviceName;
  final double lastRecordedValue;
  final int pinNumber;
  final String commandIssued;
  final String lastModified;

  SensorTile(
      {this.deviceName,
      this.lastRecordedValue,
      this.pinNumber,
      this.commandIssued,
      this.lastModified});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sensor at $deviceName, pin ${pinNumber.toString()}",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              )),
          Text(
            "Last Recorded Value: ${lastRecordedValue.toString()}",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          Text(
            "Command Issued: ${commandIssued}",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          Text(
            "Last Modified: ${lastModified}",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
