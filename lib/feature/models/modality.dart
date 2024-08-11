import '/feature/models/sensor.dart';

class Modality {
  final String? modalityId;
  final String? tenantId;
  final String? name;
  final int? type;
  final String? sensorId;
  final Sensor? sensor;
  final List<dynamic>? widgets;

  Modality({
    this.modalityId,
    this.tenantId,
    this.name,
    this.type,
    this.sensorId,
    this.sensor,
    this.widgets,
  });

  factory Modality.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Modality();
    }
    return Modality(
      modalityId: json['modalityId'],
      tenantId: json['tenantId'],
      name: json['name'],
      type: json['type'],
      sensorId: json['sensorId'],
      sensor: json['sensor'] != null ? Sensor.fromJson(json['sensor']) : null,
      widgets:
          json['widgets'] != null ? List<dynamic>.from(json['widgets']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modalityId': modalityId,
      'tenantId': tenantId,
      'name': name,
      'type': type,
      'sensorId': sensorId,
      'sensor': sensor?.toJson(),
      'widgets': widgets,
    };
  }
}
