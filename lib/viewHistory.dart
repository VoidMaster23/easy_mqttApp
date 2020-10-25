import 'package:flutter/material.dart';

import 'models/history.dart';

class HistoryData extends StatefulWidget {
  final List history;

  HistoryData({this.history});

  @override
  _HistoryDataState createState() => _HistoryDataState();
}

class _HistoryDataState extends State<HistoryData> {
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
                    itemCount: widget.history.length,
                    itemBuilder: (context, index) {
                      History hist = widget.history[index];

                      return ListTile(
                        title: Card(
                          child: HistoryTile(
                              deviceName: hist.deviceName,
                              lastRecordedValue: hist.lastRecordedValue,
                              pinNumber: hist.pinNumber,
                              commandIssued: hist.commandIssued,
                              issueTime: hist.issueTime,
                              status: hist.status),
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

class HistoryTile extends StatelessWidget {
  final String deviceName;
  final double lastRecordedValue;
  final int pinNumber;
  final String commandIssued;
  final String issueTime;
  final bool status;

  HistoryTile(
      {this.deviceName,
      this.lastRecordedValue,
      this.pinNumber,
      this.commandIssued,
      this.status,
      this.issueTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("History at $deviceName, pin ${pinNumber.toString()}",
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
            "Status: ${status ? "on" : "off"}",
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
            "Issue Time: ${issueTime}",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
