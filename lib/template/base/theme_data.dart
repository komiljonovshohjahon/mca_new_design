import 'package:mca_new_design/template/base/template.dart';

class MainTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      scaffoldBackgroundColor: ThemeColors.mainGray,
      primaryColor: ThemeColors.mainBlue,
      progressIndicatorTheme: _progressIndicatorTheme(),
      checkboxTheme: _checkboxTheme(),
    );
  }
}

CheckboxThemeData _checkboxTheme() {
  return CheckboxThemeData(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      side: BorderSide(width: 1.w, color: ThemeColors.mainGray),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ));
}

ProgressIndicatorThemeData _progressIndicatorTheme() {
  return ProgressIndicatorThemeData(
    color: ThemeColors.mainBlue,
    circularTrackColor: ThemeColors.gray,
  );
}
