// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mongez_shared_code/features/auth/presentation/widgets/app_text_field.dart';
import 'package:mongez_shared_code/features/office/data/datasources/office_datasource.dart';
import 'package:mongez_shared_code/features/office/data/models/office_model.dart';
import 'package:mongez_shared_code/global/widgets/dialog_title.dart';
import 'package:mongez_shared_code/global/height_space.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';
import 'package:shared_code_new/shared_code_new.dart';
import 'package:shared_code_new/shared_code_new/helper/responsive.dart';
import 'package:shared_code_new/shared_code_new/utils/app_routes.dart';
import 'package:shared_code_new/shared_code_new/widgets/buttons/app_main_button.dart';

class AddOfficeDialog extends StatefulWidget {
  final OfficeModel? toUpdate;
  const AddOfficeDialog({
    super.key,
    this.toUpdate,
  });

  @override
  State<AddOfficeDialog> createState() => _AddOfficeDialogState();
}

class _AddOfficeDialogState extends State<AddOfficeDialog> {
  bool loading = false;
  final OfficeDatasource officeDatasource = OfficeDatasource();
  void initUpdate() {
    if (widget.toUpdate == null) return;
    officeName.text = widget.toUpdate!.officeName;
    managerName.text = widget.toUpdate!.managerName;
    managerPhoneNumber.text = widget.toUpdate!.managerPhoneNumber;
    loginEmail.text = widget.toUpdate!.email;
    loginPassword.text = widget.toUpdate!.password;
  }

  Future<void> _saveOffice() async {
    try {
      loading = true;
      setState(() {});
      var model = await officeDatasource.createOffice(
        officeName: officeName.text,
        managerName: managerName.text,
        managerPhoneNumber: managerPhoneNumber.text,
        email: loginEmail.text,
        password: loginPassword.text,
      );
      AppRoutes.pop(
        context,
        model,
      );
    } catch (e, s) {
      logger.e(e);
      logger.e(s);
      globalUtils.errorSnackbar(e);
    }
    loading = false;
    setState(() {});
  }

  Future<void> handleClick() {
    if (widget.toUpdate == null) {
      return _saveOffice();
    } else {
      return _updateOffice();
    }
  }

  Future<void> _updateOffice() async {
    try {
      loading = true;
      setState(() {});
      var model = await officeDatasource.updateOffice(
        widget.toUpdate!,
        officeName: officeName.text,
        managerName: managerName.text,
        managerPhoneNumber: managerPhoneNumber.text,
      );
      AppRoutes.pop(
        context,
        model,
      );
    } catch (e, s) {
      logger.e(e);
      logger.e(s);
      globalUtils.errorSnackbar(e);
    }
    loading = false;
    setState(() {});
  }

  final officeName = TextEditingController();
  final managerName = TextEditingController();
  final managerPhoneNumber = TextEditingController();
  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();

  @override
  void initState() {
    initUpdate();
    super.initState();
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
              DialogTitle(
                title: widget.toUpdate == null ? 'Add Office' : 'Update Office',
              ),
              Row(
                children: [
                  Expanded(
                      child: FancyTextField(
                    padding: EdgeInsets.zero,
                    hint: 'Enter office name',
                    controller: officeName,
                  )),
                  WidthSpace(10),
                  Expanded(
                      child: FancyTextField(
                    padding: EdgeInsets.zero,
                    hint: 'Enter Manager name',
                    controller: managerName,
                  )),
                ],
              ),
              HeightSpace(10),
              FancyTextField(
                padding: EdgeInsets.zero,
                hint: 'Enter Manager Phone number',
                controller: managerPhoneNumber,
              ),
              HeightSpace(10),
              if (widget.toUpdate == null)
                Row(
                  children: [
                    Expanded(
                        child: FancyTextField(
                      padding: EdgeInsets.zero,
                      hint: 'Enter login email',
                      controller: loginEmail,
                    )),
                    WidthSpace(10),
                    Expanded(
                      child: AppTextField(
                        hint: 'Enter login password',
                        controller: loginPassword,
                        password: true,
                      ),
                    ),
                  ],
                ),
              if (widget.toUpdate == null) HeightSpace(10),
              AppMainButton(
                active: !loading,
                onTap: handleClick,
                title: widget.toUpdate == null ? 'Add Office' : 'Update Office',
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
