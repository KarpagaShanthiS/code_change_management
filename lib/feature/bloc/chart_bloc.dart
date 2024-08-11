import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:code_change_management/feature/models/dash_board_model.dart';
import 'package:code_change_management/feature/models/sensor.dart';
import 'package:code_change_management/feature/models/widget_model.dart';
import 'package:code_change_management/feature/models/widget_with_name.dart';
import 'package:code_change_management/feature/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'chart_event.dart';
part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final ApiService apiService;
  ChartBloc(this.apiService) : super(const ChartState()) {
    on<LoadDashboardEvent>(onLoadDashboards);
    on<LoadDashboardForTabEvent>(onLoadDashboardForTab);
  }

  List<Dashboard> dashboards = [];
  Map<int, Dashboard> dashboardData = {};
  List<SensorData> sensorDataList = [];
  Map<int, WidgetWithName> sensorDataMap = {};

  Future<void> onLoadDashboards(
      LoadDashboardEvent event, Emitter<ChartState> emit) async {
    log("Loading Dashbaords");
    emit(state.copyWith(isLoading: true));

    try {
      dashboards = await apiService.fetchDashboards();
      emit(
        state.copyWith(dashboards: dashboards, isLoading: false),
      );
      log("Loading complete current state of isLoading: ${state.isLoading}");
    } catch (e) {
      log('ERROR FROM BLOC::: $e');
    }

    // setState(() {

    //   _tabController = TabController(length: _dashboards.length, vsync: this);
    //   _tabController?.addListener(_handleTabSelection);
    // });

    // Call _handleTabSelection manually for the initial tab
    // if (_tabController?.index != null) {
    //   int initialIndex = _tabController!.index;
    //   int dashboardId = _dashboards[initialIndex].dashboardId!;
    //   _loadDashboardForTab(dashboardId);
    // }
  }

  Future<void> onLoadDashboardForTab(
      LoadDashboardForTabEvent event, Emitter<ChartState> emit) async {
    log("API CALLED");

    try {
      Dashboard dashboard = await apiService.postDashBoardId(event.dashboardId);
      dashboardData[event.dashboardId] = dashboard;
      emit(
        state.copyWith(dashboardData: dashboardData),
      );
      // setState(() {
      //   _dashboardData[dashboardId] = dashboard;
      // });

      List<Future<WidgetModel>> widgetFutures =
          dashboard.widgets!.map((widget) {
        return apiService.fetchWidget(widgetId: "${widget.widgetId}");
      }).toList();

      emit(
        state.copyWith(
          widgets: await Future.wait(widgetFutures),
        ),
      );

      for (int i = 0; i < state.widgets.length; i++) {
        WidgetModel widget = state.widgets[i];
        if (widget.modalities != null) {
          for (var modality in widget.modalities!) {
            var addSensorDataList = await apiService.fetchSensorData(
                modalitiesId: modality.modalityId!);
            sensorDataList.addAll(addSensorDataList);

            sensorDataMap[event.dashboardId] = WidgetWithName(
                sensorDataList: sensorDataList,
                widgetName: widget.name ?? "EMPTY");
            emit(state.copyWith(sensorDataMap: sensorDataMap));
          }
        }
      }
    } catch (e) {
      log('ERROR FROM BLOC::: $e');
    }
  }
}
