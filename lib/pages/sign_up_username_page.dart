import 'package:auth/pages/log_in_email_page.dart';
import 'package:auth/pages/sign_up_email_page.dart';
import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/flat_accent_button.dart';
import 'package:auth/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:auth/utils/navigator.dart';

class SignUpUsernamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: MyFAB(
        icon: Icons.arrow_forward_rounded,
        onTap: () => context.navigate(
          SignUpEmailPage(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            actions: [
              FlatAccentButton(
                text: 'Log in',
                heroTag: 'log in hero tag',
                onTap: () => context.navigateReplace(LogInEmailPage()),
              ),
            ],
            backgroundColor: kPrimaryColor,
            expandedHeight: kToolbarHeight,
            pinned: true,
          ),
          SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.fromLTRB(24.0, 0.0, 16.0, 0.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      'Shall we get to know you?',
                      style: kHeaderTextStyle,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Your full name',
                      style: kSubheaderTextStyle,
                    ),
                    SizedBox(height: 36.0),
                    TextField(
                      cursorColor: kAccentColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: kHintTextStyle,
                        hintText: 'Full name here...',
                      ),
                      style: kTextFieldTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
