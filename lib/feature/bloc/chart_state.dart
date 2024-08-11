part of 'chart_bloc.dart';

class ChartState extends Equatable {
  const ChartState({
    this.dashboards = const <Dashboard>[],
    this.isLoading = false,
    this.dashboardData = const {},
    this.sensorDataMap = const {},
    this.sensorDataList = const [],
    this.widgets = const [],
  });

  final List<Dashboard> dashboards;
  final bool isLoading;
  final Map<int, Dashboard> dashboardData;
  final Map<int, WidgetWithName> sensorDataMap;
  final List<SensorData> sensorDataList;
  final List<WidgetModel> widgets;

  @override
  List<Object> get props => [
        dashboards,
        isLoading,
        dashboardData,
        sensorDataMap,
        sensorDataList,
        widgets,
      ];

  ChartState copyWith(
   { List<Dashboard>? dashboards,
    bool? isLoading,
    Map<int, Dashboard>? dashboardData,
    Map<int, WidgetWithName>? sensorDataMap,
    List<SensorData>? sensorDataList,
    List<WidgetModel>? widgets,
    }
  ) {
    return ChartState(
      dashboards: dashboards ?? this.dashboards,
      dashboardData: dashboardData ?? this.dashboardData,
      sensorDataMap: sensorDataMap ?? this.sensorDataMap,
      sensorDataList: sensorDataList ?? this.sensorDataList,
      widgets: widgets ?? this.widgets,
    );
  }
}
