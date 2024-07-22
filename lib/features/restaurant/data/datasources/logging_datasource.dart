import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongez_shared_code/constants/collections.dart';
import 'package:mongez_shared_code/mongez_shared_code.dart';

class LoggingDatasource {
  Future<void> logOrderAction(
    OrderModel model,
    OrderLoggingAction action,
  ) async {
    OrderLogging logging = OrderLogging(
      orderId: model.id,
      action: action,
      loggedAt: DateTime.now(),
    );

    FirebaseFirestore.instance
        .collection(Collections.logging)
        .add(logging.toJson());
  }
}
