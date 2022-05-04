import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

logger(var str, {String? hint}) {
  if (kDebugMode) {
    log(hint ?? 'LOGGER');
    log(str.toString());
    log(hint ?? 'LOGGER');
  }
}
