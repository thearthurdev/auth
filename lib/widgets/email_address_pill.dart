import 'package:auth/utils/consts.dart';
import 'package:flutter/material.dart';

class EmailAddressPill extends StatelessWidget {
  const EmailAddressPill({
    Key key,
    @required String email,
  })  : _email = email,
        super(key: key);

  final String _email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(4.0, 4.0, 16.0, 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color(0x32000000),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 12.0,
            backgroundColor: kPrimaryColor,
            child: Icon(
              Icons.person,
              size: 16.0,
            ),
          ),
          SizedBox(width: 12.0),
          Hero(
            tag: 'email_hero_tag',
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                _email,
                style: kSubheaderTextStyle.copyWith(fontSize: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
