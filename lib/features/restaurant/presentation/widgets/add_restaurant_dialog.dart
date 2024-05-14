// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mongez_shared_code/features/auth/presentation/widgets/app_text_field.dart';
import 'package:mongez_shared_code/features/restaurant/data/datasources/restaurant_datasource.dart';
import 'package:mongez_shared_code/features/restaurant/data/models/restaurant_model.dart';
import 'package:mongez_shared_code/global/widgets/dialog_title.dart';
import 'package:mongez_shared_code/global/height_space.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';
import 'package:shared_code/shared_code.dart';
import 'package:shared_code/shared_code/helper/responsive.dart';
import 'package:shared_code/shared_code/utils/app_routes.dart';
import 'package:shared_code/shared_code/widgets/buttons/app_main_button.dart';

class AddRestaurantDialog extends StatefulWidget {
  final RestaurantModel? toUpdate;
  const AddRestaurantDialog({
    super.key,
    this.toUpdate,
  });

  @override
  State<AddRestaurantDialog> createState() => _AddRestaurantDialogState();
}

class _AddRestaurantDialogState extends State<AddRestaurantDialog> {
  bool loading = false;
  final RestaurantDatasource restaurantDatasource = RestaurantDatasource();

  void initUpdate() {
    if (widget.toUpdate == null) return;
    name.text = widget.toUpdate!.name;
    managerName.text = widget.toUpdate!.managerName;
    managerPhoneNumber.text = widget.toUpdate!.managerPhoneNumber;
    address.text = widget.toUpdate!.address;
    phone.text = widget.toUpdate!.phone;
    officeId.text = widget.toUpdate!.officeId;
  }

  Future<void> _saveRestaurant() async {
    try {
      loading = true;
      setState(() {});
      var model = await restaurantDatasource.createRestaurant(
        name: name.text,
        managerName: managerName.text,
        managerPhoneNumber: managerPhoneNumber.text,
        email: loginEmail.text,
        password: loginPassword.text,
        address: address.text,
        phone: phone.text,
        officeId: officeId.text,
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
      return _saveRestaurant();
    } else {
      return _updateRestaurant();
    }
  }

  Future<void> _updateRestaurant() async {
    try {
      loading = true;
      setState(() {});
      var model = await restaurantDatasource.updateRestaurant(
        widget.toUpdate!,
        name: name.text,
        managerName: managerName.text,
        managerPhoneNumber: managerPhoneNumber.text,
        address: address.text,
        phone: phone.text,
        officeId: officeId.text,
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

  final name = TextEditingController();
  final managerName = TextEditingController();
  final managerPhoneNumber = TextEditingController();
  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final officeId = TextEditingController();

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
                title: widget.toUpdate == null
                    ? 'Add Restaurant'
                    : 'Update Restaurant',
              ),
              Row(
                children: [
                  Expanded(
                      child: FancyTextField(
                    padding: EdgeInsets.zero,
                    hint: 'Enter restaurant name',
                    controller: name,
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
              Row(
                children: [
                  Expanded(
                      child: FancyTextField(
                    padding: EdgeInsets.zero,
                    hint: 'Enter restaurant phone',
                    controller: phone,
                  )),
                  WidthSpace(10),
                  Expanded(
                      child: FancyTextField(
                    padding: EdgeInsets.zero,
                    hint: 'Enter Office Id',
                    controller: officeId,
                  )),
                ],
              ),
              HeightSpace(10),
              FancyTextField(
                padding: EdgeInsets.zero,
                hint: 'Enter Restaurant Address',
                controller: address,
                maxLines: 3,
                minLines: 2,
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
                title: widget.toUpdate == null
                    ? 'Add Restaurant'
                    : 'Update Restaurant',
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
