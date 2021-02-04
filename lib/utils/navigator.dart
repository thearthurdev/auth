import 'package:flutter/material.dart';

extension MyNavigator on BuildContext {
  navigate(Widget route, {isDialog = false}) => Navigator.push(
        this,
        MaterialPageRoute(
            fullscreenDialog: isDialog, builder: (context) => route),
      );

  navigateReplace(Widget route, {isDialog = false}) =>
      Navigator.pushReplacement(
        this,
        MaterialPageRoute(
            fullscreenDialog: isDialog, builder: (context) => route),
      );

  popToFirst(BuildContext context) =>
      Navigator.of(context).popUntil((route) => route.isFirst);

  popView(BuildContext context) => Navigator.pop(context);
}
