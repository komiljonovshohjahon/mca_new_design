import 'package:flutter_redux/flutter_redux.dart';
import 'package:mca_new_design/template/base/template.dart';
import 'package:redux/redux.dart';

typedef _StateReturnHelper = Widget Function(AppState state);
typedef _OnInitAndDisposeHelper = void Function(Store<AppState> state);

class DefaultBody extends StatelessWidget {
  final _StateReturnHelper? footer;
  final String? titleText;
  final bool showLeadingMenuBtn;
  final VoidCallback? showLeadingX;
  final VoidCallback? showLeadingBack;
  final VoidCallback? showActionBell;
  final VoidCallback? showActionMsg;
  final VoidCallback? showActionLocation;
  final bool showTitleDate;
  final bool connectAppBarWithBody;
  final double paddingTop;
  final double paddingBottom;
  final double paddingHorizontal;
  final Color? bgColor;
  final _StateReturnHelper child;
  final VoidCallback? onInit;
  final VoidCallback? onDispose;
  final AppBar? header;
  final int shimmerLength;
  final VoidCallback? showActionMenu;
  final VoidCallback? showArrowLeft;
  final VoidCallback? showArrowRight;
  final VoidCallback? showCalendar;

  const DefaultBody({
    this.footer,
    this.showLeadingBack,
    this.showLeadingMenuBtn = false,
    this.header,
    this.showLeadingX,
    this.showActionMsg,
    this.showActionLocation,
    this.showActionBell,
    this.showTitleDate = false,
    this.connectAppBarWithBody = false,
    this.titleText,
    this.paddingBottom = 0,
    this.paddingHorizontal = 16,
    this.paddingTop = 0,
    this.bgColor,
    required this.child,
    this.onDispose,
    this.onInit,
    this.shimmerLength = 1,
    this.showActionMenu,
    this.showArrowRight,
    this.showArrowLeft,
    this.showCalendar,
  });

  double get calcBottomPadding =>
      footer == null ? paddingBottom : paddingBottom;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (ctx, state) {
          final bool isLoggedIn = state.initState.access_token.isNotEmpty;
          return Scaffold(
            backgroundColor: bgColor,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            extendBodyBehindAppBar: connectAppBarWithBody,
            appBar: header ??
                DefaultHeader(
                  showActionMenu: showActionMenu,
                  showArrowLeft: showArrowLeft,
                  showArrowRight: showArrowRight,
                  showLeadingMenuBtn: showLeadingMenuBtn,
                  showLeadingBack: showLeadingBack,
                  showActionBell: showActionBell,
                  showActionLocation: showActionLocation,
                  showActionMsg: showActionMsg,
                  titleText: titleText,
                  showCalendar: showCalendar,
                ),
            bottomNavigationBar: footer != null ? footer!(state) : null,
            drawer: _getDrawer(state),
            body: SafeArea(
              child: Padding(
                  padding: EdgeInsets.only(
                      right: paddingHorizontal.w,
                      left: paddingHorizontal.w,
                      bottom: calcBottomPadding.h,
                      top: connectAppBarWithBody ? 146.h : 0 + paddingTop.h),
                  child: LayoutWrapper(
                      onInit: onInit,
                      onDispose: onDispose,
                      child: state.initState.isLoading
                          ? shimmerLength == 0
                              ? child(state)
                              : DefaultShimmer(length: shimmerLength)
                          : child(state))),
            ),
          );
        });
  }

  Widget? _getDrawer(AppState state) {
    final String currentRoute = Get.routing.current;
    final bool isLoggedIn = state.initState.access_token.isNotEmpty;
    if ((currentRoute != AppRoutes.RouteToSplash) && isLoggedIn) {
      return DefaultDrawer();
    } else if (currentRoute != AppRoutes.RouteToSplash) {
      return LoginDrawer();
    }
  }
}
