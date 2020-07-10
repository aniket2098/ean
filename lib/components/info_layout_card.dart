import 'package:ean/utils/constants.dart';
import 'package:flutter/material.dart';

class InfoLayoutCard extends StatelessWidget {
  final String title;
  final int count;
  final double fontSize;

  const InfoLayoutCard({
    @required this.title,
    @required this.count,
    @required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: kInfoLayoutCardElevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kInfoLayoutCardBorderRadius),
          topRight: Radius.circular(6),
          bottomLeft: Radius.circular(kInfoLayoutCardBorderRadius),
          bottomRight: Radius.circular(kInfoLayoutCardBorderRadius),
        )),
        color: kInfoLayoutCardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kInfoLayoutCardBorderRadius),
                    topRight: Radius.circular(5),
                    bottomRight:
                        Radius.circular(kInfoLayoutCardBorderRadius + 10)),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(
                    fontSize * kInfoLayoutCardTitleMultiplicationFactor),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: kInfoLayoutCardTitleTextStyle.copyWith(
                    fontSize:
                        fontSize * kInfoLayoutCardTitleMultiplicationFactor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Count : $count',
                  style: kInfoLayoutCardInfoTextStyle.copyWith(
                    fontSize:
                        fontSize * kInfoLayoutCardInfoMultiplicationFactor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
