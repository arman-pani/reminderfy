import 'package:flutter/material.dart';
import 'package:simple_remainder_app/constants/colors_constants.dart';
import 'package:simple_remainder_app/models/reminder_model.dart';

extension ReminderTagExtension on Tag {
  String get label {
    switch (this) {
      case Tag.daily:
        return "Daily";
      case Tag.personal:
        return "Personal";
      case Tag.work:
        return "Work";
    }
  }

  Color get color {
    switch (this) {
      case Tag.daily:
        return ColorsConstants.yellowColor;
      case Tag.personal:
        return ColorsConstants.redColor;
      case Tag.work:
        return ColorsConstants.blueColor;
    }
  }
}
