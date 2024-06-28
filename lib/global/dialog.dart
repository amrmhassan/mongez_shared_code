// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mongez_shared_code/constants/fast_theme.dart';
import 'package:shared_code_new/shared_code_new/constants/sizes.dart';
import 'package:shared_code_new/shared_code_new/helper/responsive.dart';

void showCustomDialog({
  required BuildContext context,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return CustomDialog();
    },
  );
}

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: kHPad,
            vertical: kVPad,
          ),
          constraints: BoxConstraints(
            minHeight: Responsive.getHeight(context) * .5,
            minWidth: Responsive.getWidth(context) * .5,
            maxHeight: Responsive.getHeight(context) * .9,
            maxWidth: Responsive.getWidth(context) * .9,
          ),
          decoration: BoxDecoration(
            color: cardColor(context),
            borderRadius: BorderRadius.circular(largeBorderRadius),
          ),
          child: ListView(
            children: [],
          ),
        ),
      ],
    );
  }
}
