import 'dart:convert';

import 'package:easy_mqtt/main.dart';

///Class that defines the structure for history objects
class History {
  final String deviceName;
  final bool status;
  final int pinNumber;
  final double lastRecordedValue;
  final String commandIssued;
  final String issueTime;

  History(
      {this.deviceName,
      this.status,
      this.pinNumber,
      this.commandIssued,
      this.lastRecordedValue,
      this.issueTime});

  static Resource<List<History>> get all {
    return Resource(parse: (response) {
      final result = json.decode(response.body);
      Iterable list = result['articles'];
      return list.map((model) => History.fromJson(model)).toList();
    });
  }

  ///Funcrtion to create a history object from JSON data
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
        deviceName: json['DeviceName'] as String,
        status: json["Status"] as bool,
        lastRecordedValue: json["LastRecordedValue"] as double,
        pinNumber: json["PinNumber"] as int,
        commandIssued: json['CommandIssued'] as String,
        issueTime: json['IssueTime'] as String);
  }
}
