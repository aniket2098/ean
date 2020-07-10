import 'dart:convert';

import 'package:ean/components/info_layout_card.dart';
import 'package:ean/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool isLoaded = false;
  bool errorOccured = false;

  List<int> info = [0, 0, 0, 0];

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString(kSharedPreferenceKey);
    final http.Response response = await http.post(
      kDataUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'token': token,
      }),
    );
    print(response.body);
    if (response.statusCode == kStatusCodeOk) {
      var decodedJson = json.decode(response.body);

      if (decodedJson['msg'] == kInfoSuccessMssg) {
        var data = decodedJson['data'];
        setState(() {
          for (int i = 0; i < data['count']; i++) {
            info[i] = data['list'][i]['value'];
          }
          isLoaded = true;
        });
      } else {
        setState(() {
          errorOccured = true;
        });
      }
    } else {
      setState(() {
        errorOccured = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded & !errorOccured) {
      getData();
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (width > height) {
      width = height;
    } else {
      height = width * kHeightMultiplicationFactor;
    }
    double padding = width / kPaddingDivisionFactor;
    height -= 2 * padding;
    width -= 2 * padding;
    return Scaffold(
      backgroundColor: fScaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(kTitle),
        backgroundColor: fAppBarBackGroundColor,
      ),
      body: !isLoaded
          ? errorOccured
              ? Center(
                  child: Text(
                    kErrorMssg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: kErrorMessageFontSize,
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    height: kCircularLoaderSideLength,
                    width: kCircularLoaderSideLength,
                    child: CircularProgressIndicator(),
                  ),
                )
          : Center(
              child: Container(
                color: Colors.transparent,
                height: height,
                width: width,
                padding: EdgeInsets.all(padding),
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              InfoLayoutCard(
                                title: kFE,
                                count: info[0],
                                fontSize: padding,
                              ),
                              VerticalDivider(
                                width: padding,
                                color: Colors.transparent,
                              ),
                              InfoLayoutCard(
                                title: kCS,
                                count: info[1],
                                fontSize: padding,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: padding,
                          color: Colors.transparent,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              InfoLayoutCard(
                                title: kIT,
                                count: info[2],
                                fontSize: padding,
                              ),
                              VerticalDivider(
                                color: Colors.transparent,
                                width: padding,
                              ),
                              InfoLayoutCard(
                                title: kEnTC,
                                count: info[3],
                                fontSize: padding,
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
    );
  }
}
