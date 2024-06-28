class RiderRealTimeCollections {
  static const String _riders = 'riders';
  static const String _status = 'status';
  static const String _location = 'location';
  static const String _orders = 'orders';

  static String status(String riderId) {
    return '$_riders/$riderId/$_status';
  }

  static String location(String riderId) {
    return '$_riders/$riderId/$_location';
  }

  static String orders(String riderId) {
    return '$_riders/$riderId/$_orders';
  }

  static String order(String riderId, String orderId) {
    return '$_riders/$riderId/$_orders/$orderId';
  }
}
