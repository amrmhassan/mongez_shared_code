import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongez_shared_code/constants/collections.dart';
import 'package:mongez_shared_code/mongez_shared_code.dart';

class LoggingDatasource {
  Future<void> logOrderAction({
    required String orderId,
    required OrderLoggingAction action,
    String? riderId,
    String? restaurantId,
  }) async {
    OrderLogging logging = OrderLogging(
      orderId: orderId,
      restaurantId: restaurantId,
      riderId: riderId,
      action: action,
      loggedAt: DateTime.now(),
    );

    FirebaseFirestore.instance
        .collection(Collections.logging)
        .add(logging.toJson());
  }
}
