class Links {
  static const bool _debugging = false;
  static const String serverUrl = _debugging ? _debugUrl : _productionUrl;
  static const String _productionUrl = '';
  static const String _debugUrl = '';
}
