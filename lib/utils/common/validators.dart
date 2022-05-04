import 'package:get/get.dart';

class Validator {
  static String? validateDomain(String? value) {
    if (value != null) {
      if (!GetUtils.isURL(value)) {
        return 'enter_proper_url'.tr;
      }
    } else {
      return null;
    }
  }

  static String? validateUsername(String? value) {
    if (value != null) {
      if (!GetUtils.isUsername(value)) {
        return 'username_cannot_be_empty'.tr;
      }
    } else {
      return null;
    }
  }

  static String? validatePwd(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'pwd_cannot_be_empty'.tr;
      }
    } else {
      return null;
    }
  }
}
