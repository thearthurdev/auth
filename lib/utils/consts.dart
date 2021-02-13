import 'package:flutter/material.dart';

BorderRadiusGeometry kCornerRadius = BorderRadius.circular(4.0);
const Duration kShortDuration = Duration(milliseconds: 300);

const Color kPrimaryColor = Color(0xFF004257);
const Color kAccentColor = Color(0xFF2EE9D7);
const Color kAccentDisabledColor = Color(0xFF127B7E);
const Color kPrimaryTextColor = Color(0xFFFFFFFF);
const Color kHintTextColor = Color(0x80FFFFFF);
const Color kErrorTextColor = Color(0xFFFF8282);
const Color kValidationHintTextColor = Color(0xFF80A0AB);

const TextStyle kHeaderTextStyle = TextStyle(
  fontFamily: 'merriweather',
  fontSize: 22.0,
  letterSpacing: 0.2,
  color: kPrimaryTextColor,
  fontWeight: FontWeight.bold,
);

const TextStyle kSubheaderTextStyle = TextStyle(
  fontFamily: 'sen',
  fontSize: 14.0,
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w400,
  height: 1.5,
);

const TextStyle kHintTextStyle = TextStyle(
  fontFamily: 'sen',
  fontSize: 16.0,
  color: kHintTextColor,
);

const TextStyle kBodyTextStyle = TextStyle(
  fontFamily: 'sen',
  fontSize: 16.0,
  color: kPrimaryTextColor,
);

const TextStyle kTextFieldTextStyle = TextStyle(
  fontFamily: 'sen',
  fontSize: 18.0,
  color: kPrimaryTextColor,
);

const TextStyle kFlatAccentButtonTextStyle = TextStyle(
  fontFamily: 'sen',
  fontSize: 16.0,
  color: kAccentColor,
  fontWeight: FontWeight.w700,
);

const TextStyle kRaisedAccentButtonTextStyle = TextStyle(
  fontFamily: 'sen',
  fontSize: 16.0,
  color: kPrimaryColor,
  fontWeight: FontWeight.w700,
);

const TextStyle kValidationHintTextStyle = TextStyle(
  fontFamily: 'sen',
  fontSize: 14.0,
  color: kValidationHintTextColor,
  fontWeight: FontWeight.w500,
);

const TextStyle kErrorTextStyle = TextStyle(
  fontFamily: 'sen',
  fontSize: 12.0,
  color: kErrorTextColor,
);
