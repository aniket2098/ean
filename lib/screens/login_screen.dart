import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:ean/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<bool> getData(username, password) async {
    final http.Response response = await http.post(
      'https://studentdata11.herokuapp.com/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      if (decodedJson['msg'] == 'Login Success') {
        print("Success");
        var token = decodedJson['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('pict_ean_admin', token);
        return true;
      }
    }
    return false;
  }

  TextStyle style = TextStyle(fontSize: 15.0);
  bool loginPressed = false;
  bool errorOccurred = false;
  @override
  Widget build(BuildContext context) {
    String username;
    String password;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('EAN'),
      ),
      body: LoadingOverlay(
        isLoading: loginPressed,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 350.0 > width ? width : 350.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: kInfoLayoutCardElevation,
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey[900],
                              blurRadius: 10.0,
                              offset: Offset(0.0, 0.75))
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                        color: kCardColor,
                      ),
                      height: 60.0,
                      child: Center(
                        child: Text('Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60.0,
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          TextField(
                            obscureText: false,
                            style: style,
                            onChanged: (value) => username = value,
                            decoration: InputDecoration(
                                errorText:
                                    errorOccurred ? 'Invalid Username!' : null,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Username",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          TextField(
                            obscureText: true,
                            style: style,
                            onChanged: (value) => password = value,
                            decoration: InputDecoration(
                                errorText:
                                    errorOccurred ? 'Invalid Password!' : null,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Text("Login"),
                            onPressed: () {
                              setState(() {
                                loginPressed = true;
                              });
                              getData(username, password).then((value) {
                                if (value) {
                                  setState(() {
                                    loginPressed = false;
                                  });

                                  Navigator.pushNamed(context, '/InfoScreen');
                                } else {
                                  setState(() {
                                    loginPressed = false;
                                    errorOccurred = true;
                                  });
                                }
                              });
                            },
                            color: Colors.lightBlue,
                            textColor: Colors.white,
                            splashColor: Colors.grey,
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
