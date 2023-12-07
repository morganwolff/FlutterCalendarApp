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

  List<dynamic> getUserCAUPlanning() {
    return _userInfosModel.planningCau;
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

      var newTime = "${timePm[checkTimeInMap]!}${time[2]}${time[3]}${time[4]} pm";
      return newTime.toString();

    } else {

      return "$time am"; // Or handle the case as needed

    }
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



  /////////////////// GET DATA PLANNING OF CHUNG ANG UNIVERSITY  ///////////////////
  Future<void> fetchData(String _studentId) async {
    const apiUrl = "https://mportal.cau.ac.kr/portlet/p006/p006List.ajax";
    final Map<String, String> headers = {
      'Content-Type': 'application/json', // Adjust the content type as needed
    };

    final Map<String, dynamic> requestBody = {
      'userId': _studentId,
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
    }
  }

  UserInfosViewModel();
}