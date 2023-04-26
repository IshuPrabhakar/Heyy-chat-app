import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'file_helper.dart';

final ImageHelperProvider = Provider<ImageHandler>(
  ((ref) => ImageHandler()),
);

final PermissionHandlerProvider = Provider<PermissionHandler>(
  ((ref) => PermissionHandler()),
);
