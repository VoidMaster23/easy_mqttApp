///Class that defines the structure for sensors
class Sensors {
  final String deviceName;
  final double lastRecordedValue;
  final int pinNumber;
  final String commandIssued;
  final String lastModified;

  Sensors(
      {this.deviceName,
      this.lastRecordedValue,
      this.pinNumber,
      this.commandIssued,
      this.lastModified});

  // static Resource<List<Sensors>> get all {
  //   return Resource(parse: (response) {
  //     final result = json.decode(response.body);
  //     Iterable list = result['articles'];
  //     return list.map((model) => Sensors.fromJson(model)).toList();
  //   });
  // }
  ///Funcrtion to create a sensor object from JSON data
  factory Sensors.fromJson(Map<String, dynamic> json) {
    return Sensors(
        deviceName: json['DeviceName'] as String,
        lastRecordedValue: json["LastRecordedValue"] as double,
        pinNumber: json["PinNumber"] as int,
        commandIssued: json['CommandIssued'] as String,
        lastModified: json['LastModified'] as String);
  }
}
