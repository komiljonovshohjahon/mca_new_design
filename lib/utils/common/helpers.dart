import 'package:mca_new_design/template/base/template.dart';
import 'package:redux/redux.dart';

extension DoubleHelper on double {
  ModelFormatter get getPriceMap =>
      ModelFormatter(currencyFormatter(this), this);
}

extension StringHelper on String {
  String get getDateAndTimeFormat => formatDateTime(this);
  String get getDateOnlyFormat => formatDateTime(this, withTime: false);
  String get getTimeOnlyFormat =>
      formatDateTime(this, withTime: true, withDate: false);
}

extension StoreHelper on Store {
  Future? to(String route) => dispatch(NavigateToAction(to: route));
  Future? replace(String route) =>
      dispatch(NavigateToAction(to: route, replace: true));
  pop() => dispatch(NavigateToAction(to: 'up'));
  void popupPop({bool all = false}) => dispatch(DismissPopupAction(all: all));
  void isLoading(bool isLoading) =>
      dispatch(UpdateInitAction(isLoading: isLoading));
  void snackbar(String msg) => Get.showSnackbar(GetSnackBar(
      message: msg.tr,
      duration: 3.seconds,
      animationDuration: 500.milliseconds,
      backgroundColor: ThemeColors.gray));
}
