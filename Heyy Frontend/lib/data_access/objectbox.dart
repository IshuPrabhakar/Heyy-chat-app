import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../entities/user_entity.dart';
import '../objectbox.g.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
class ObjectBox {
  late final Store store;

  late final Box<User> user;

  ObjectBox._create(this.store) {
    user = Box<User>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final dbDir = await getExternalStorageDirectory();
    final store = await openStore(directory: join(dbDir!.path, "Heyy"));
    return ObjectBox._create(store);
  }
}
