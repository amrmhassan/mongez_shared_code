// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mongez_shared_code/global/height_space.dart';

class DialogTitle extends StatelessWidget {
  final String title;
  const DialogTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        HeightSpace(10),
      ],
    );
  }
}
