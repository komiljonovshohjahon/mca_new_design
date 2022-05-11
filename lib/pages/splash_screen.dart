import 'package:mca_new_design/template/base/template.dart';

import '../manager/periodic_actions.dart';
import '../manager/redux/middleware/models_middleware.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => quitAppPopup(hasReset: false),
      child: DefaultBody(
        shimmerLength: 0,
        onInit: _doInit,
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

  _doInit() async {
    await getDeviceLocation();
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
        await appStore.dispatch(GetModelsInitAction(
            successAction: () => appStore.replace(AppRoutes.RouteToMain)));
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
