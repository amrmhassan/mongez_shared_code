// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mongez_shared_code/features/restaurant/data/datasources/restaurant_datasource.dart';
import 'package:mongez_shared_code/features/restaurant/data/models/restaurant_model.dart';
import 'package:mongez_shared_code/global/widgets/dialog_title.dart';
import 'package:mongez_shared_code/global/height_space.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';
import 'package:shared_code/shared_code/helper/responsive.dart';
import 'package:shared_code/shared_code/utils/app_routes.dart';
import 'package:shared_code/shared_code/widgets/buttons/app_main_button.dart';

class DeleteRestaurantDialog extends StatefulWidget {
  final RestaurantModel model;
  const DeleteRestaurantDialog({
    super.key,
    required this.model,
  });

  @override
  State<DeleteRestaurantDialog> createState() => _DeleteRestaurantDialogState();
}

class _DeleteRestaurantDialogState extends State<DeleteRestaurantDialog> {
  bool loading = false;
  final RestaurantDatasource restaurantDatasource = RestaurantDatasource();

  Future<void> delete() async {
    try {
      loading = true;
      setState(() {});
      await restaurantDatasource.deleteRestaurant(
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
              DialogTitle(title: 'Delete Restaurant'),
              Row(
                children: [
                  Text('Delete the restaurant (${widget.model.name})?'),
                ],
              ),
              HeightSpace(20),
              AppMainButton(
                active: !loading,
                onTap: delete,
                title: 'Delete Restaurant',
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
