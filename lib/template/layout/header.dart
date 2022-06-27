import 'package:flutter_redux/flutter_redux.dart';
import 'package:mca_new_design/template/base/template.dart';

import '../../manager/redux/states/ui_state.dart';

class DefaultHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final bool showLeadingMenuBtn;
  final VoidCallback? showLeadingBack;
  final VoidCallback? showActionLocation;
  final VoidCallback? showActionBell;
  final VoidCallback? showActionMsg;
  final VoidCallback? showArrowLeft;
  final VoidCallback? showArrowRight;
  final VoidCallback? showActionMenu;
  final VoidCallback? showCalendar;
  final bool centerTitle;
  DefaultHeader({
    this.titleText,
    this.centerTitle = false,
    this.showLeadingBack,
    this.showActionBell,
    this.showActionLocation,
    this.showActionMsg,
    this.showLeadingMenuBtn = true,
    this.showActionMenu,
    this.showArrowRight,
    this.showArrowLeft,
    this.showCalendar,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (ctx, state) {
          return AppBar(
            elevation: 0,
            backgroundColor: ThemeColors.mainBlue,
            title: SizedText(text: titleText ?? Get.routing.current),
            toolbarHeight: ThemeSizeStyle.appBarHeight.h,
            automaticallyImplyLeading: false,
            // title: _buildTitleText(),
            leading: _buildLeading(),
            centerTitle: centerTitle,
            actions: _buildActions(state),
            titleSpacing: 0,
          );
        });
  }

  @override
  Size get preferredSize =>
      Size(double.infinity, ThemeSizeStyle.appBarHeight.h);

  List<Widget>? _buildActions(AppState state) {
    bool isLoading = state.initState.isLoading;
    return [
      if (showActionBell != null)
        IconButton(
            onPressed: showActionBell,
            icon: Icon(FontAwesomeIcons.solidBell, size: 20.h)),
      if (showActionMsg != null)
        IconButton(
            onPressed: () {
              appStore.to(AppRoutes.RouteToMessages);
              showActionMsg!();
            },
            icon: Icon(FontAwesomeIcons.solidCommentAlt, size: 20.h)),
      if (showActionLocation != null)
        IconButton(
            onPressed: () async {
              appStore
                  .dispatch(UpdateUIAction(showloc: !state.uiState.showloc));
              // showLoadingDialog();
              await appStore.dispatch(GetLocationAction());
              showActionLocation!();
              // closeLoading();
            },
            icon: Icon(FontAwesomeIcons.mapMarkerAlt,
                color: state.initState.isNear
                    ? ThemeColors.c11DB96
                    : ThemeColors.white,
                size: 20.h)),
      if (showArrowLeft != null)
        IconButton(
            onPressed: isLoading ? null : showArrowLeft,
            icon: Icon(FontAwesomeIcons.chevronLeft, size: 20.h)),
      if (showArrowRight != null)
        IconButton(
            onPressed: isLoading ? null : showArrowRight,
            icon: Icon(FontAwesomeIcons.chevronRight, size: 20.h)),
      if (showActionMenu != null)
        PopupMenuButton(
            offset: const Offset(200, 45),
            iconSize: 20.h,
            onSelected: (value) => choiceAction(value.toString()),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: true,
                    value: AppRoutes.RouteToTimesheetReq,
                    height: 30.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: SizedText(text: "new_req"),
                  ),
                  PopupMenuItem(
                    enabled: true,
                    height: 30.h,
                    value: AppRoutes.RouteToTimesheetAvailable,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: SizedText(text: "availability"),
                  )
                ]),
      if (showCalendar != null)
        IconButton(
            onPressed: isLoading ? null : showCalendar,
            icon: Icon(FontAwesomeIcons.calendarAlt, size: 20.h)),
    ];
  }

  void choiceAction(String value) {
    if (value == AppRoutes.RouteToTimesheetReq) {
      appStore.to(AppRoutes.RouteToTimesheetReq);
    } else if (value == AppRoutes.RouteToTimesheetAvailable) {
      appStore.to(AppRoutes.RouteToTimesheetAvailable);
    }
  }

  Widget? _buildLeading() {
    if (showLeadingBack != null) {
      return IconButton(
        onPressed: () {
          appStore.pop();
          _onBackTap();
        },
        icon: Icon(Icons.arrow_back, size: 22.h),
      );
    }
    if (showLeadingMenuBtn) {
      return Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu, size: 24.h),
        );
      });
    }
    return null;
  }

  _onBackTap() {
    if (showLeadingBack != null) showLeadingBack!();
    // appStore.dispatch(NavigateToAction(to: 'up'));
  }
}
