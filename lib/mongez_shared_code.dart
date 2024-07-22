// dart run build_runner build --delete-conflicting-outputs
// flutter run -d chrome --web-port 8080 --web-browser-flag "--disable-web-security"

export 'utils/dio_errors.dart';
export 'utils/easy_utils.dart';
export 'utils/form_utils.dart';
export 'utils/global_utils.dart';
export 'utils/map_utils.dart';
export 'features/auth/data/datasources/auth_validator.dart';
export 'features/auth/data/datasources/password_datasource.dart';
export 'features/auth/data/datasources/auth_datasource.dart';
export 'global/height_space.dart';
export 'extension/string_extension.dart';
export 'extension/date_extension.dart';
export 'global/widgets/user_cell_copier.dart';
export 'global/widgets/dialog_title.dart';
export 'global/widgets/global_table.dart';

//? models
export 'features/auth/data/models/user_type.dart';
export 'features/restaurant/data/models/minified_order.dart';
export 'features/restaurant/data/models/order_model.dart';
export 'features/restaurant/data/models/restaurant_model.dart';
export 'features/rider/data/models/rider_model.dart';
export 'features/rider/data/models/military_status.dart';
export 'features/rider/data/models/working_model.dart';
export 'features/restaurant/data/models/order_logging.dart';
export 'features/restaurant/data/datasources/logging_datasource.dart';

//? constants
export 'constants/remote_storage.dart';
export 'constants/realtime_collections.dart';
export 'constants/rider_realtime_collections.dart';

//? global
export 'init/runtime_variables.dart';
