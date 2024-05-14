import 'package:mongez_shared_code/theming/data/constants/sizes.dart';
import 'package:mongez_shared_code/theming/data/constants/styles.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:shared_code/shared_code/helper/responsive.dart';

class GlobalTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;

  const GlobalTable({
    super.key,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      headingRowDecoration: BoxDecoration(
        color: Colors.grey.withOpacity(.1),
      ),
      headingTextStyle: h3TextStyle,
      isHorizontalScrollBarVisible: false,
      isVerticalScrollBarVisible: false,
      columnSpacing: kVPad,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(mediumBorderRadius),
      ),
      minWidth: Responsive.getWidth(context),
      dividerThickness: 1,
      columns: columns,
      rows: rows,
    );
  }
}
