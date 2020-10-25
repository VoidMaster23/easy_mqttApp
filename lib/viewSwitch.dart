import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:toggle_switch/toggle_switch.dart';

import 'dbStuff.dart';
import 'models/switches.dart';

class SwitchData extends StatefulWidget {
  final List switches;

  SwitchData({this.switches});

  @override
  _SwitchDataState createState() => _SwitchDataState();
}

class _SwitchDataState extends State<SwitchData> {
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
                    itemCount: widget.switches.length,
                    itemBuilder: (context, index) {
                      Switches switchS = widget.switches[index];

                      return ListTile(
                        title: Card(
                          child: SwitchTile(
                            deviceName: switchS.deviceName,
                            status: switchS.status,
                            pinNumber: switchS.pinNumber,
                            commandIssued: switchS.commandIssued,
                            lastModified: switchS.lastModified,
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

class SwitchTile extends StatefulWidget {
  final String deviceName;
  final bool status;
  final int pinNumber;
  final String commandIssued;
  final String lastModified;

  SwitchTile(
      {this.deviceName,
      this.status,
      this.pinNumber,
      this.commandIssued,
      this.lastModified});

  @override
  _SwitchTileState createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  String deviceName;
  bool status;
  int pinNumber;
  String commandIssued;
  String lastModified;
  bool confirmVisible = false;
  @override
  void initState() {
    super.initState();
    deviceName = widget.deviceName;
    status = widget.status;
    pinNumber = widget.pinNumber;
    commandIssued = widget.commandIssued;
    lastModified = widget.lastModified;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Switch at ${deviceName}, pin ${pinNumber.toString()}",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              )),
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
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ToggleSwitch(
                minWidth: 60.0,
                minHeight: 25.0,
                initialLabelIndex: status ? 1 : 0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                labels: ['off', 'on'],
                icons: [Icons.power, Icons.power_off],
                activeBgColors: [Colors.blue, Colors.blue],
                onToggle: (index) {
                  setState(() {
                    status = !status;
                    confirmVisible = true;
                  });
                },
              ),
              Visibility(
                visible: confirmVisible,
                child: ButtonTheme(
                  minWidth: 60.0,
                  height: 25.0,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text("Confirm"),
                    onPressed: () async {
                      await http
                          .put(
                              "${dbStuff.url}/switches/update/$deviceName/${pinNumber.toString()}",
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, dynamic>{
                                'Status': status,
                                'CommandIssued': commandIssued
                              }))
                          .then((response) {
                        if (response.statusCode == 200) {
                          Fluttertoast.showToast(
                              msg: "Successfully updated the record",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);

                          var jsonArr = jsonDecode(response.body)['result'];
                          print(jsonArr);
                          Switches sw = Switches.fromJson(jsonArr);
                          setState(() {
                            deviceName = sw.deviceName;
                            status = sw.status;
                            pinNumber = sw.pinNumber;
                            commandIssued = sw.commandIssued;
                            lastModified = sw.lastModified;
                          });
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
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
