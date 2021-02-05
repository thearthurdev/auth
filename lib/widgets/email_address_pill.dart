import 'package:auth/utils/consts.dart';
import 'package:flutter/material.dart';

class EmailAddressPill extends StatelessWidget {
  const EmailAddressPill({
    Key key,
  }) : super(key: key);

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
            backgroundImage: NetworkImage(
                'https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70'),
          ),
          SizedBox(width: 12.0),
          Text(
            'jacob@gmail.com',
            style: kSubheaderTextStyle.copyWith(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
