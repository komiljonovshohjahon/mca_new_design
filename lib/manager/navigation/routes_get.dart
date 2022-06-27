import 'package:mca_new_design/template/base/template.dart';

class AppRoutes {
  static const RouteToSplash = "/Splash";
  static const RouteToSignUp = "/SignUp";
  static const RouteToMain = "/change_status";
  static const RouteToInformation = "/informations";
  static const RouteToAdministrationAvailableShifts =
      "/AdministrationAvailableShifts";
  static const RouteToAdministrationLocation = "/administration";
  static const RouteToAdministrationUser = "/AdministrationUser";
  static const RouteToAvailableShift = "/AvailableShift";
  static const RouteToChecklist = "/checklist";
  static const RouteToDailyProgress = "/daily_progress";
  static const RouteToStockSummary = "/stock_summary";
  static const RouteToStockTransferItem = "/stock_transfer_item";
  static const RouteToStockTransfer = "/stock_transfer";
  static const RouteToTimesheet = "/timesheet";
  static const RouteToAbout = "/about";
  static const RouteToTimesheetReq = "/TimesheetRequest";
  static const RouteToTimesheetAvailable = "/TimesheetAvailable";
  static const RouteToMessages = "/messages";
  static const RouteToProperties = "/properties";
  static const RouteToProminentAlert = "/prominent_alert";
  static const RouteToError = "/error)";

  static Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> base = {
      AppRoutes.RouteToSplash: (BuildContext _) => SplashScreen(),
      AppRoutes.RouteToSignUp: (BuildContext _) => const SignUpScreen(),
      AppRoutes.RouteToMain: (BuildContext _) => MainScreen(),
      AppRoutes.RouteToInformation: (BuildContext _) =>
          const InformationScreen(),
      AppRoutes.RouteToAdministrationAvailableShifts: (BuildContext _) =>
          const AdministrationAvailableShiftsScreen(),
      AppRoutes.RouteToAdministrationLocation: (BuildContext _) =>
          const AdministrationLocationScreen(),
      AppRoutes.RouteToAdministrationUser: (BuildContext _) =>
          const AdministrationUserScreen(),
      AppRoutes.RouteToAvailableShift: (BuildContext _) =>
          const AvailableShiftScreen(),
      AppRoutes.RouteToChecklist: (BuildContext _) => const ChecklistScreen(),
      AppRoutes.RouteToDailyProgress: (BuildContext _) =>
          const DailyProgressScreen(),
      AppRoutes.RouteToStockSummary: (BuildContext _) =>
          const StockSummaryScreen(),
      AppRoutes.RouteToStockTransferItem: (BuildContext _) =>
          StockTransferItemScreen(),
      AppRoutes.RouteToStockTransfer: (BuildContext _) =>
          const StockTransferScreen(),
      AppRoutes.RouteToTimesheet: (BuildContext _) => const TimesheetScreen(),
      AppRoutes.RouteToAbout: (BuildContext _) => AboutScreen(),
      AppRoutes.RouteToTimesheetReq: (BuildContext _) =>
          const TimesheetReqScreen(),
      AppRoutes.RouteToTimesheetAvailable: (BuildContext _) =>
          const TimesheetAvailableScreen(),
      AppRoutes.RouteToMessages: (BuildContext _) => const MessagesScreen(),
      AppRoutes.RouteToProperties: (BuildContext _) => const PropertiesScreen(),
      AppRoutes.RouteToProminentAlert: (BuildContext _) =>
          ProminentAlertScreen(),
      AppRoutes.RouteToError: (BuildContext _) => ErrorScreen(
          errorDetails: FlutterErrorDetails(exception: Exception("Error"))),
    };

    return base;
  }
}
