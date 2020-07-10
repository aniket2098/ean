import 'dart:convert';

import 'package:ean/components/info_layout_card.dart';
import 'package:ean/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoaded = false;

  List<int> info = [0, 0, 0, 0];
  void getData() async {
    final http.Response response = await http.post(
      'https://studentdata11.herokuapp.com/data',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiAiQXV0aC1TZXJ2aWNlIiwgImlhdCI6IDE1OTQzNzQ5MTksICJleHAiOiAxNTk0Mzc4NTE5LCAic3ViIjogeyJyb2xlIjogImFkbWluIiwgImlkIjogMX19.r-Og2GTe7vQY6h_ICUIvE7xqasyXoD2AvBrIZch1h4Ktl8jW90yqVfzSDPf4ckDSpDly1NHDN-6LVFhxEtuQ2ZgYc3lLtnzlrOgjMeDi_309TRZ0iQUJqTW8Fhr0bzqCFTGgta6fgs88L5PYWMVWrXLuEyIpqXUJADfePpQSVsY',
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var decodedJson = json.decode(response.body);
      var data = decodedJson['data'];
      setState(() {
        for (int i = 0; i < data['count']; i++) {
          info[i] = data['list'][i]['value'];
        }
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
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
    return !isLoaded
        ? Center(
            child: Container(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: kScaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(kTitle),
              backgroundColor: kAppBarBackGroundColor,
            ),
            body: Center(
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
