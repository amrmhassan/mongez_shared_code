// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:mongez_shared_code/features/restaurant/data/datasources/restaurant_datasource.dart';
import 'package:mongez_shared_code/features/restaurant/data/models/restaurant_model.dart';
import 'package:mongez_shared_code/features/restaurant/presentation/widgets/add_restaurant_dialog.dart';
import 'package:mongez_shared_code/features/restaurant/presentation/widgets/delete_restaurant_dialog.dart';
import 'package:mongez_shared_code/global/widgets/global_table.dart';
import 'package:mongez_shared_code/global/widgets/user_cell_copier.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';
import 'package:mongez_shared_code/theming/data/constants/styles.dart';
import 'package:shared_code_new/shared_code_new.dart';
import 'package:shared_code_new/shared_code_new/helper/responsive.dart';
import 'package:shared_code_new/shared_code_new/widgets/buttons/app_main_button.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  bool loading = false;
  List<RestaurantModel> offices = [];
  RestaurantDatasource officeDS = RestaurantDatasource();

  @override
  void initState() {
    loading = true;
    Future.delayed(Duration.zero).then((value) async {
      loadOffices();
    });
    super.initState();
  }

  void loadOffices() async {
    loading = true;
    setState(() {});
    try {
      offices = await officeDS.getAllRestaurants();
    } catch (e) {
      globalUtils.errorSnackbar(e);
    }

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Row(
          children: [
            Text(
              'All Restaurants',
              style: h2TextStyle,
            ),
            Spacer(),
            AppMainButton(
              padding: EdgeInsets.symmetric(
                horizontal: kHPad,
                vertical: kVPad / 2,
              ),
              onTap: () async {
                var model = await showDialog(
                  context: context,
                  builder: (context) => AddRestaurantDialog(),
                );
                if (model is! RestaurantModel) return;
                // here reload the models from the datasource
                globalUtils.successSnackbar('Restaurant Added successfully');
                loadOffices();
              },
              child: Text(
                'Add Restaurant',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        VSpace(),
        Expanded(
            child: GlobalTable(
          columns: [
            DataColumn2(
              fixedWidth: Responsive.getWidth(context) / 10,
              label: Text('ID'),
            ),
            DataColumn2(
              fixedWidth: Responsive.getWidth(context) / 10,
              label: Text('Name'),
            ),
            DataColumn2(
              fixedWidth: Responsive.getWidth(context) / 10,
              label: Text('Mng Name'),
            ),
            DataColumn2(
              fixedWidth: Responsive.getWidth(context) / 10,
              label: Text('Mng Phone'),
            ),
            DataColumn2(
              fixedWidth: Responsive.getWidth(context) / 10,
              label: Text('Restaurant Phone'),
            ),
            DataColumn2(
              fixedWidth: Responsive.getWidth(context) / 8,
              label: Text('Email'),
            ),
            DataColumn2(
              fixedWidth: Responsive.getWidth(context) / 15,
              label: Text('Password'),
            ),
            DataColumn2(
              fixedWidth: Responsive.getWidth(context) / 15,
              label: Text('Edit'),
            ),
            DataColumn2(
              fixedWidth: Responsive.getWidth(context) / 15,
              label: Text('Delete'),
            ),
          ],
          rows: offices
              .map(
                (e) => DataRow(
                  cells: [
                    DataCell(UserCellCopier(
                      e.id,
                    )),
                    DataCell(UserCellCopier(
                      e.name,
                    )),
                    DataCell(UserCellCopier(
                      e.managerName,
                    )),
                    DataCell(UserCellCopier(
                      e.managerPhoneNumber,
                    )),
                    DataCell(UserCellCopier(
                      e.phone,
                    )),
                    DataCell(UserCellCopier(
                      e.email,
                    )),
                    DataCell(UserCellCopier(
                      e.password,
                      shownTxt: '****',
                      copyMsg: 'Plain Password copied to clipboard',
                    )),
                    DataCell(
                      IconButton(
                        onPressed: () async {
                          var model = await showDialog(
                            context: context,
                            builder: (context) => AddRestaurantDialog(
                              toUpdate: e,
                            ),
                          );
                          if (model is! RestaurantModel) return;
                          // here reload the models from the datasource
                          globalUtils
                              .successSnackbar('Office updated successfully');

                          loadOffices();
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                    DataCell(
                      IconButton(
                        onPressed: () async {
                          var model = await showDialog(
                            context: context,
                            builder: (context) => DeleteRestaurantDialog(
                              model: e,
                            ),
                          );
                          if (model is! RestaurantModel) return;
                          // here reload the models from the datasource
                          globalUtils
                              .successSnackbar('Office deleted successfully');

                          loadOffices();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ))
      ],
    );
  }
}
