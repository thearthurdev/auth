import 'package:auth/pages/log_in_email_page.dart';
import 'package:auth/pages/sign_up_password_page.dart';
import 'package:auth/providers/authentication_provider.dart';
import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/flat_accent_button.dart';
import 'package:auth/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:auth/utils/navigator.dart';
import 'package:provider/provider.dart';

class SignUpEmailPage extends StatefulWidget {
  static const String id = '/SignUpEmailPage';

  @override
  _SignUpEmailPageState createState() => _SignUpEmailPageState();
}

class _SignUpEmailPageState extends State<SignUpEmailPage> {
  TextEditingController _emailController;

  bool _enableNextButton;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController()
      ..addListener(() => _emailControllerListener());

    _enableNextButton = false;
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
  }

  void _emailControllerListener() {
    if (_emailController.text.length > 0 && _enableNextButton == false) {
      setState(() => _enableNextButton = true);
    } else if (_emailController.text.length < 1 && _enableNextButton == true) {
      setState(() => _enableNextButton = false);
    }
  }

  void _proceed(BuildContext context) {
    if (_enableNextButton) {
      context
          .read<AuthenticationProvider>()
          .setSignUpEmail(_emailController.text);

      context.navigate(SignUpPasswordPage());
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
            leading: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                child: BackButton(),
              ),
            ),
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
                    Row(
                      children: [
                        Text(
                          "Nice, ",
                          style: kHeaderTextStyle,
                        ),
                        Hero(
                          tag: "username hero tag",
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              context
                                  .read<AuthenticationProvider>()
                                  .signUpUsername
                                  .toString()
                                  .split(" ")[0],
                              style: kHeaderTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Your email address",
                      style: kSubheaderTextStyle,
                    ),
                    SizedBox(height: 36.0),
                    TextField(
                      controller: _emailController,
                      cursorColor: kAccentColor,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _proceed(context),
                      style: kTextFieldTextStyle,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: kHintTextStyle,
                        hintText: "Email address here...",
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
