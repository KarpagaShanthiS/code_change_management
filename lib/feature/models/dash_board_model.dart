import '/feature/models/widget_model.dart';

class Dashboard {
  final int? dashboardId;
  final String? name;
  final int? layoutId;
  final Layout? layout;
  final List<WidgetModel>? widgets;
  final List<dynamic>? devices; // Adjust the type based on actual data

  Dashboard({
    this.dashboardId,
    this.name,
    this.layoutId,
    this.layout,
    this.widgets,
    this.devices,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      dashboardId: json['dashboardId'],
      name: json['name'],
      layoutId: json['layoutId'],
      layout: json['layout'] != null ? Layout.fromJson(json['layout']) : null,
      widgets: json['widgets'] != null
          ? (json['widgets'] as List)
              .map((i) => WidgetModel.fromJson(i))
              .toList()
          : null,
      devices: json['devices'], // Adjust if necessary based on actual data
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dashboardId': dashboardId,
      'name': name,
      'layoutId': layoutId,
      'layout': layout?.toJson(),
      'widgets': widgets?.map((i) => i.toJson()).toList(),
      'devices': devices,
    };
  }
}

class Layout {
  final int? layoutId;
  final String? name;
  final int? numOfWidgets;
  final bool? isDefault;
  final List<Dashboard?>? dashboards;

  Layout({
    this.layoutId,
    this.name,
    this.numOfWidgets,
    this.isDefault,
    this.dashboards,
  });

  factory Layout.fromJson(Map<String, dynamic> json) {
    return Layout(
      layoutId: json['layoutId'],
      name: json['name'],
      numOfWidgets: json['numOfWidgets'],
      isDefault: json['isDefault'],
      dashboards: json['dashboards'] != null
          ? (json['dashboards'] as List)
              .map((i) => i != null ? Dashboard.fromJson(i) : null)
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'layoutId': layoutId,
      'name': name,
      'numOfWidgets': numOfWidgets,
      'isDefault': isDefault,
      'dashboards': dashboards?.map((i) => i?.toJson()).toList(),
    };
  }
}
