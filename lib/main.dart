import 'package:auth/pages/sign_up_username_page.dart';
import 'package:auth/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(Auth());

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        title: 'Auth',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: kPrimaryColor,
          accentColor: kAccentColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignUpUsernamePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
