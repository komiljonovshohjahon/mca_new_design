import 'package:flutter_redux/flutter_redux.dart';
import 'package:mca_new_design/template/base/template.dart';

import '../../manager/periodic_actions.dart';
import '../../manager/redux/middleware/models_middleware.dart';

class DefaultDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (ctx, state) {
        final String? userLogo = state.modelsState.photoModel.thumbnail;
        final String? companyLogo = state.modelsState.companyModel.logo;
        final String? companyName = state.modelsState.companyModel.name;
        final String? fullname =
            "${state.modelsState.detailsModel.firstName} ${state.modelsState.detailsModel.lastName}";
        final String? position = state.modelsState.detailsModel.role;
        final currentRoute = Get.routing.current;
        final userRole = state.initState.userRole;
        final checklistOn = state.initState.checklistOn;

        return Drawer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 8.w, right: 8.w, top: 50.h, bottom: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (userLogo == null)
                            const CircleAvatar(
                              foregroundImage:
                                  AssetImage('assets/images/launcher_icon.png'),
                            )
                          else
                            // Image(
                            //   width: 40.w,
                            //   height: 40.w,
                            //   image: MemoryImage(fromBase64(userLogo)),
                            // ),
                            CircleAvatar(
                              backgroundColor: ThemeColors.transparent,
                              foregroundImage:
                                  MemoryImage(fromBase64(userLogo)),
                            ),
                          SizedBox(height: 18.h),
                          SizedText(
                              text: fullname,
                              maxLines: 3,
                              softWrap: true,
                              width: 100.w,
                              textStyle: ThemeTextRegular.lg1),
                          SizedBox(height: 2.h),
                          SizedText(
                              maxLines: 3,
                              softWrap: true,
                              width: 100.w,
                              text: position,
                              textStyle: ThemeTextRegular.sm.copyWith(
                                  color: ThemeColors.black.withOpacity(0.6))),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (companyLogo == null)
                            CircleAvatar(
                              child: SizedText(
                                  text: companyName.toString().substring(0, 1),
                                  textStyle: ThemeTextSemibold.lg4
                                      .apply(color: ThemeColors.white)),
                              backgroundColor: ThemeColors.mainBlue,
                            )
                          else
                            // Image(
                            //   width: 40.w,
                            //   height: 40.w,
                            //   image: MemoryImage(fromBase64(companyLogo)),
                            // ),
                            CircleAvatar(
                              backgroundColor: ThemeColors.transparent,
                              foregroundImage:
                                  MemoryImage(fromBase64(companyLogo)),
                            ),
                          SizedBox(height: 18.h),
                          SizedText(
                              text: companyName,
                              maxLines: 3,
                              softWrap: true,
                              width: 120.w,
                              textStyle: ThemeTextRegular.lg),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(thickness: 1.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
                  child: Column(
                    children: [
                      _drawerButton(FontAwesomeIcons.arrowsRotate,
                          AppRoutes.RouteToMain, currentRoute),
                      _drawerButton(FontAwesomeIcons.solidAddressBook,
                          AppRoutes.RouteToInformation, currentRoute),
                      if (checklistOn)
                        _drawerButton(FontAwesomeIcons.checkDouble,
                            AppRoutes.RouteToChecklist, currentRoute),
                      _drawerButton(FontAwesomeIcons.boxesStacked,
                          AppRoutes.RouteToStockSummary, currentRoute),
                      _drawerButton(FontAwesomeIcons.solidPaperPlane,
                          AppRoutes.RouteToStockTransfer, currentRoute),
                      if (userRole != 'u')
                        _drawerButton(FontAwesomeIcons.solidSun,
                            AppRoutes.RouteToDailyProgress, currentRoute),
                      if (userRole != 'u')
                        _drawerButton(
                            FontAwesomeIcons.tasks,
                            AppRoutes.RouteToAdministrationLocation,
                            currentRoute),
                      _drawerButton(FontAwesomeIcons.userClock,
                          AppRoutes.RouteToTimesheet, currentRoute),
                      _drawerButton(FontAwesomeIcons.solidCommentAlt,
                          AppRoutes.RouteToMessages, currentRoute),
                      _drawerButton(FontAwesomeIcons.infoCircle,
                          AppRoutes.RouteToAbout, currentRoute),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _drawerButton(IconData icon, String label, String? currentRoute) {
    bool isActive = label.tr == currentRoute?.tr;
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(isActive
              ? ThemeColors.mainBlue.withOpacity(0.1)
              : ThemeColors.transparent),
          foregroundColor: MaterialStateProperty.all(
              isActive ? ThemeColors.mainBlue : ThemeColors.gray),
          fixedSize: MaterialStateProperty.all(Size(double.infinity, 46.h)),
          textStyle: MaterialStateProperty.all<TextStyle>(ThemeTextRegular.sm)),
      onPressed: () async {
        appStore.isLoading(false);
        if (!isActive) {
          if (currentRoute == AppRoutes.RouteToMain) {
            await appStore.to(label);
          } else {
            await appStore.replace(label);
          }
        }
      },
      child: SpacedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        horizontalSpace: 32,
        children: [
          FaIcon(icon, size: 18.h),
          SizedText(text: label.tr),
        ],
      ),
    );
  }
}

class LoginDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (ctx, state) {
        final currentRoute = Get.routing.current;
        return Drawer(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding:
                EdgeInsets.only(left: 8.w, right: 8.w, top: 50.h, bottom: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedText(
                    text: 'MCA',
                    maxLines: 2,
                    softWrap: true,
                    textStyle: ThemeTextRegular.lg1),
                Divider(thickness: 1.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  child: Column(
                    children: [
                      _drawerButton(FontAwesomeIcons.signIn,
                          AppRoutes.RouteToSignUp, currentRoute),
                      _drawerButton(FontAwesomeIcons.infoCircle,
                          AppRoutes.RouteToAbout, currentRoute), //TODO:
                    ],
                  ),
                )
              ],
            ),
          )
        ]));
      },
    );
  }

  Widget _drawerButton(IconData icon, String label, String? currentRoute) {
    bool isActive = label == currentRoute;
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(isActive
              ? ThemeColors.mainBlue.withOpacity(0.1)
              : ThemeColors.transparent),
          foregroundColor: MaterialStateProperty.all(
              isActive ? ThemeColors.mainBlue : ThemeColors.gray),
          fixedSize: MaterialStateProperty.all(Size(double.infinity, 46.h)),
          textStyle: MaterialStateProperty.all<TextStyle>(ThemeTextRegular.sm)),
      onPressed: () {
        if (!isActive) {
          // appStore.pop();
          appStore.to(label);
        }
      },
      child: SpacedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        horizontalSpace: 32,
        children: [
          FaIcon(icon, size: 18.h),
          SizedText(text: label.tr),
        ],
      ),
    );
  }
}
