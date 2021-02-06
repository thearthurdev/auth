import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/extended_floating_action_button.dart';
import 'package:auth/widgets/validation_checkbox_list_tile.dart';
import 'package:flutter/material.dart';

class NewPasswordPage extends StatefulWidget {
  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController _textEditingController;
  ScrollController _scrollController;
  FocusNode _focusNode;

  bool _obscureText;
  bool _isValidPasswordLength;
  bool _isValidPasswordComplexity;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController()
      ..addListener(() => _textEditingControllerListener());
    _scrollController = ScrollController();
    _focusNode = FocusNode()..addListener(() => _focusNodeListener());

    _obscureText = true;
    _isValidPasswordLength = false;
    _isValidPasswordComplexity = false;
  }

  @override
  void dispose() {
    super.dispose();

    _textEditingController.dispose();
    // _focusNode.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: MyExtendedFAB(
        text: 'Reset password',
        isEnabled: _isValidPasswordLength && _isValidPasswordComplexity,
        onTap: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        controller: _scrollController,
        shrinkWrap: false,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            expandedHeight: kToolbarHeight,
            pinned: false,
          ),
          SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.fromLTRB(24.0, 0.0, 16.0, 0.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      "Get back your account.",
                      style: kHeaderTextStyle,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Provide a new password",
                      style: kSubheaderTextStyle,
                    ),
                    SizedBox(height: 36.0),
                    TextField(
                      focusNode: _focusNode,
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
