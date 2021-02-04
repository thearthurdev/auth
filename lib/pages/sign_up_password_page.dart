import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/extended_floating_action_button.dart';
import 'package:auth/widgets/flat_accent_button.dart';
import 'package:auth/widgets/validation_checkbox_list_tile.dart';
import 'package:flutter/material.dart';

class SignUpPasswordPage extends StatefulWidget {
  @override
  _SignUpPasswordPageState createState() => _SignUpPasswordPageState();
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage> {
  TextEditingController _textEditingController;

  bool _obscureText;
  bool _isValidPasswordLength;
  bool _isValidPasswordComplexity;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController()
      ..addListener(() => _textEditingControllerListener());

    _obscureText = true;
    _isValidPasswordLength = false;
    _isValidPasswordComplexity = false;
  }

  @override
  void dispose() {
    super.dispose();

    _textEditingController.dispose();
  }

  void _textEditingControllerListener() {
    if (_textEditingController.text.length >= 8 &&
        _isValidPasswordLength == false) {
      setState(() => _isValidPasswordLength = true);
    } else if (_textEditingController.text.length < 8 &&
        _isValidPasswordLength == true) {
      setState(() => _isValidPasswordLength = false);
    }

    if (_isPasswordCompliant(_textEditingController.text) &&
        _isValidPasswordComplexity == false) {
      setState(() => _isValidPasswordComplexity = true);
    } else if (!_isPasswordCompliant(_textEditingController.text) &&
        _isValidPasswordComplexity == true) {
      setState(() => _isValidPasswordComplexity = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: MyExtendedFAB(
        text: 'Create account',
        isEnabled: _isValidPasswordLength && _isValidPasswordComplexity,
        onTap: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                child: BackButton(),
              ),
            ),
            actions: [FlatAccentButton(text: "Log in")],
            backgroundColor: kPrimaryColor,
            expandedHeight: kToolbarHeight,
            pinned: true,
          ),
          SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0.0),
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
                      controller: _textEditingController,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
}
