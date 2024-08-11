import '/feature/models/modality.dart';

class WidgetModel {
  final int? widgetId;
  final String? name;
  final int? type;
  final String? graphParameters;
  final int? dashboardId;
  final List<Modality>? modalities;

  WidgetModel({
    this.widgetId,
    this.name,
    this.type,
    this.graphParameters,
    this.dashboardId,
    this.modalities,
  });

  factory WidgetModel.fromJson(Map<String, dynamic> json) {
    return WidgetModel(
      widgetId: json['widgetId'],
      name: json['name'],
      type: json['type'],
      graphParameters: json['graphParameters'],
      dashboardId: json['dashboardId'],
      modalities: json['modalities'] != null
          ? (json['modalities'] as List)
              .map((i) => Modality.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'widgetId': widgetId,
      'name': name,
      'type': type,
      'graphParameters': graphParameters,
      'dashboardId': dashboardId,
      'modalities': modalities?.map((e) => e.toJson()).toList(),
    };
  }
}
