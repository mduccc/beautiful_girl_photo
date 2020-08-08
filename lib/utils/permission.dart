import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
  static Future<bool> hasWriteStoragePermission() async {
    if (!(await Permission.storage.isGranted)) {
      await Permission.storage.request();
    }
    return await Permission.storage.isGranted;
  }
}
