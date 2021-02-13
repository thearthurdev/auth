import 'package:auth/utils/consts.dart';
import 'package:flutter/material.dart';

class MyFAB extends StatelessWidget {
  const MyFAB({
    Key key,
    @required IconData icon,
    Function onTap,
    bool isEnabled = true,
    dynamic heroTag,
  })  : _icon = icon,
        _onTap = onTap,
        _isEnabled = isEnabled,
        _heroTag = heroTag,
        super(key: key);

  final IconData _icon;
  final Function _onTap;
  final bool _isEnabled;
  final dynamic _heroTag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _heroTag ?? 'fab_hero_tag',
      child: Container(
        width: 48.0,
        height: 48.0,
        child: Material(
          color: _isEnabled ? kAccentColor : kAccentDisabledColor,
          shape: CircleBorder(),
          child: InkWell(
            onTap: _isEnabled ? _onTap : null,
            customBorder: CircleBorder(),
            child: Icon(
              _icon,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
