import 'package:auth/pages/log_in_password_page.dart';
import 'package:auth/pages/sign_up_username_page.dart';
import 'package:auth/providers/authentication_provider.dart';
import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/extended_floating_action_button.dart';
import 'package:auth/widgets/flat_accent_button.dart';
import 'package:flutter/material.dart';
import 'package:auth/utils/navigator.dart';
import 'package:provider/provider.dart';

class LogInEmailPage extends StatefulWidget {
  static const String id = '/LogInEmailPage';

  @override
  _LogInEmailPageState createState() => _LogInEmailPageState();
}

class _LogInEmailPageState extends State<LogInEmailPage> {
  TextEditingController _emailController;
  ScrollController _scrollController;
  FocusNode _focusNode;

  bool _enableNextButton;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController()
      ..addListener(() => _emailControllerListener());
    _scrollController = ScrollController();
    _focusNode = FocusNode()..addListener(() => _focusNodeListener());

    _enableNextButton = false;
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
  }

  void _emailControllerListener() {
    if (_emailController.text.length > 0 && _enableNextButton == false) {
      setState(() => _enableNextButton = true);
    } else if (_emailController.text.length < 1 &&
        _enableNextButton == true) {
      setState(() => _enableNextButton = false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MyExtendedFAB(
        child: 'Next',
        isEnabled: _enableNextButton,
        onTap: () {
          context
              .read<AuthenticationProvider>()
              .setSignInEmail(_emailController.text);

          context.navigate(
            LogInPasswordPage(),
          );
        },
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            actions: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  child: FlatAccentButton(
                    text: "Sign up",
                    heroTag: 'sign up hero tag',
                    onTap: () => context.navigateReplace(SignUpUsernamePage()),
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
                      "Welcome back!",
                      style: kHeaderTextStyle,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Log in to your account",
                      style: kSubheaderTextStyle,
                    ),
                    SizedBox(height: 36.0),
                    TextField(
                      focusNode: _focusNode,
                      controller: _emailController,
                      cursorColor: kAccentColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: kHintTextStyle,
                        hintText: "Email address",
                      ),
                      keyboardType: TextInputType.emailAddress,
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
