import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/LoginModel.dart';

class UserInfosViewModel {

  UserInfosModel _userInfosModel = new UserInfosModel();

  /////////////////// ID NUMBER USER  ///////////////////
  TextEditingController get_studentIdNumberController() {
    return _userInfosModel.studentIdNumberController;
  }

  TextEditingController set_studentIdNumberController() {
    return _userInfosModel.studentIdNumberController;
  }

  /////////////////// USERNAME  ///////////////////
  TextEditingController get_usernameController() {
    return _userInfosModel.usernameController;
  }

  TextEditingController set_usernameController() {
    return _userInfosModel.usernameController;
  }


  /////////////////// GET DATA PLANNING OF CHUNG ANG UNIVERSITY  ///////////////////
  Future<void> fetchData() async {
    const apiUrl = "https://mportal.cau.ac.kr/portlet/p006/p006List.ajax";
    final Map<String, String> headers = {
      'Content-Type': 'application/json', // Adjust the content type as needed
    };

    final Map<String, dynamic> requestBody = {
      'userId': get_studentIdNumberController().text,
    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );


      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        // Do something with the response body, e.g., print or process the data
        print("Response Correct: ${response.body}");


      } else {
        // If the server did not return a 200 OK response,
        // throw an exception or handle the error based on your use case
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // Handle network errors or any other exceptions that might occur during the HTTP request
      print("Error: $error");
    }
  }

  UserInfosViewModel();
}