import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/Subscribe.dart';
import 'package:flutter_calendar_app/components/textFieldLoginSubscribe.dart';
import 'package:flutter_calendar_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  final studentIdNumberController = TextEditingController();
  final passwordController = TextEditingController();

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
                  "CONNECTION",
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

                // password textfield
                TextFieldLoginSubscribe(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                  numberKeyBoard: false,
                ),

                // Sign in button with Chung-Ang University Logo
                SizedBox(height: 50),

                ElevatedButton(
                  onPressed: () {
                    // Add your logic here
                    print('Button pressed');
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

                SizedBox(height: 30),

                GestureDetector(
                  onTap: () {
                    // Navigate to the second view and replace the current screen
                    Navigator.pushReplacement(
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
