
class DeviceNamespace {
  final String deviceNamespaceId;
  final String tenantId;
  final String name;
  final String type;
  final String parentId;
  final List<dynamic>? sensors;
  final List<dynamic>? rules;
  final bool isPinned;
  final DateTime createdAt;
  final DateTime updatedAt;

  DeviceNamespace({
    required this.deviceNamespaceId,
    required this.tenantId,
    required this.name,
    required this.type,
    required this.parentId,
    required this.sensors,
    required this.rules,
    required this.isPinned,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeviceNamespace.fromJson(Map<String, dynamic> json) {
    return DeviceNamespace(
      deviceNamespaceId: json['deviceNamespaceId'],
      tenantId: json['tenantId'],
      name: json['name'],
      type: json['type'],
      parentId: json['parentId'],
      sensors: json['sensors'] ?? [],
      rules: json['rules'] ?? [],
      isPinned: json['isPinned'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceNamespaceId': deviceNamespaceId,
      'tenantId': tenantId,
      'name': name,
      'type': type,
      'parentId': parentId,
      'sensors': sensors,
      'rules': rules,
      'isPinned': isPinned,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
