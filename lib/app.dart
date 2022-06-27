import 'package:flutter/foundation.dart';
import 'package:mca_new_design/template/base/template.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mca_new_design/template/base/theme_data.dart';
import 'package:mca_new_design/utils/common/global_widgets.dart';

class McaApp extends StatefulWidget {
  const McaApp({Key? key}) : super(key: key);

  @override
  State<McaApp> createState() => _McaAppState();
}

class _McaAppState extends State<McaApp> {
  @override
  void initState() {
    super.initState();
    _runInit().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: appStore,
        child: ScreenUtilInit(
            designSize: const Size(
                ThemeSizeStyle.screenWidth, ThemeSizeStyle.screenHeight),
            builder: (_, __) => GetMaterialApp(
                builder: (context, child) {
                  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                    return ErrorScreen(errorDetails: errorDetails);
                  };
                  return MediaQuery(
                      child: child!,
                      data: MediaQuery.of(context)
                          .copyWith(textScaleFactor: 1.0.sp));
                },
                title: Constants.appTitle,
                theme: MainTheme.mainTheme,
                debugShowCheckedModeBanner: kDebugMode,
                navigatorKey: Global.navKey,
                enableLog: true,
                routes: AppRoutes.getRoutes(),
                navigatorObservers: [AppRouterObserver()],
                // home: SplashScreen(),
                initialRoute: AppRoutes.RouteToSplash,
                translations: GetLocalization())));
  }

  Future _runInit() async {
    await appStore.dispatch(GetChangeLocaleAction());
  }
}

class AppRouterObserver extends RouteObserver<Route<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    appStore.dispatch(UpdateNavigationAction(
        name: route.settings.name, isPage: route is PageRoute, method: 'push'));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    appStore.dispatch(UpdateNavigationAction(
        name: previousRoute!.settings.name,
        isPage: previousRoute is PageRoute,
        method: 'pop'));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    appStore.dispatch(UpdateNavigationAction(
        name: newRoute!.settings.name,
        isPage: newRoute is PageRoute,
        method: 'replace'));
  }
}
