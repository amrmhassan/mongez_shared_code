import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';

class UserCellCopier extends StatelessWidget {
  final String? content;
  final String? copyMsg;
  final String? shownTxt;
  const UserCellCopier(
    this.content, {
    super.key,
    this.copyMsg,
    this.shownTxt,
  });

  String get text {
    String? txt = shownTxt ?? content;

    return (txt ?? '').isEmpty ? 'Unknown' : txt!;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (content != null || content.toString().isNotEmpty) {
            Clipboard.setData(ClipboardData(text: content!));
            globalUtils.showSnackBar(
              context: context,
              message: copyMsg ?? 'Copied to clipboard',
            );
          }
        },
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
