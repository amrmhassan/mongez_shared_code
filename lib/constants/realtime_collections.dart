class RealtimeCollections {
  static const String _orders = 'orders';
  static const String _latestOrders = 'latestOrder';
  static const String _office = 'office';

  static String latestOrder() {
    return '$_orders/$_latestOrders';
  }

  static String officeLatestOrder(String officeId) {
    return '$_orders/$_office/$officeId/$_latestOrders';
  }
}

// orders => (latest order, offices(officeId=>latestOrder))