import 'package:auth/pages/log_in_email_page.dart';
import 'package:auth/pages/sign_up_email_page.dart';
import 'package:auth/services/authentication_service.dart';
import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/flat_accent_button.dart';
import 'package:auth/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:auth/utils/navigator.dart';
import 'package:provider/provider.dart';

class SignUpUsernamePage extends StatefulWidget {
  static const String id = '/SignUpUsernamePage';

  @override
  _SignUpUsernamePageState createState() => _SignUpUsernamePageState();
}

class _SignUpUsernamePageState extends State<SignUpUsernamePage> {
  TextEditingController _usernameController;

  bool _enableNextButton;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController()
      ..addListener(() => _usernameControllerListener());

    _enableNextButton = false;
  }

  @override
  void dispose() {
    super.dispose();

    _usernameController.dispose();
  }

  void _usernameControllerListener() {
    if (_usernameController.text.length > 0 && _enableNextButton == false) {
      setState(() => _enableNextButton = true);
    } else if (_usernameController.text.length < 1 &&
        _enableNextButton == true) {
      setState(() => _enableNextButton = false);
    }
  }

  void _proceed(BuildContext context) {
    if (_enableNextButton) {
      context
          .read<AuthenticationService>()
          .setUsername(_usernameController.text);

      context.navigate(SignUpEmailPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: MyFAB(
        icon: Icons.arrow_forward_rounded,
        isEnabled: _enableNextButton,
        onTap: () => _proceed(context),
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
                    heroTag: 'log_in_hero_tag',
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
                    Hero(
                      tag: 'username_hero_tag',
                      child: Material(
                        type: MaterialType.transparency,
                        child: TextField(
                          controller: _usernameController,
                          cursorColor: kAccentColor,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => _proceed(context),
                          style: kTextFieldTextStyle,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: kHintTextStyle,
                            hintText: 'Full name here...',
                          ),
                        ),
                      ),
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
