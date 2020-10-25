import 'dart:convert';

import 'package:easy_mqtt/main.dart';

class Switches {
  final String deviceName;
  final bool status;
  final int pinNumber;
  final String commandIssued;
  final String lastModified;

  Switches(
      {this.deviceName,
      this.status,
      this.pinNumber,
      this.commandIssued,
      this.lastModified});

  static Resource<List<Switches>> get all {
    return Resource(parse: (response) {
      final result = json.decode(response.body);
      Iterable list = result['articles'];
      return list.map((model) => Switches.fromJson(model)).toList();
    });
  }

  factory Switches.fromJson(Map<String, dynamic> json) {
    return Switches(
        deviceName: json['DeviceName'] as String,
        status: json["Status"] as bool,
        pinNumber: json["PinNumber"] as int,
        commandIssued: json['CommandIssued'] as String,
        lastModified: json['LastModified'] as String);
  }
}
