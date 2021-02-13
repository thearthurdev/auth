import 'package:auth/pages/new_password_page.dart';
import 'package:auth/utils/consts.dart';
import 'package:auth/widgets/email_address_pill.dart';
import 'package:auth/widgets/extended_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auth/utils/navigator.dart';

class ResetPasswordPage extends StatelessWidget {
  static const String id = '/ResetPasswordPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: MyExtendedFAB(
        child: 'Back to log in',
        onTap: () => context.popView(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
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
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/padlock.svg',
                              semanticsLabel: 'A red up arrow'),
                          SizedBox(height: 16.0),
                          Text(
                            "Reset your password",
                            style: kHeaderTextStyle,
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            margin: EdgeInsets.only(right: 32.0),
                            child: Text(
                              "A password reset link has been sent to your email address. Use it to reset your password.",
                              style: kSubheaderTextStyle,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          EmailAddressPill(),
                          SizedBox(height: 32.0),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () => context.navigate(NewPasswordPage()),
                              customBorder: RoundedRectangleBorder(
                                borderRadius: kCornerRadius,
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Resend link',
                                  style: kFlatAccentButtonTextStyle.copyWith(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
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
