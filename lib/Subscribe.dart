import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/Login.dart';
import 'package:flutter_calendar_app/components/textFieldLoginSubscribe.dart';
import 'package:flutter_calendar_app/main.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({super.key});


  @override
  State<SubscribePage> createState() => _SubscribePage();
}

class _SubscribePage extends State<SubscribePage> {

  final studentIdNumberController = TextEditingController();
  final confirmStudentIdNumberController = TextEditingController();
  final passwordController = TextEditingController();

  var error = false;
  var ErrorMsg = "";


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Column(
            children: [

              //Logo
              SizedBox(height: 70),

              Image.asset(
                'assets/ChungAng_Logo.png', // Replace with the path to your image file
                width: 180, // Adjust the width as needed
                height: 180, // Adjust the height as needed
              ),



              SizedBox(height: 35),

              //Welcome Back

              Text(
                "SUBSCRIBE",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),

              SizedBox(height: 5),

              Text(
                "WELCOME BACK TO YOUR CALENDAR",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15
                ),
              ),
              SizedBox(height: 35),

              // usesrname textfield
              TextFieldLoginSubscribe(
                controller: studentIdNumberController,
                hintText: "Student Id N°",
                obscureText: false,
                numberKeyBoard: true,
              ),
              SizedBox(height: 30),

              TextFieldLoginSubscribe(
                controller: confirmStudentIdNumberController,
                hintText: "Confirm Student Id N°",
                obscureText: false,
                numberKeyBoard: true,
              ),
              SizedBox(height: 30),

              // password textfield
              TextFieldLoginSubscribe(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
                numberKeyBoard: false,
              ),

              // Sign in button with Chung-Ang University Logo
              SizedBox(height: 35),

              ElevatedButton(
                onPressed: () {
                  // Add your logic here
                  if (studentIdNumberController.toString() != confirmStudentIdNumberController.toString()) {
                    error = true;
                    ErrorMsg = "Student IDs do not match.";
                  }
                  if (passwordController.toString().length != 0) {
                    error = true;
                    ErrorMsg = "Password is empty.";
                  }
                  if (studentIdNumberController.toString().length != 0) {
                    error = true;
                    ErrorMsg = "Student Id number is empty.";
                  }

                  if (error == true) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('${ErrorMsg}'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                // Close the dialog
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    print("Button is pressed!");
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
