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

  navigateReplaceAll(Widget route) => Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (context) => route),
        (route) => false,
      );

  popToFirst(BuildContext context) =>
      Navigator.of(context).popUntil((route) => route.isFirst);

  popView(BuildContext context) => Navigator.pop(context);
}
