import 'package:flutter/material.dart';

class UserInfosModel {

  // TextFormField
  dynamic emailController = TextEditingController();
  dynamic passwordController = TextEditingController();

  // Error Message
  String titleDialog = "";
  String errorMessageDialog = "";

  // Get data from fireStore and ChungAngAPI
  dynamic planningCau;
  String username = "";
  String student_id = "";

}