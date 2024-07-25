import 'dart:convert';

import 'package:eventquest/constants/error_handling.dart';
import 'package:eventquest/constants/global_variable.dart';
import 'package:eventquest/models/eventReport.dart';
import 'package:eventquest/screens/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportServices {
  Future<List<EventReport>> getAllReports(BuildContext context) async {
    List<EventReport> eventReportList = [];

    try {
      final res = await http.get(Uri.parse("$url/api/v1/reports"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            final jsonData = jsonDecode(res.body) as List;
            print(jsonData);
            eventReportList =
                jsonData.map((item) => EventReport.fromJson(item)).toList();
          });
      print(eventReportList);
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
    return eventReportList;
  }
}
