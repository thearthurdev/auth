import 'package:auth/services/authentication_service.dart';
import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/extended_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String id = '/HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Center(
        child: Text(
          'Welcome!',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MyExtendedFAB(
        child: 'Log out',
        onTap: () => context.read<AuthenticationService>().logOut(),
      ),
    );
  }
}
