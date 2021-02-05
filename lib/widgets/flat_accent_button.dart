import 'package:auth/utils/consts.dart';
import 'package:flutter/material.dart';

class FlatAccentButton extends StatelessWidget {
  const FlatAccentButton({
    Key key,
    @required String text,
    @required String heroTag,
    Function onTap,
  })  : _text = text,
        _heroTag = heroTag,
        _onTap = onTap,
        super(key: key);

  final String _text;
  final String _heroTag;
  final Function _onTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _heroTag,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: _onTap,
              customBorder: RoundedRectangleBorder(
                borderRadius: kCornerRadius,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Text(
                  _text,
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
