import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/Pages/models/LoginModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class UserInfosViewModel {

  UserInfosModel _userInfosModel = new UserInfosModel();

  /////////////////// ID NUMBER USER  ///////////////////
  TextEditingController get_emailController() {
    return _userInfosModel.emailController;
  }

  TextEditingController set_emailController() {
    return _userInfosModel.emailController;
  }

  /////////////////// USERNAME  ///////////////////
  TextEditingController get_passwordController() {
    return _userInfosModel.passwordController;
  }

  TextEditingController set_passwordController() {
    return _userInfosModel.passwordController;
  }

  List get_planningWeekCau() {
    return _userInfosModel.planningCau;
  }

  /////////////////// Get/Set Title/ErrorMessage  ///////////////////

  String get_title() {
    return _userInfosModel.titleDialog;
  }

  String get_errorMessage() {
    return _userInfosModel.errorMessageDialog;
  }

  /////////////////// TRANSLATE TIME  ///////////////////
  String translateEnglishTime (String time) {

    String checkTimeInMap = time[0] + time[1];

    Map<String, String> timePm = {
      "12": "12",
      "13": "01",
      "14": "02",
      "15" :"03",
      "16" :"04",
      "17" :"05",
      "18" :"06",
      "19" :"07",
      "20" :"08",
      "21" :"09",
      "22" :"10",
      "23" :"11",
      "24" :"00",
    };

    // Check if the map contains the key
    if (timePm.containsKey(checkTimeInMap)) {

      var newTime = timePm[checkTimeInMap]! + time[2] + time[3] + time[4] + " pm";
      return newTime.toString();

      return time;
    } else {
      return time + " am"; // Or handle the case as needed
    }

    print(time);
    return time;
  }


  ////////////// GET FILTERED DATA DAY PLANNING OF CHUNG ANG UNIVERSITY  ////////////

  List<dynamic> dayPlanningList(int i, String whichDay, List<Map<String, dynamic>> scheduleData, List CoursesOftheDay) {

    var listDay = {0: "d1", 1: "d2", 2:"d3", 3:"d4", 4:"d5", 5:"d6", 6:"d7"};

    CoursesOftheDay.add([]);
    List<Map<String, dynamic>> filteredData = scheduleData
        .where((entry) => entry[whichDay] != null)
        .toList();

    for (var entry in filteredData) {
      var detailsCourses = entry[whichDay];
      var title = "";
      var building = "";
      var className = "";
      var titleDone = false;
      var buildingDone = false;
      var classDone = false;

      for (int i = 0; i < detailsCourses.length; i++) {

        if ((i + 3) < detailsCourses.length) {

          if (detailsCourses[i + 1] == "<" && detailsCourses[i + 2] == "b" && detailsCourses[i + 3] == "r") {
            titleDone = true;
            buildingDone = true;
            i += 3;
          }
          if (titleDone == false) title += detailsCourses[i];

        }

        if (detailsCourses[i] == "관") {
          buildingDone = false;
          classDone = true;
          i += 1;
        }

        if (titleDone == true && buildingDone == true) {
          building += detailsCourses[i];
        }

        if (titleDone == true && buildingDone == false && classDone == true) {
          className += detailsCourses[i];
        }
        if (detailsCourses[i + 1] == "호")  {
          building = building.replaceAll(new RegExp(r'[^0-9]'),'');
          className = className.replaceAll(new RegExp(r'[^0-9]'),'');
          break;
        }
      }

      if (CoursesOftheDay[i].length == 0) {

        CoursesOftheDay[i].add({
          "coursesName": title,
          "buildingNumber": building,
          "classNumber": className,
          "startTime": translateEnglishTime(entry['tm1']),
          "endTime": translateEnglishTime(entry['tm2'])
        });
      } else {

        if (CoursesOftheDay[i][CoursesOftheDay[i].length - 1]["coursesName"] == title) {
          CoursesOftheDay[i][CoursesOftheDay[i].length - 1]["endTime"] = translateEnglishTime(entry['tm2']);
        } else {
          CoursesOftheDay[i].add({
            "coursesName": title,
            "buildingNumber": building,
            "classNumber": className,
            "startTime": translateEnglishTime(entry['tm1']),
            "endTime": translateEnglishTime(entry['tm2'])
          });
        }

      }
    }

    i += 1;
    if (i != 7) {
      dayPlanningList(i, listDay[i].toString(), scheduleData, CoursesOftheDay);
    }
    return (CoursesOftheDay);

  }

  /////////////////// Validate Information TextFormField ////////////////////
  Future<bool> validateValue() async {

    String email = _userInfosModel.emailController.toString();
    int startIndex = email.indexOf('┤');
    int endIndex = email.indexOf('├', 1);

    if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
      email = email.substring(startIndex + 1, endIndex);
    }

    if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email) == false) {
      _userInfosModel.titleDialog = "ERROR: E-mail";
      _userInfosModel.errorMessageDialog = "Enter a valid e-mail format.";
      return (true);
    }

    ////// Check password length //////
    if (_userInfosModel.passwordController.toString().length < 205) {
      _userInfosModel.titleDialog = "ERROR: Password";
      _userInfosModel.errorMessageDialog = "Your password must provide at least 4 characters.";
      return (true);
    }

    return (false);
  }

  /////////////////// GET DATA PLANNING OF CHUNG ANG UNIVERSITY  ///////////////////
  Future<void> fetchData() async {
    /*const apiUrl = "https://mportal.cau.ac.kr/portlet/p006/p006List.ajax";
    final Map<String, String> headers = {
      'Content-Type': 'application/json', // Adjust the content type as needed
    };

    final Map<String, dynamic> requestBody = {
      'userId': get_emailController().text,
    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );


      if (response.statusCode == 200) {
        List<Map<String, dynamic>> scheduleData = (json.decode(response.body.toString()) as List<dynamic>)
            .cast<Map<String, dynamic>>();

        _userInfosModel.planningCau = dayPlanningList(0, "", scheduleData, []);

      } else {
        // If the server did not return a 200 OK response,
        // throw an exception or handle the error based on your use case
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // Handle network errors or any other exceptions that might occur during the HTTP request
      print("Error: $error");
    }*/
  }

  UserInfosViewModel();
}