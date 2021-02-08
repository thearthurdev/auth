import 'package:auth/pages/reset_password_page.dart';
import 'package:auth/pages/sign_up_email_page.dart';
import 'package:auth/providers/authentication_provider.dart';
import 'package:auth/services/authentication_service.dart';
import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/email_address_pill.dart';
import 'package:auth/widgets/extended_floating_action_button.dart';
import 'package:auth/widgets/flat_accent_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auth/utils/navigator.dart';
import 'package:provider/provider.dart';

class LogInPasswordPage extends StatefulWidget {
  @override
  _LogInPasswordPageState createState() => _LogInPasswordPageState();
}

class _LogInPasswordPageState extends State<LogInPasswordPage> {
  TextEditingController _passwordController;
  ScrollController _scrollController;
  FocusNode _focusNode;
  TapGestureRecognizer _tapGestureRecognizer;

  bool _obscureText;
  bool _enableLogInButton;

  @override
  void initState() {
    super.initState();

    _passwordController = TextEditingController()
      ..addListener(() => _passwordControllerListener());
    _scrollController = ScrollController();
    _focusNode = FocusNode()..addListener(() => _focusNodeListener());
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _handleResetPressed;

    _obscureText = true;
    _enableLogInButton = false;
  }

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
  }

  void _passwordControllerListener() {
    if (_passwordController.text.length > 0 && _enableLogInButton == false) {
      setState(() => _enableLogInButton = true);
    } else if (_passwordController.text.length < 1 &&
        _enableLogInButton == true) {
      setState(() => _enableLogInButton = false);
    }
  }

  void _focusNodeListener() {
    double maxScrollExtent = _scrollController.position.maxScrollExtent;

    Future.delayed(
      const Duration(seconds: 1),
      () => _scrollController.animateTo(maxScrollExtent + 40.0,
          duration: kShortDuration, curve: Curves.decelerate),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _handleResetPressed() {
    context.navigate(ResetPasswordPage());
  }

  void _signIn() {
    context
        .read<AuthenticationProvider>()
        .setSignInPassword(_passwordController.text);

    final String email = context.read<AuthenticationProvider>().logInEmail;

    final String password =
        context.read<AuthenticationProvider>().logInPassword;

    context.read<AuthenticationService>().logIn(context, email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: MyExtendedFAB(
        text: 'Log in',
        isEnabled: _enableLogInButton,
        onTap: () => _signIn(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        controller: _scrollController,
        shrinkWrap: false,
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
                    text: 'Sign up',
                    heroTag: 'sign up hero tag',
                    onTap: () => context.navigateReplace(SignUpEmailPage()),
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
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back!",
                            style: kHeaderTextStyle,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "Log in to your account",
                            style: kSubheaderTextStyle,
                          ),
                          SizedBox(height: 16.0),
                          EmailAddressPill(),
                          SizedBox(height: 36.0),
                          TextField(
                            focusNode: _focusNode,
                            controller: _passwordController,
                            cursorColor: kAccentColor,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: kHintTextStyle,
                              hintText: "Enter password",
                              suffixIcon: IconButton(
                                onPressed: () => _togglePasswordVisibility(),
                                color: kPrimaryTextColor,
                                icon: _obscureText
                                    ? Icon(Icons.visibility_outlined)
                                    : Icon(Icons.visibility_off_outlined),
                              ),
                            ),
                            style: kTextFieldTextStyle,
                          ),
                          SizedBox(height: 26.0),
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: 'Forgot your password? ',
                              style: kBodyTextStyle.copyWith(
                                fontSize: 14.0,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Reset',
                                  style: kFlatAccentButtonTextStyle.copyWith(
                                    fontSize: 14.0,
                                  ),
                                  recognizer: _tapGestureRecognizer,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 104.0),
                        ],
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
