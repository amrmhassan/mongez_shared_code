// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mongez_shared_code/features/auth/presentation/widgets/app_text_field.dart';
import 'package:shared_code_new/shared_code_new/constants/styles.dart';
import 'package:shared_code_new/shared_code_new/widgets/spaces/v_space.dart';

List<Widget> mainAuthInput({
  required BuildContext context,
  String? title,
  required String hint,
  TextEditingController? controller,
  bool password = false,
  String? error,
  bool enabled = true,
  String? svgIconPath,
  Function(String value)? onChange,
  TextInputType? textInputType,
  bool web = false,
}) {
  return [
    if (title != null)
      Row(
        children: [
          Text(
            title,
            style: bodyMedium(context),
          ),
        ],
      ),
    VSpace(factor: .5),
    AppTextField(
      error: error,
      hint: hint,
      controller: controller,
      password: password,
      enabled: enabled,
      svgIconPath: svgIconPath,
      onChange: onChange,
      textInputType: textInputType,
      web: web,
    ),
  ];
}
