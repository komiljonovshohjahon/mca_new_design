import 'dart:ui';
import 'package:get/get.dart';
import 'package:mca_new_design/utils/localization/languages/languages.dart';

class GetLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_EN': EnglishLocale.EN,
        'pt_PT': PortugueseLocale.PT,
        'hu': HungarianLocale.HU,
      };
}

class Locales {
  Locale get EnLocale => const Locale('en');
  Locale get PtLocale => const Locale('pt');
  Locale get HuLocale => const Locale('hu');
}
