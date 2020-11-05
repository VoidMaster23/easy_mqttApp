///Class that defines the structure for devices
class Devices {
  final String deviceName;
  final String createdAt;

  Devices({this.deviceName, this.createdAt});

  ///Funcrtion to create a device object from JSON data
  factory Devices.fromJson(Map<String, dynamic> json) {
    return Devices(
        deviceName: json['DeviceName'] as String,
        createdAt: json['CreatedAt'] as String);
  }
}
