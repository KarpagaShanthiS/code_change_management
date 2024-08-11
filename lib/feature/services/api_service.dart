import 'dart:convert';
import 'dart:developer';

import '/feature/models/dash_board_model.dart';
import 'package:http/http.dart' as http;
import '/feature/models/sensor.dart';
import '/feature/models/widget_model.dart';

const String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiNWI5ODQ0OWUtYmVkYy00ZGMyLTgwYWYtMzJkMjEyMGE1YTczIiwidGlua3l3ZWJhcHAiXSwiaXNzIjoid2ViYXBwIiwiaWF0IjoxNzIyNDA2NDcyLCJuYmYiOjE3MjI0MDY0NzIsImV4cCI6MTcyMzcwMjc3NiwiYWlvIjoiQVRRQXkvOFhBQUFBWFV1RkRhaW1JNURKSDVvb2dXeDFuVzcyM2hzekxCYjQwemtFb1RFU3FZYTNTVzhkVnBmOFQxaUhIbDhCUGFvUSIsImF1dGhfdGltZSI6MTcyMjQwNjc3MSwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoia2FycGFnYXNoYW50aGkuc0B0aW5rZXJibG94LmlvIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvc3VybmFtZSI6IlMiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJLYXJwYWdhc2hhbnRoaSIsIm5hbWUiOiJLYXJwYWdhc2hhbnRoaSBTIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS9pZGVudGl0eS9jbGFpbXMvb2JqZWN0aWRlbnRpZmllciI6ImVmYzVlZTdmLTc2MDYtNDQ0Yy1iY2ZjLTU4OGM3YjdlZjExOCIsInByZWZlcnJlZF91c2VybmFtZSI6ImthcnBhZ2FzaGFudGhpLnNAdGlua2VyYmxveC5pbyIsInJoIjoiMC5BVDBBR2NFTVRVbWJ6a2FvSWxRdDNtZmpQWjVFbUZ2Y3ZzSk5nSzh5MGhJS1duT2hBTHMuIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJBWGFIQThxWFdFSDBIWVA5cFE3TlRCZmlWOHZMblR4TklNV2lGR21ockNVIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS9pZGVudGl0eS9jbGFpbXMvdGVuYW50aWQiOiI0ZDBjYzExOS05YjQ5LTQ2Y2UtYTgyMi01NDJkZGU2N2UzM2QiLCJ1dGkiOiJKeTJiLTlRd1cwS3NkeGR5bjR3WEFBIiwidmVyIjoiMi4wIn0.XbzRF85zogi3TfkN6dcuQyBVz2uT32eyDFRDUHIhGSc";

class ApiService {
  const ApiService();

  Future<List<Dashboard>> fetchDashboards() async {
    const String url = 'https://dev.tinkerblox.io/api/Dashboard';

    log('Starting to fetch dashboards');

    try {
      log('trying');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      log('HTTP request complete with status: ${response.statusCode}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;

        return data.map((json) => Dashboard.fromJson(json)).toList();
      } else {
        log('Failed to load dashboards. Status code: ${response.statusCode}');
        throw Exception('Failed to load dashboards');
      }
    } catch (e) {
      log('Error occurred while fetching dashboards: $e');
      throw Exception('Error fetching dashboards: $e');
    }
  }

  Future<Dashboard> postDashBoardId(int dashboardId) async {
    const String url = 'https://dev.tinkerblox.io/api/Dashboard/Details/';
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      Map<String, String> requestHeaders = {
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(requestHeaders);

      // Add the dashboardId to the form data
      request.fields['dashboardId'] = dashboardId.toString();

      // Send the request and wait for the response
      final response = await request.send();

      // Read the response
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var data = jsonDecode(responseBody);

        // log("VALUEEEE:::: $data");

        return Dashboard.fromJson(data);
      } else {
        log('Failed to load dashboards. Status code: ${response.statusCode}');
        throw Exception('Failed to load dashboards');
      }
    } catch (e) {
      log('Error occurred while fetching dashboards: $e');
      throw Exception('Error fetching dashboards: $e');
    }
  }

  Future<WidgetModel> fetchWidget({required String widgetId}) async {
    final response = await http.get(
      Uri.parse('https://dev.tinkerblox.io/api/Widget/$widgetId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return WidgetModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load widget');
    }
  }

  Future<List<SensorData>> fetchSensorData(
      {required String modalitiesId}) async {
    final String apiUrl =
        "https://dev.tinkerblox.io/api/SensorDatas/$modalitiesId";
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => SensorData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
