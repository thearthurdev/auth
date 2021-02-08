import 'package:auth/pages/log_in_email_page.dart';
import 'package:auth/pages/sign_up_email_page.dart';
import 'package:auth/providers/authentication_provider.dart';
import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/flat_accent_button.dart';
import 'package:auth/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:auth/utils/navigator.dart';
import 'package:provider/provider.dart';

class SignUpUsernamePage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: MyFAB(
        icon: Icons.arrow_forward_rounded,
        onTap: () {
          context
              .read<AuthenticationProvider>()
              .setSignUpUsername(_usernameController.text);

          context.navigate(SignUpEmailPage());
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            actions: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  child: FlatAccentButton(
                    text: 'Log in',
                    heroTag: 'log in hero tag',
                    onTap: () => context.navigateReplace(LogInEmailPage()),
                  ),
                ),
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
                      controller: _usernameController,
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
