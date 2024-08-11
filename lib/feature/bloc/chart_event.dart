part of 'chart_bloc.dart';

abstract class ChartEvent extends Equatable {
  const ChartEvent();

  @override
  List<Object> get props => [];
}

class LoadDashboardEvent extends ChartEvent {}

class LoadDashboardForTabEvent extends ChartEvent {
  final int dashboardId;
  const LoadDashboardForTabEvent({required this.dashboardId});
}
