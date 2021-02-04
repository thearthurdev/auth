import 'package:auth/utils/consts.dart';
import 'package:flutter/material.dart';

class MyExtendedFAB extends StatelessWidget {
  const MyExtendedFAB(
      {Key key, @required String text, Function onTap, bool isEnabled = true})
      : _text = text,
        _onTap = onTap,
        _isEnabled = isEnabled,
        super(key: key);

  final String _text;
  final Function _onTap;
  final bool _isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: _isEnabled ? _onTap : null,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(13.0),
            decoration: BoxDecoration(
              color: _isEnabled ? kAccentColor : kAccentDisabledColor,
              borderRadius: kCornerRadius,
            ),
            child: Text(
              _text,
              textAlign: TextAlign.center,
              style: kRaisedAccentButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
