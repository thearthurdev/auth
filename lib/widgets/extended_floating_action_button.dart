import 'package:auth/utils/consts.dart';
import 'package:flutter/material.dart';

class MyExtendedFAB extends StatelessWidget {
  const MyExtendedFAB({
    Key key,
    @required dynamic child,
    Function onTap,
    bool isEnabled = true,
    dynamic heroTag,
  })  : _child = child,
        _onTap = onTap,
        _isEnabled = isEnabled,
        _heroTag = heroTag,
        super(key: key);

  final dynamic _child;
  final Function _onTap;
  final bool _isEnabled;
  final dynamic _heroTag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _heroTag ?? 'fab_hero_tag',
      child: Container(
        height: 48.0,
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
              child: FittedBox(
                child: _child is String
                    ? Text(
                        _child,
                        textAlign: TextAlign.center,
                        style: kRaisedAccentButtonTextStyle,
                      )
                    : _child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
