// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mongez_shared_code/features/office/data/datasources/office_datasource.dart';
import 'package:mongez_shared_code/features/office/data/models/office_model.dart';
import 'package:mongez_shared_code/global/widgets/dialog_title.dart';
import 'package:mongez_shared_code/global/height_space.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';
import 'package:shared_code_new/shared_code_new/helper/responsive.dart';
import 'package:shared_code_new/shared_code_new/utils/app_routes.dart';
import 'package:shared_code_new/shared_code_new/widgets/buttons/app_main_button.dart';

class DeleteOfficeDialog extends StatefulWidget {
  final OfficeModel model;
  const DeleteOfficeDialog({
    super.key,
    required this.model,
  });

  @override
  State<DeleteOfficeDialog> createState() => _DeleteOfficeDialogState();
}

class _DeleteOfficeDialogState extends State<DeleteOfficeDialog> {
  bool loading = false;
  final OfficeDatasource officeDatasource = OfficeDatasource();

  Future<void> delete() async {
    try {
      loading = true;
      setState(() {});
      await officeDatasource.deleteOffice(
        widget.model.id,
      );
      AppRoutes.pop(
        context,
        widget.model,
      );
    } catch (e, s) {
      logger.e(e);
      logger.e(s);
      globalUtils.errorSnackbar(e);
    }
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 12,
          ),
          width: Responsive.getWidthPercentage(context, .9),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              DialogTitle(title: 'Delete Office'),
              Row(
                children: [
                  Text('Delete the office (${widget.model.officeName})?'),
                ],
              ),
              HeightSpace(20),
              AppMainButton(
                active: !loading,
                onTap: delete,
                title: 'Delete Office',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
