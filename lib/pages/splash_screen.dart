import 'package:mca_new_design/template/base/template.dart';

import '../manager/periodic_actions.dart';
import '../manager/redux/middleware/login_middleware.dart';
import '../manager/redux/middleware/models_middleware.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => quitAppPopup(hasReset: false),
      child: DefaultBody(
        shimmerLength: 0,
        onInit: () => _doInit(context),
        header: AppBar(toolbarHeight: 0, elevation: 0),
        paddingHorizontal: 0,
        bgColor: ThemeColors.white,
        child: (_) => Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset('assets/images/shape_blue.svg')),
            SpacedColumn(
              verticalSpace: 100,
              children: [
                SvgPicture.asset('assets/images/mca_icon.svg'),
                const CircularProgressIndicator(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _doInit(BuildContext context) async {
    // bool prominentAlertGranted = await showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => AlertDialog(
    //           title: Text("prominent_alert".tr),
    //           content: Text("prominent_alert_msg".tr),
    //           actionsAlignment: MainAxisAlignment.spaceBetween,
    //           actions: <Widget>[
    //             FlatButton(
    //               child: Text("deny".tr),
    //               onPressed: () => Navigator.of(context).pop(false),
    //             ),
    //             FlatButton(
    //               child: Text("grant".tr),
    //               onPressed: () => Navigator.of(context).pop(true),
    //             ),
    //           ],
    //         ));
    // print("prominentAlertGranted: $prominentAlertGranted");
    // if (prominentAlertGranted) {
    //   await getDeviceLocation();
    // }
    Get.put(TimerController());
    Map? res = await appStore
        .dispatch(GetImportHiveAction(key: Constants.hiveTokenKey));
    await appStore.dispatch(GetImportHiveAction(key: Constants.hiveTestKey));
    bool? isRegged =
        await appStore.dispatch(GetImportHiveAction(key: Constants.hiveRegKey));
    bool authenticated = res != null && res.containsKey('refresh_token');
    bool regged = isRegged ?? false;
    if (authenticated) {
      if (regged) {
        await appStore.dispatch(GetModelsInitAction(successAction: () async {
          disclosureAction();
        }));
      } else {
        await appStore.dispatch(GetResetAction());
      }
    } else {
      await appStore.dispatch(GetResetAction());
      // await Future.delayed(
      //     2.seconds, () => appStore.replace(AppRoutes.RouteToSignUp));
    }
  }
}
