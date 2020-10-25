import 'dart:convert';

import 'package:easy_mqtt/models/devices.dart';
import 'package:easy_mqtt/models/sensors.dart';
import 'package:easy_mqtt/viewDevice.dart';
import 'package:easy_mqtt/viewHistory.dart';
import 'package:easy_mqtt/viewSensor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_grid/responsive_grid.dart';
import 'package:splashscreen/splashscreen.dart';

import 'dbStuff.dart';
import 'models/history.dart';
import 'models/switches.dart';
import 'viewSwitch.dart';

void main() async {
  dbStuff.getUrl();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //splash screen
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            )),
        Expanded(
          flex: 2,
          child: SplashScreen(
              seconds: 10, // 5s load time
              navigateAfterSeconds: AfterSplash(),
              title: new Text(
                'Simplifying IoT Monitoring and Control',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
              image: Image.asset("images/logo_dark_screen.png"),
              backgroundColor: Colors.black,
              styleTextUnderTheLoader: new TextStyle(),
              photoSize: 100.0,
              onClick: () => print("Flutter Egypt"),
              loaderColor: Colors.blue),
        ),
      ],
    );
  }
}

class AfterSplash extends StatelessWidget {
  List<Switches> parseSwitches(String responseBody) {
    var jsonArr = jsonDecode(responseBody)['result'];
    return jsonArr.map<Switches>((json) => Switches.fromJson(json)).toList();
  }

  List<Sensors> parseSensors(String responseBody) {
    var jsonArr = jsonDecode(responseBody)['result'];
    return jsonArr.map<Sensors>((json) => Sensors.fromJson(json)).toList();
  }

  List<Devices> parseDevices(String responseBody) {
    var jsonArr = jsonDecode(responseBody)['result'];
    return jsonArr.map<Devices>((json) => Devices.fromJson(json)).toList();
  }

  List<History> parseHistory(String responseBody) {
    var jsonArr = jsonDecode(responseBody)['result'];
    return jsonArr.map<History>((json) => History.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: "logo",
              child: Image.asset(
                "images/logo_dark_screen.png",
                scale: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: ResponsiveGridRow(children: [
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: GridCol(
                      text: Text(
                        "Switches",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onClick: () async {
                        await http
                            .get("${dbStuff.url}/switches")
                            .then((response) async {
                          if (response.statusCode == 200) {
                            List switches = parseSwitches(response.body);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SwitchData(switches: switches)));
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Could not connect to the server, check your connection or Pi and and try again",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        });
                        //print("Clicked");
                      },
                      color: Colors.white,
                      elevation: 10,
                      icon: Icon(
                        Icons.switch_right,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: GridCol(
                      text: Text(
                        "Sensors",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onClick: () async {
                        await http
                            .get("${dbStuff.url}/sensors")
                            .then((response) {
                          if (response.statusCode == 200) {
                            List sensors = parseSensors(response.body);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SensorData(sensors: sensors)));
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Could not connect to the server, check your connection or Pi and and try again",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        });
                      },
                      color: Colors.white,
                      elevation: 10,
                      icon: Icon(
                        Icons.sensor_door,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: GridCol(
                      text: Text(
                        "Devices",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onClick: () async {
                        await http
                            .get("${dbStuff.url}/devices")
                            .then((response) {
                          if (response.statusCode == 200) {
                            List devices = parseDevices(response.body);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DeviceData(devices: devices)));
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Could not connect to the server, check your connection or Pi and and try again",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        });
                      },
                      color: Colors.white,
                      elevation: 10,
                      icon: Icon(
                        Icons.devices,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: GridCol(
                      text: Text(
                        "History",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onClick: () async {
                        await http
                            .get("${dbStuff.url}/history")
                            .then((response) {
                          if (response.statusCode == 200) {
                            List hist = parseHistory(response.body);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HistoryData(history: hist)));
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Could not connect to the server, check your connection or Pi and and try again",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        });
                      },
                      color: Colors.white,
                      elevation: 10,
                      icon: Icon(
                        Icons.history,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class GridCol extends StatelessWidget {
  final Color color;
  final double elevation;
  final Text text;
  final Function onClick;
  final Icon icon;
  GridCol({
    @required this.color,
    @required this.elevation,
    @required this.text,
    @required this.onClick,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 100,
        child: Card(
            color: color,
            elevation: elevation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [icon, text],
            )),
      ),
    );
  }
}

class Resource<T> {
  T Function(http.Response response) parse;

  Resource({this.parse});
}
