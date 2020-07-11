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
  bool _isLoaded = false;
  bool _errorOccured = false;

  List<int> _info = [0, 0, 0, 0];

  void _getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    String _token = _prefs.getString(kSharedPreferenceKey);
    final http.Response _response = await http.post(
      kDataUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'token': _token,
      }),
    );

    if (_response.statusCode == kStatusCodeOk) {
      var decodedJson = json.decode(_response.body);

      if (decodedJson['msg'] == kInfoSuccessMssg) {
        var data = decodedJson['data'];
        setState(() {
          for (int i = 0; i < data['count']; i++) {
            _info[i] = data['list'][i]['value'];
          }
          _isLoaded = true;
        });
      } else {
        setState(() {
          _errorOccured = true;
        });
      }
    } else {
      setState(() {
        _errorOccured = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded & !_errorOccured) {
      _getData();
    }
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    if (_width > _height) {
      _width = _height;
    } else {
      _height = _width * kHeightMultiplicationFactor;
    }
    double padding = _width / kPaddingDivisionFactor;
    _height -= 2 * padding;
    _width -= 2 * padding;
    return Scaffold(
      backgroundColor: fScaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(kTitle),
        backgroundColor: fAppBarBackGroundColor,
      ),
      body: !_isLoaded
          ? _errorOccured
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
                height: _height,
                width: _width,
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
                                count: _info[0],
                                fontSize: padding,
                              ),
                              VerticalDivider(
                                width: padding,
                                color: Colors.transparent,
                              ),
                              InfoLayoutCard(
                                title: kCS,
                                count: _info[1],
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
                                count: _info[2],
                                fontSize: padding,
                              ),
                              VerticalDivider(
                                color: Colors.transparent,
                                width: padding,
                              ),
                              InfoLayoutCard(
                                title: kEnTC,
                                count: _info[3],
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
