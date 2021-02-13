import 'package:auth/pages/log_in_email_page.dart';
import 'package:auth/services/authentication_service.dart';
import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/extended_floating_action_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth/utils/navigator.dart';

class HomePage extends StatelessWidget {
  static const String id = '/HomePage';

  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.read<User>();

    final _username = context.read<AuthenticationService>().username ??
        _firebaseUser.displayName;

    Future<void> _logOut(BuildContext context) async {
      try {
        context.navigateReplace(LogInEmailPage());
        await context.read<AuthenticationService>().logOut();
      } catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Center(
        child: Text(
          'Welcome! $_username',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MyExtendedFAB(
        child: 'Log out',
        onTap: () => _logOut(context),
      ),
    );
  }
}
