import 'package:auth/utils/consts.dart';
import 'package:flutter/material.dart';

class ValidationCheckboxListTile extends StatelessWidget {
  const ValidationCheckboxListTile(
      {Key key, @required String title, @required bool validation})
      : _title = title,
        _validation = validation,
        super(key: key);

  final String _title;
  final bool _validation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 24.0),
      child: Row(
        children: [
          Icon(
            _validation
                ? Icons.check_circle_sharp
                : Icons.radio_button_off_outlined,
            color: kAccentColor,
          ),
          SizedBox(width: 18.0),
          Flexible(
            child: Text(
              _title,
              style: kValidationHintTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
