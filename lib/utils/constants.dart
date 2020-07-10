import 'package:flutter/material.dart';

//Numeric Constants
const kInfoLayoutCardElevation = 10.0;
const kInfoLayoutCardBorderRadius = 35.0;
const kInfoLayoutCardTitleMultiplicationFactor = 1.5;
const kInfoLayoutCardInfoMultiplicationFactor = 2;
const kInfoLayoutCardTitleOpacity = 0.7;

const kHeightMultiplicationFactor = 1.5;
const kPaddingDivisionFactor = 40;
const kCircularLoaderSideLength = 50.0;
const kErrorMessageFontSize = 30.0;

const kLoginDefaultContainerWidth = 350.0;
const kLoginCardBorderRadius = 30.0;
const kLoginHeaderContainerHeight = 60.0;
const kLoginContentsSizedBoxHeight = 100.0;
const kLoginInputBorderRadius = 32.0;
const kLoginBetweenInputsSizedBoxHeight = 40.0;
const kLoginEndSizedBoxHeight = 60.0;
const kStatusCodeOk = 200;

//String Constants
const kTitle = 'EAN';
const kLoginUrl = 'https://studentdata11.herokuapp.com/login';
const kDataUrl = 'https://studentdata11.herokuapp.com/data';
const kSharedPreferenceKey = 'pict_ean_admin';
const kInfoSuccessMssg = 'Success';
const kLoginSuccessMssg = 'Login Success';
const kErrorMssg = 'An Error Occured\nPlease Login Again';
const kFE = 'FE';
const kCS = 'CS';
const kIT = 'IT';
const kEnTC = 'EnTC';
const kLoginHeader = 'LOGIN';
const kLoginUsernameErrorMssg = 'Invalid Username!';
const kLoginUsernameHint = 'Username';
const kLoginPasswordErrorMssg = 'Invalid Password!';
const kLoginPasswordHint = 'Password';
const kLoginButtonText = 'GO';

const kRouteInfoScreen = '/InfoScreen';
const kRouteLoginScreen = '/';

//Colors
const kInfoLayoutCardColor = Color(0xFF374785);
final fScaffoldBackgroundColor = Colors.blueGrey[100];
final fAppBarBackGroundColor = Colors.blue[800];

//Padding constants
const kLoginCardPadding = EdgeInsets.all(8.0);
const kLoginCardContentsPadding = EdgeInsets.all(16.0);
const kLoginInputPadding = EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0);

//TextStyle constants
final fInfoLayoutCardTitleTextStyle = TextStyle(
  color: Colors.black.withOpacity(kInfoLayoutCardTitleOpacity),
  fontWeight: FontWeight.bold,
);
const kInfoLayoutCardInfoTextStyle = TextStyle(
  color: Colors.white,
);
const kTextInputStyle = TextStyle(fontSize: 15.0);
const kLoginHeaderTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 30.0,
  letterSpacing: 3.0,
);

final fLoginHeaderBoxShadow = BoxShadow(
  color: Colors.grey[900],
  blurRadius: 10.0,
  offset: Offset(0.0, 0.75),
);
