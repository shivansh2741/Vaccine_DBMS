import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vaccination_dbms/const.dart';
import 'package:vaccination_dbms/func.dart';
import 'package:vaccination_dbms/home.dart';
import 'package:vaccination_dbms/register.dart';
import 'package:vaccination_dbms/staffHomePage.dart';

import 'adminHomePage.dart';
import 'model/stock.dart';
import 'model/vaccine.dart';

String curr_email = "";

void main() {
  runApp(const MyApp());
}

Map<String, Vaccine> vaccine_map = {};
List<Stock> stockList = [];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme:
              ThemeData.dark().colorScheme.copyWith(primary: Colors.orange),
        ),
        home: const LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '', password = '';
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "ImmunoFind",
                style: kHeading,
              ),
              Hero(
                tag: "logo",
                child: Image.asset(
                  'images/vacc.png',
                  width: 200,
                  height: 200,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email",
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20),
                child: TextField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Password",
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  minimumSize: Size(120, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.transparent,
                      width: 2.0,
                    ),
                  ),
                ),
                onPressed: () async {
                  context.loaderOverlay.hide();
                  context.loaderOverlay.show();
                  String result = await login(email, password);

                  if (result == 'True') {
                    curr_email = email;
                    makeMap();
                    String userpower = await checkPower(email);
                    context.loaderOverlay.hide();
                    if (userpower == "Admin") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AdminMain();
                        }),
                      );
                    } else if (userpower == "Staff") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return StaffHomePage();
                        }),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }),
                      );
                    }
                  } else {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont Have an Account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const RegisterScreen();
                        }),
                      );
                    },
                    child: const Text(
                      "Register Here",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
