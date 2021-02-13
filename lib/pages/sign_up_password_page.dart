import 'package:auth/pages/log_in_email_page.dart';
import 'package:auth/providers/authentication_provider.dart';
import 'package:auth/services/authentication_service.dart';
import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/extended_floating_action_button.dart';
import 'package:auth/widgets/flat_accent_button.dart';
import 'package:auth/widgets/validation_checkbox_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:auth/utils/navigator.dart';
import 'package:provider/provider.dart';

class SignUpPasswordPage extends StatefulWidget {
  static const String id = '/SignUpPasswordPage';

  @override
  _SignUpPasswordPageState createState() => _SignUpPasswordPageState();
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage> {
  TextEditingController _passwordController;
  ScrollController _scrollController;
  FocusNode _focusNode;

  bool _obscureText;
  bool _isValidPasswordLength;
  bool _isValidPasswordComplexity;
  bool _isProcessing;

  @override
  void initState() {
    super.initState();

    _passwordController = TextEditingController()
      ..addListener(() => _passwordControllerListener());
    _scrollController = ScrollController();
    _focusNode = FocusNode()..addListener(() => _focusNodeListener());

    _obscureText = true;
    _isValidPasswordLength = false;
    _isValidPasswordComplexity = false;
    _isProcessing = false;
  }

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
    // _focusNode.dispose();
  }

  void _passwordControllerListener() {
    if (_passwordController.text.length >= 8 &&
        _isValidPasswordLength == false) {
      setState(() => _isValidPasswordLength = true);
    } else if (_passwordController.text.length < 8 &&
        _isValidPasswordLength == true) {
      setState(() => _isValidPasswordLength = false);
    }

    if (_isPasswordCompliant(_passwordController.text) &&
        _isValidPasswordComplexity == false) {
      setState(() => _isValidPasswordComplexity = true);
    } else if (!_isPasswordCompliant(_passwordController.text) &&
        _isValidPasswordComplexity == true) {
      setState(() => _isValidPasswordComplexity = false);
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

  bool _isPasswordCompliant(String password) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));

    return hasDigits & hasUppercase & hasLowercase;
  }

  void _signUp() async {
    setState(() => _isProcessing = true);
    context
        .read<AuthenticationProvider>()
        .setSignUpPassword(_passwordController.text);

    final String email = context.read<AuthenticationProvider>().signUpEmail;

    final String password =
        context.read<AuthenticationProvider>().signUpPassword;

    await context.read<AuthenticationService>().signUp(email, password);
    setState(() => _isProcessing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: MyExtendedFAB(
        child: _isProcessing
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                ),
              )
            : 'Create account',
        isEnabled: _isValidPasswordLength && _isValidPasswordComplexity,
        onTap: () => _signUp(),
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
                      "Lastly, make your account secure.",
                      style: kHeaderTextStyle,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Add a password",
                      style: kSubheaderTextStyle,
                    ),
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
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      style: kTextFieldTextStyle,
                    ),
                    SizedBox(height: 43.0),
                    ValidationCheckboxListTile(
                      title: 'Your password should be 8+ letters long.',
                      validation: _isValidPasswordLength,
                    ),
                    SizedBox(height: 13.0),
                    ValidationCheckboxListTile(
                      title:
                          'It should have at least a number and an uppercase letter.',
                      validation: _isValidPasswordComplexity,
                    ),
                    SizedBox(height: 104.0),
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
