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

    String token = prefs.getString('pict_ean_admin');
    final http.Response response = await http.post(
      'https://studentdata11.herokuapp.com/data',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'token': token,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var decodedJson = json.decode(response.body);
      if (decodedJson['msg'] == 'Success') {
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
      height = width * 1.5;
    }
    double padding = width / 40;
    height -= 2 * padding;
    width -= 2 * padding;
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(kTitle),
        backgroundColor: kAppBarBackGroundColor,
      ),
      body: !isLoaded
          ? errorOccured
              ? Center(
                  child: Text(
                    'An Error Occured\nPlease Login Again',
                    style: TextStyle(
                      fontSize: 30.0,
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
                                title: 'FE',
                                count: info[0],
                                fontSize: padding,
                              ),
                              VerticalDivider(
                                width: padding,
                                color: Colors.transparent,
                              ),
                              InfoLayoutCard(
                                title: 'CS',
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
                                title: 'IT',
                                count: info[2],
                                fontSize: padding,
                              ),
                              VerticalDivider(
                                color: Colors.transparent,
                                width: padding,
                              ),
                              InfoLayoutCard(
                                title: 'ENTC',
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
