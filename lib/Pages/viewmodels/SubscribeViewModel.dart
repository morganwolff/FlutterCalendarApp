import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/Pages/models/SubscribeModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class subscribeViewModel {

  subscribeDataModel _subscribeModel = new subscribeDataModel();

  /////////////////// ID NUMBER USER  ///////////////////
  TextEditingController get_studentIdNumberController() {
    return _subscribeModel.studentIdNumberController;
  }

  TextEditingController set_studentIdNumberController() {
    return _subscribeModel.studentIdNumberController;
  }

  /////////////////// USERNAME  ///////////////////
  TextEditingController get_usernameController() {
    return _subscribeModel.usernameController;
  }

  TextEditingController set_usernameController() {
    return _subscribeModel.usernameController;
  }

  /////////////////// E-mail  ///////////////////
  TextEditingController get_emailController() {
    return _subscribeModel.emailController;
  }

  TextEditingController set_emailController() {
    return _subscribeModel.emailController;
  }

  /////////////////// Password  ///////////////////
  TextEditingController get_passwordController() {
    return _subscribeModel.passwordController;
  }

  TextEditingController set_passwordController() {
    return _subscribeModel.passwordController;
  }

  /////////////////// Get/Set Title/ErrorMessage  ///////////////////

  String get_title() {
    return _subscribeModel.titleDialog;
  }

  String get_errorMessage() {
    return _subscribeModel.errorMessageDialog;
  }


  /////////////////// Password  ///////////////////
  List get_planningWeekCau() {
    return _subscribeModel.planningCau;
  }

  /////////// Validate Informations  //////////////
  Future<bool> validateValue() async {

    var checkValidStudentIdNumber = await fetchData();
    String email = _subscribeModel.emailController.toString();
    int startIndex = email.indexOf('┤');
    int endIndex = email.indexOf('├', 1);

    if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
      email = email.substring(startIndex + 1, endIndex);
    }

    if (checkValidStudentIdNumber == false) {
      _subscribeModel.titleDialog = "ERROR: Id student number";
      _subscribeModel.errorMessageDialog = "The CHUNG ANG student id number doesn't exist.";
      return (true);
    }

    if (_subscribeModel.usernameController.toString().length < 205) {
      _subscribeModel.titleDialog = "ERROR: Username";
      _subscribeModel.errorMessageDialog = "Your Username must provide at least 4 characters.";
      return (true);
    }

    if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
    .hasMatch(email) == false) {
      _subscribeModel.titleDialog = "ERROR: E-mail";
      _subscribeModel.errorMessageDialog = "Enter a valid e-mail format.";
      return (true);
    }

    ////// Check password length //////
    if (_subscribeModel.passwordController.toString().length < 205) {
      _subscribeModel.titleDialog = "ERROR: Password";
      _subscribeModel.errorMessageDialog = "Your password must provide at least 4 characters.";
      return (true);
    }

    return (false);
  }

  //////////// Insert Data Into Firebase //////////////

  Future<bool> insertDataFireStore(String _email, String _student_id, String _username) async {
    final CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      users.add({
        'email': _email,
        'student_id': _student_id,
        'username': _username
      }).catchError((error) =>
          print('Failed to add user firestore: $error'),
      );

      return (true);

    } catch (e) {

      return (false);
    }


  }

  /////////// Check If Number Id Is Valid  //////////////

  Future<bool> fetchData() async {
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
        if (response.body.toString().length > 2) {
          return true;
        } else {
          return false;
        }

      } else {
        // If the server did not return a 200 OK response,
        // throw an exception or handle the error based on your use case
        throw Exception('Failed to load data');
        return false;
      }
    } catch (error) {
      // Handle network errors or any other exceptions that might occur during the HTTP request
      print("Error: $error");
    }

    return false;

  }

  subscribeViewModel();
}