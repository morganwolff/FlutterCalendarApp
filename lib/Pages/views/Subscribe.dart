import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/Pages/viewmodels/SubscribeViewModel.dart';
import 'package:flutter_calendar_app/Pages/views/Login.dart';
import 'package:flutter_calendar_app/components/textFieldLoginSubscribe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({super.key});


  @override
  State<SubscribePage> createState() => _SubscribePage();
}

class _SubscribePage extends State<SubscribePage> {

  subscribeViewModel _subscribeInfos = new subscribeViewModel();

  var error = false;
  var ErrorMsg = "";
  final _formKey = GlobalKey<FormState>();
  final _authentification = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(

      body: Form(
        key: _formKey,
        child: Column(
            children: [

              //Logo
              SizedBox(height: 70),

              Image.asset(
                'assets/ChungAng_Logo.png', // Replace with the path to your image file
                width: 130, // Adjust the width as needed
                height: 130, // Adjust the height as needed
              ),



              SizedBox(height: 25),

              Icon(
                Icons.verified_outlined,
                color: Colors.grey[700],
                size: 25.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),

              SizedBox(height: 15),

              //Welcome Back

              Text(
                "SUBSCRIBE",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),

              SizedBox(height: 20),

              // usesrname textfield
              TextFieldLoginSubscribe(
                controller: _subscribeInfos.set_studentIdNumberController(),
                hintText: "Student Id N°",
                obscureText: false,
                numberKeyBoard: true,
              ),
              SizedBox(height: 15),

              TextFieldLoginSubscribe(
                controller: _subscribeInfos.set_usernameController(),
                hintText: "Username",
                obscureText: false,
                numberKeyBoard: false,
              ),
              SizedBox(height: 15),

              TextFieldLoginSubscribe(
                controller: _subscribeInfos.set_emailController(),
                hintText: "E-mail",
                obscureText: false,
                numberKeyBoard: false,
              ),
              SizedBox(height: 15),

              // password textfield
              TextFieldLoginSubscribe(
                controller: _subscribeInfos.set_passwordController(),
                hintText: "Password",
                obscureText: true,
                numberKeyBoard: false,
              ),

              // Sign in button with Chung-Ang University Logo
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {

                  if (await _subscribeInfos.validateValue()) {

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(_subscribeInfos.get_title()),
                          content: Text('${_subscribeInfos.get_errorMessage()}'),
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
                          email: _subscribeInfos.get_emailController().text, password: _subscribeInfos.get_passwordController().text);

                      if (_newUser.user != null) {
                        _formKey.currentState!.reset();

                        users.add({
                          'email': _subscribeInfos.get_emailController().text,
                          'student_id': _subscribeInfos.get_studentIdNumberController().text,
                          'username': _subscribeInfos.get_usernameController().text
                        }).catchError((error) => print('Failed to add user firestore: $error'));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      }
                    } catch(e) {
                      if (e.toString().contains("email address is already")) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("ERROR: Email"),
                              content: Text(
                                  'The email is already used. You should change the email address.'),
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
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                    ),
                  ),
                ),
                child: Text(
                  "Subscribe",
                  style: TextStyle(color: Colors.white),
                ),
              ),


              SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  // Navigate to the second view and replace the current screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text(
                  'Return Login',
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
