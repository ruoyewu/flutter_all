import 'dart:io';

class DeviceUtil {
  static bool get isWeb {
    try {
      return Platform.isAndroid == null;
    } catch (e) {
      return true;
    }
  }

  static bool get isAndroid => Platform.isAndroid;

  static bool get isIOS => Platform.isIOS;

  static bool get isMac => Platform.isMacOS;
}
