import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/components/textFieldLoginSubscribe.dart';
import 'package:flutter_calendar_app/main.dart';
import '../viewmodels/LoginVewModel.dart';
import '../models/UserInformationModel.dart';
import '../../subscribe_page/views/Subscribe.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  UserInfosViewModel _userInfos = new UserInfosViewModel();

  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    final _userInfosProvider = Provider.of<UserInformationModel>(context, listen: false);

    return  Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              children: [

                //Logo
                SizedBox(height: 70),
                Image.asset(
                  'assets/LogoCAU2.png',
                  width: 180,
                  height: 180,
                ),

                //Logo
                SizedBox(height: 25),
                Icon(
                  Icons.lock_open,
                  color: Colors.grey[700],
                  size: 25.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),

                //Title
                SizedBox(height: 20),
                Text(
                  "CONNECTION",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),

                //Description
                SizedBox(height: 5),
                Text(
                  "WELCOME BACK TO YOUR CALENDAR",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15
                  ),
                ),
                SizedBox(height: 35),

                // e-mail textfield
                TextFieldLoginSubscribe(
                  controller: _userInfos.set_emailController(),
                  hintText: "E-mail",
                  obscureText: false,
                  numberKeyBoard: false,
                ),
                SizedBox(height: 30),

                // password textfield
                TextFieldLoginSubscribe(
                  controller: _userInfos.set_passwordController(),
                  hintText: "Password",
                  obscureText: true,
                  numberKeyBoard: false,
                ),

                // Sign in button with Chung-Ang University Logo
                SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async {

                    if (await _userInfos.validateValue()) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(_userInfos.get_title()),
                            content: Text('${_userInfos.get_errorMessage()}'),
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



                        // This function fill _userInfos.get_username() / _userInfos.get_student_id() / _userInfos.get_planningWeekCau()
                        if (await _userInfos.get_user_data_firebase(_userInfos.get_emailController().text)) {

                          _userInfosProvider.set_username(
                              _userInfos.get_username());
                          _userInfosProvider.set_student_id(
                              _userInfos.get_student_id());
                          _userInfosProvider.set_planningCau(
                              _userInfos.get_planningWeekCau());

                          final currentUser = await _authentication
                              .signInWithEmailAndPassword(
                              email: _userInfos
                                  .get_emailController()
                                  .text, password: _userInfos
                              .get_passwordController()
                              .text);

                          if (currentUser.user != null) {
                            _formKey.currentState!.reset();
                          }
                        }

                        else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error: Connection"),
                                content: Text('Email or Password is wrong'),
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

                      } catch(e) {
                        print (e);
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                      ),
                    ),
                  ),
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                SizedBox(height: 15),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscribePage(),
                      ),
                    );
                  },
                  child: Text(
                    'Subscribe first',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )

        )

    );
  }
}

