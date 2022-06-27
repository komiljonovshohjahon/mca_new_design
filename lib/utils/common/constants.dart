import 'package:mca_new_design/template/base/template.dart';

class Constants {
  static const appTitle = 'MCA';
  static String restBaseUrlDev = "https://timesheet.skillfill.co.uk/";
  static String restBaseUrlProd = "https://timesheet.onlinetimeclock.co.uk/";
  static String grantType = "password";
  static String domain = "timesheet.skillfill.co.uk";
  static String clientId =
      "1_3bcbxd9e24g0gk4swg0kwgcwg4o8k8g4g888kwc44gcc0gwwk4";
  static String clientSecret =
      "4ok2x70rlfokc8g0wws8c8kwcokw80k44sg48goc0ok4w0so0k";
  static const app_version = '1.1';
  static const alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  static Map timesheetColorMapper = {
    "pending": ThemeColors.lightGray,
    "approved": ThemeColors.cFFA200,
    "declined": ThemeColors.mainRed.withOpacity(0.7)
  };
  static Map dailyProgressStatusMapper = {
    "done": 'completed',
    "progress": 'in_progress',
    "queue": 'in_queue',
    "unknown": 'unknown',
  };

  //Property Icons
  static const Map propertyIcons = {
    "bedrooms": FontAwesomeIcons.bed,
    "bathrooms": FontAwesomeIcons.bath,
    "sleeps": FontAwesomeIcons.peopleGroup,
  };

  //////HiveKeyAndBoxNames
  static const String hiveBoxName = "SECURE_HIVE_BOX";
  static const String hiveTokenKey = "HIVE_TOKEN_KEY";
  static const String hiveRegKey = "HIVE_REGISTER_KEY";
  static const String hiveTestKey = "HIVE_TEST_KEY";
  static const String hiveLocaleKey = "HIVE_LOCALE_KEY";
  static const String hiveLocationAccessed = "HIVE_LOC_ACCESSED";
}
