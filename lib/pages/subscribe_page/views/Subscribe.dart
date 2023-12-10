import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/Pages/subscribe_page/viewmodels/SubscribeViewModel.dart';
import 'package:flutter_calendar_app/Pages/login_page/views/Login.dart';
import 'package:flutter_calendar_app/components/textFieldLoginSubscribe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../../login_page/models/UserInformationModel.dart';
import '../../login_page/viewmodels/LoginVewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calendar_app/locals/app_locale.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({super.key});

  @override
  State<SubscribePage> createState() => _SubscribePage();
}

class _SubscribePage extends State<SubscribePage> {
  subscribeViewModel _subscribeInfos = new subscribeViewModel();
  UserInfosViewModel _userInfos = new UserInfosViewModel();

  var error = false;
  var ErrorMsg = "";
  final _formKey = GlobalKey<FormState>();
  final _authentification = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final _userInfosProvider =
        Provider.of<UserInformationModel>(context, listen: false);

    return Scaffold(
        resizeToAvoidBottomInset : false,
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 70),
                Image.asset(
                  'assets/ChungAng_Logo.png',
                  width: 130,
                  height: 130,
                ),
                SizedBox(height: 25),
                Icon(
                  Icons.verified_outlined,
                  color: Colors.grey[700],
                  size: 25.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                SizedBox(height: 15),
                Text(
                  AppLocale.sign_up.getString(context),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(height: 20),
                TextFieldLoginSubscribe(
                  controller: _subscribeInfos.set_studentIdNumberController(),
                  hintText: AppLocale.student_id.getString(context),
                  obscureText: false,
                  numberKeyBoard: true,
                ),
                SizedBox(height: 15),
                TextFieldLoginSubscribe(
                  controller: _subscribeInfos.set_usernameController(),
                  hintText: AppLocale.username.getString(context),
                  obscureText: false,
                  numberKeyBoard: false,
                ),
                SizedBox(height: 15),
                TextFieldLoginSubscribe(
                  controller: _subscribeInfos.set_emailController(),
                  hintText: AppLocale.email.getString(context),
                  obscureText: false,
                  numberKeyBoard: false,
                ),
                SizedBox(height: 15),
                TextFieldLoginSubscribe(
                  controller: _subscribeInfos.set_passwordController(),
                  hintText: AppLocale.password.getString(context),
                  obscureText: true,
                  numberKeyBoard: false,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (await _subscribeInfos.validateValue()) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(_subscribeInfos.get_title()),
                            content:
                                Text('${_subscribeInfos.get_errorMessage()}'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Ok'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      try {
                        final _newUser = await _authentification
                            .createUserWithEmailAndPassword(
                                email:
                                    _subscribeInfos.get_emailController().text,
                                password: _subscribeInfos
                                    .get_passwordController()
                                    .text);
                        if (await _subscribeInfos.insertDataFireStore(
                            _subscribeInfos.get_emailController().text,
                            _subscribeInfos
                                .get_studentIdNumberController()
                                .text,
                            _subscribeInfos.get_usernameController().text)) {
                          if (_newUser.user != null) {
                            _formKey.currentState!.reset();
                            if (!mounted) return;
                            if (await _userInfos.get_user_data_firebase(
                                _subscribeInfos.get_emailController().text)) {
                              _userInfosProvider
                                  .set_username(_userInfos.get_username());
                              _userInfosProvider
                                  .set_student_id(_userInfos.get_student_id());
                              _userInfosProvider.set_planningCau(
                                  _userInfos.get_planningWeekCau());
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            }
                          }
                        }
                      } catch (e) {
                        if (e.toString().contains("email address is already")) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(AppLocale.error_mail.getString(context)),
                                content: Text(
                                    AppLocale.already_used.getString(context)),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        print(e);
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5.0), // Adjust the radius as needed
                      ),
                    ),
                  ),
                  child: Text(
                    AppLocale.sign_up.getString(context),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    AppLocale.return_login.getString(context),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )));
  }
}
