import 'dart:convert';
import 'dart:io';

import 'package:eventquest/constants/error_handling.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/constants/utils.dart';

class PosterValidation {
  Future<String> verifyPoster(
      {required BuildContext context, required File posterImage}) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    String result = "";

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:8000/upload'),
      );

      request.headers['Content-Type'] = 'multipart/form-data';

      // Add your file
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        posterImage.path,
      ));

      // Send the request
      http.StreamedResponse streamedResponse = await request.send();

      // Convert the StreamedResponse to a Response
      http.Response response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Poster uploaded successfully...");
        var responseBody = jsonDecode(response.body);
        if (responseBody['status']) {
          print(responseBody['message']);
          result = responseBody['message'];
        } else {
          print(responseBody['message']);
          result = responseBody['message'];
        }
      } else {
        print('Upload failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }

    return result;
  }
}