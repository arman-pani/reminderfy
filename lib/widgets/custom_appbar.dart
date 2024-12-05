import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:simple_remainder_app/constants/text_constants.dart';

PreferredSizeWidget customAppBar({required BuildContext context}) {
  return AppBar(
    backgroundColor: Colors.black,
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Symbols.siren,
          size: 40,
          weight: 600,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Text(
          TextConstants.appBarTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ],
    ),
  );
}
