import 'package:mca_new_design/template/base/template.dart';

import '../manager/redux/middleware/models_middleware.dart';

class ProminentAlertScreen extends StatefulWidget {
  @override
  State<ProminentAlertScreen> createState() => _ProminentAlertScreenState();
}

class _ProminentAlertScreenState extends State<ProminentAlertScreen> {
  bool showPermanentDenyMsg = false;
  int retry = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: DefaultBody(
          hasDrawer: false,
          centerTitle: true,
          paddingHorizontal: 10,
          paddingTop: 5,
          bgColor: ThemeColors.white,
          child: (_) => SpacedColumn(
                children: [
                  Image.asset('assets/images/map_location.png',
                      height: 200, width: 200),
                  SizedText(
                    text: "prominent_alert",
                    textStyle: ThemeTextBold.lg2,
                  ),
                  const SizedBox(height: 20),
                  SizedText(
                    text: "prominent_alert_msg",
                    textStyle: ThemeTextRegular.base,
                    maxLines: 10,
                    textAlign: TextAlign.center,
                  ),
                  if (showPermanentDenyMsg) const SizedBox(height: 20),
                  if (showPermanentDenyMsg)
                    SizedText(
                      text: "permanent_deny_handle_msg",
                      textStyle: ThemeTextRegular.base
                          .apply(color: ThemeColors.mainRed),
                      maxLines: 10,
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {
                      if (retry >= 2) {
                        setState(() {
                          showPermanentDenyMsg = true;
                        });
                        //Permanently denied
                      } else {
                        final locRes = await getDeviceLocation();
                        if (locRes == null) {
                          //if locRes is null, show error message
                          //if permanently denied, show how to enable manually
                          setState(() {
                            retry += 1;
                          });
                        } else {
                          //else move to MainPage
                          appStore.replace(AppRoutes.RouteToMain);
                          //Store location is permitted boolean in Hive
                          appStore.dispatch(GetExportHiveAction(
                              key: Constants.hiveLocationAccessed,
                              value: true));
                          return;
                        }
                      }
                    },
                    child: Text("turn_on_loc".tr, style: ThemeTextRegular.base),
                  )
                ],
              )),
    );
  }
}
