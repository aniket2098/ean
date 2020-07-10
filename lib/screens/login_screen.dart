import 'dart:convert';
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
  Future<bool> _login(username, password) async {
    final http.Response response = await http.post(
      kLoginUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == kStatusCodeOk) {
      var decodedJson = json.decode(response.body);
      if (decodedJson['msg'] == kLoginSuccessMssg) {
        var token = decodedJson['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(kSharedPreferenceKey, token);
        return true;
      }
    }
    return false;
  }

  bool loginPressed = false;
  bool errorOccurred = false;

  @override
  Widget build(BuildContext context) {
    String username;
    String password;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: fScaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(kTitle),
      ),
      body: LoadingOverlay(
        isLoading: loginPressed,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: kLoginDefaultContainerWidth > width
                  ? width
                  : kLoginDefaultContainerWidth,
              child: Padding(
                padding: kLoginCardPadding,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kLoginCardBorderRadius),
                  ),
                  elevation: kInfoLayoutCardElevation,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[fLoginHeaderBoxShadow],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(kLoginCardBorderRadius),
                            topRight: Radius.circular(kLoginCardBorderRadius),
                          ),
                          color: kInfoLayoutCardColor,
                        ),
                        height: kLoginHeaderContainerHeight,
                        child: Center(
                          child: Text(
                            kLoginHeader,
                            textAlign: TextAlign.center,
                            style: kLoginHeaderTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: kLoginCardContentsPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: kLoginContentsSizedBoxHeight),
                            TextField(
                              obscureText: false,
                              style: kTextInputStyle,
                              onChanged: (value) => username = value,
                              decoration: InputDecoration(
                                errorText: errorOccurred
                                    ? kLoginUsernameErrorMssg
                                    : null,
                                contentPadding: kLoginInputPadding,
                                hintText: kLoginUsernameHint,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      kLoginInputBorderRadius),
                                ),
                              ),
                            ),
                            SizedBox(height: kLoginBetweenInputsSizedBoxHeight),
                            TextField(
                              obscureText: true,
                              style: kTextInputStyle,
                              onChanged: (value) => password = value,
                              decoration: InputDecoration(
                                errorText: errorOccurred
                                    ? kLoginPasswordErrorMssg
                                    : null,
                                contentPadding: kLoginInputPadding,
                                hintText: kLoginPasswordHint,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      kLoginInputBorderRadius),
                                ),
                              ),
                            ),
                            SizedBox(height: kLoginBetweenInputsSizedBoxHeight),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Text(kLoginButtonText),
                              onPressed: () {
                                setState(
                                  () {
                                    loginPressed = true;
                                  },
                                );
                                _login(username, password).then(
                                  (value) {
                                    if (value) {
                                      setState(() {
                                        loginPressed = false;
                                      });

                                      Navigator.pushNamed(
                                        context,
                                        kRouteInfoScreen,
                                      );
                                    } else {
                                      setState(
                                        () {
                                          loginPressed = false;
                                          errorOccurred = true;
                                        },
                                      );
                                    }
                                  },
                                );
                              },
                              color: Colors.lightBlue,
                              textColor: Colors.white,
                              splashColor: Colors.grey,
                            ),
                            SizedBox(
                              height: kLoginEndSizedBoxHeight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
