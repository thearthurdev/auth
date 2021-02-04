import 'package:auth/utils/consts.dart';
import 'package:flutter/material.dart';

class FlatAccentButton extends StatelessWidget {
  const FlatAccentButton({Key key, this.onTap, this.text}) : super(key: key);

  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Log in hero",
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              customBorder: RoundedRectangleBorder(
                borderRadius: kCornerRadius,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Text(
                  text,
                  style: kFlatAccentButtonTextStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
