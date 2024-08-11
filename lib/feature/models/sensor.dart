import '/feature/models/device_namespace.dart';

class Sensor {
  final String sensorId;
  final String tenantId;
  final String name;
  final int sensorMake;
  final DateTime createdAt;
  final String deviceId;
  final String deviceNamespaceId;
  final DeviceNamespace deviceNamespace;
  final List<dynamic>? modalities;
  final List<dynamic>? rules;

  Sensor({
    required this.sensorId,
    required this.tenantId,
    required this.name,
    required this.sensorMake,
    required this.createdAt,
    required this.deviceId,
    required this.deviceNamespaceId,
    required this.deviceNamespace,
    required this.modalities,
    required this.rules,
  });

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      sensorId: json['sensorId'],
      tenantId: json['tenantId'],
      name: json['name'],
      sensorMake: json['sensorMake'],
      createdAt: DateTime.parse(json['createdAt']),
      deviceId: json['deviceId'],
      deviceNamespaceId: json['deviceNamespaceId'],
      deviceNamespace: DeviceNamespace.fromJson(json['deviceNamespace']),
      modalities: json['modalities'] ?? [],
      rules: json['rules'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sensorId': sensorId,
      'tenantId': tenantId,
      'name': name,
      'sensorMake': sensorMake,
      'createdAt': createdAt.toIso8601String(),
      'deviceId': deviceId,
      'deviceNamespaceId': deviceNamespaceId,
      'deviceNamespace': deviceNamespace.toJson(),
      'modalities': modalities,
      'rules': rules,
    };
  }
}

class SensorData {
  final String id;
  final String partitionKey;
  final String mi;
  final List<double> d;
  final int ts;
  final DateTime receivedAt;

  SensorData({
    required this.id,
    required this.partitionKey,
    required this.mi,
    required this.d,
    required this.ts,
    required this.receivedAt,
  });

  // Factory constructor to create a SensorData instance from JSON
  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      id: json['id'] as String,
      partitionKey: json['partitionKey'] as String,
      mi: json['MI'] as String,
      d: List<double>.from(json['D'].map((x) => x.toDouble())),
      ts: json['TS'] as int,
      receivedAt: DateTime.parse(json['receivedAt'] as String),
    );
  }

  // Method to convert SensorData instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partitionKey': partitionKey,
      'MI': mi,
      'D': d,
      'TS': ts,
      'receivedAt': receivedAt.toIso8601String(),
    };
  }
}

//  {dashboardId: 1, name: Dashboard 1, layoutId: 1, layout: {layoutId: 1, name: Single Widget, numOfWidgets: 1, isDefault: true, dashboards: [null]}, widgets: [{widgetId: 1, name: line chart, type: 2, graphParameters: {}, dashboardId: 1, modalities: [{modalityId: 3debe2e0-8d5d-4f92-87b5-08dc5533dbcb, tenantId: tinkerblox, name: Demo_Sensor_01_Pressure, type: 1, sensorId: 103b7c99-4bbd-4dc7-ab00-24760a15d6ae, widgets: [null]}, {modalityId: bbd4f80d-50ca-4cd6-87b6-08dc5533dbcb, tenantId: tinkerblox, name: Demo_Sensor_01_Temperature, type: 0, sensorId: 103b7c99-4bbd-4dc7-ab00-24760a15d6ae, widgets: [null]}]}], devices: []}