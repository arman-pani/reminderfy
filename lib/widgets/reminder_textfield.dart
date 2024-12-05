import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_remainder_app/constants/text_constants.dart';

class ReminderTextfield extends StatelessWidget {
  final TextEditingController controller;
  const ReminderTextfield({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    InputBorder textFieldInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white),
    );
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      cursorColor: Colors.white,
      cursorErrorColor: Colors.white,
      style: Theme.of(context).textTheme.titleMedium,
      controller: controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: textFieldInputBorder,
        focusedBorder: textFieldInputBorder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        hintStyle: Theme.of(context).textTheme.titleMedium,
        hintText: TextConstants.reminderHintText,
      ),
    );
  }
}
