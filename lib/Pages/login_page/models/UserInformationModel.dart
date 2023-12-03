import 'package:flutter/material.dart';

class UserInformationModel with ChangeNotifier {
  String _username = '';
  String _studentId = '';
  dynamic _planningCau;

  String get username => _username;
  String get studentId => _studentId;
  dynamic get planningCau => _planningCau;

  void set_username(String username) {
    _username = username;
    notifyListeners();
  }

  void set_student_id(String studentId) {
    _studentId = studentId;
    notifyListeners();
  }

  void set_planningCau(dynamic planningCau) {
    _planningCau = planningCau;
    notifyListeners();
  }
}