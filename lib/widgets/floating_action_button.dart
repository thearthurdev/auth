import 'package:auth/utils/consts.dart';
import 'package:flutter/material.dart';

class MyFAB extends StatelessWidget {
  const MyFAB({
    Key key,
    this.onTap,
    this.icon,
    this.isEnabled = true,
    this.heroTag,
  }) : super(key: key);

  final Function onTap;
  final IconData icon;
  final bool isEnabled;
  final dynamic heroTag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag ?? "MyFAB hero",
      child: Container(
        width: 48.0,
        height: 48.0,
        child: Material(
          color: isEnabled ? kAccentColor : kAccentDisabledColor,
          shape: CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: CircleBorder(),
            child: Icon(
              icon,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
