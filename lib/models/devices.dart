class Devices {
  final String deviceName;
  final String createdAt;

  Devices({this.deviceName, this.createdAt});

  factory Devices.fromJson(Map<String, dynamic> json) {
    return Devices(
        deviceName: json['DeviceName'] as String,
        createdAt: json['CreatedAt'] as String);
  }
}
