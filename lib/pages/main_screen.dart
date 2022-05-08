import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mca_new_design/manager/models/model_exporter.dart';
import 'package:mca_new_design/manager/periodic_actions.dart';
import 'package:mca_new_design/template/base/template.dart';
import 'package:timezone/standalone.dart' as tz;

import '../manager/redux/middleware/models_middleware.dart';

class MainScreen extends StatefulWidget {
  static ValueNotifier<String> breakTimerNotifier = ValueNotifier<String>("");

  static Timer? breakTimer;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final Timer _statusTimer;
  late final Timer _tokenTimer;

  @override
  void dispose() {
    _statusTimer.cancel();
    _tokenTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //Fetch status every 15 seconds
    _statusTimer = Timer.periodic(
      15.seconds,
      (_) async {
        log('Refresh Available And Current Status MCA => START');
        if (!kDebugMode) {
          await appStore.dispatch(GetCurrentStatusAction());
          await appStore.dispatch(GetAvailableAction());
          await appStore.dispatch(GetLocationAction());
        }
        log('Refresh Available And Current Status MCA => END');
      },
    );

    //Fetch token every 8 minutes
    _tokenTimer = Timer.periodic(
      8.minutes,
      (_) async {
        log('Refresh Token MCA => START');
        await appStore.dispatch(GetRenewAccessTokenAction());
        log('Refresh Token MCA => END');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => quitAppPopup(),
      child: DefaultBody(
        showActionLocation: () {},
        showActionMsg: () {},
        showActionBell: () {},
        onInit: () async {
          // final LocationData? deviceLoc = await getDeviceLocation();
          //
          // Location location = Location();
          // location.onLocationChanged.listen((LocationData currentLocation) {
          //   if (deviceLoc != null) {
          //     // logger(deviceLoc.accuracy!, hint: 'deviceLoc.accuracy!');
          //     // logger(currentLocation.accuracy! - deviceLoc.accuracy!.toDouble(),
          //     //     hint: 'DIVIDED!');
          //     if (deviceLoc.accuracy != null &&
          //         currentLocation.accuracy != null) {
          //       if ((currentLocation.accuracy! -
          //               deviceLoc.accuracy!.toDouble()) >
          //           10) {
          //         log('Location Changed');
          //         appStore.dispatch(GetLocationAction());
          //       }
          //     }
          //   }
          // });
        },
        shimmerLength: 0,
        paddingHorizontal: 0,
        showLeadingMenuBtn: true,
        child: (state) {
          return SingleChildScrollView(
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                  children: [SizedBox(height: 24.h), _IdleBody(state: state)]));
        },
      ),
    );
  }
}

class _IdleBody extends StatefulWidget {
  final AppState state;
  _IdleBody({required this.state});
  @override
  State<_IdleBody> createState() => _IdleBodyState();
}

class _IdleBodyState extends State<_IdleBody> {
  Map<String, dynamic> selectedShift = {};
  dynamic shiftStr;
  final TextEditingController commentContr = TextEditingController();
  final commentFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // MainScreen.timerController.start();
    setState(() {
      final CurrentStatusModel currentStatus =
          widget.state.modelsState.currentStatusModel;
      shiftStr = "${currentStatus.location} ${currentStatus.shift}";
      if (widget.state.modelsState.availableModel.shifts != null) {
        if (widget.state.modelsState.availableModel.shifts!
            .any((element) => element.name == shiftStr)) {
          selectedShift = {
            shiftStr: widget.state.modelsState.availableModel.shifts!
                .firstWhere((element) => element.name == shiftStr)
                .id!
          };
        }
      }
    });
  }

  @override
  void dispose() {
    commentContr.dispose();
    TimerController controller = Get.find();

    if (MainScreen.breakTimer != null) {
      MainScreen.breakTimer!.cancel();
    }
    MainScreen.breakTimer = null;
    controller.stopTimer();
    commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final bool isSignedIn =
        state.modelsState.currentStatusModel.status.toString() != "Signed out";
    final CurrentStatusModel currentStatus =
        state.modelsState.currentStatusModel;
    final DetailsModel detailsModel = state.modelsState.detailsModel;
    final List<Shifts>? shifts = state.modelsState.availableModel.shifts;
    final List<Shifts>? unavshifts =
        state.modelsState.availableModel.inactiveshifts;
    final List<Shifts>? completedshifts =
        state.modelsState.availableModel.completedshifts;
    final bool availableShift = shifts != null && shifts.isNotEmpty;
    final String username = detailsModel.firstName != null
        ? (detailsModel.lastName != null
            ? detailsModel.title != null
                ? detailsModel.title! +
                    " " +
                    detailsModel.firstName! +
                    " " +
                    detailsModel.lastName!
                : ""
            : "")
        : "";
    final String currentLocation = currentStatus.location.toString();
    final List<String> availableShifts = shifts != null
        ? shifts.map<String>((e) => e.name!).toList().toSet().toList()
        : [];
    final List<String> unAvailableShiftsNames = unavshifts != null
        ? unavshifts.map<String>((e) => e.name!).toList().toSet().toList()
        : [];
    final List<String> completedShiftsNames = completedshifts != null
        ? completedshifts.map<String>((e) => e.name!).toList().toSet().toList()
        : [];
    for (var element in unavshifts!) {
      availableShifts.add(element.name!);
    }
    final List<CustomList>? statuslist =
        state.modelsState.availableModel.statuses!.list;
    final showloc = state.uiState.showloc;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          WelcomeUserWidget(username: username, imageBase64: null),
          SizedBox(height: 11.h),
          if (showloc) _buildLocationWidget(state),
          SizedBox(height: 11.h),
          SpacedColumn(
            verticalSpace: 11,
            children: [
              RectangleWidget(
                  height: 60,
                  child: SpacedRow(
                    horizontalSpace: 26,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedText(
                          text: 'current_status',
                          textStyle: ThemeTextRegular.base1),
                      SpacedRow(
                        horizontalSpace: 5,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DotWidget(color: _getBtnColor(currentStatus.color)),
                          SizedText(
                              text: currentStatus.status,
                              textStyle: ThemeTextRegular.base1),
                        ],
                      ),
                    ],
                  )),
              RectangleWidget(
                  height: 89,
                  child: SpacedColumn(
                    verticalSpace: 11,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedText(
                          text: 'current_location',
                          textStyle: ThemeTextRegular.base1),
                      SpacedRow(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        horizontalSpace: 4,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.mapMarkerAlt,
                              color: ThemeColors.mainBlue, size: 12.h),
                          SizedText(
                              text: currentLocation,
                              textStyle: ThemeTextRegular.base1),
                        ],
                      ),
                    ],
                  )),
              const _BreakTimerWidget(),
              if (!availableShift)
                RectangleWidget(
                    height: 257,
                    child: SpacedColumn(
                      verticalSpace: 11,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.person,
                            size: 83.h, color: ThemeColors.lightGray),
                        SizedText(
                            text: 'waiting_shift',
                            textStyle: ThemeTextRegular.base1
                                .copyWith(color: ThemeColors.lightGray)),
                      ],
                    )),
              if (availableShift)
                RectangleWidget(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
                  child: SpacedColumn(
                    children: [
                      SizedText(
                          text: 'select_shift',
                          textStyle: ThemeTextRegular.base1),
                      SizedBox(height: 20.h),
                      SpacedColumn(
                        verticalSpace: 11,
                        children: [
                          DropdownWidget(
                              completedList: completedShiftsNames,
                              inactiveList: unAvailableShiftsNames,
                              onChanged: isSignedIn
                                  ? null
                                  : (_) {
                                      shiftStr = _;
                                      if (unAvailableShiftsNames.isNotEmpty &&
                                          unavshifts.firstWhereOrNull(
                                                  (element) =>
                                                      shiftStr ==
                                                      element.name) !=
                                              null) {
                                        selectedShift = {
                                          shiftStr: unavshifts
                                              .firstWhere((element) =>
                                                  element.name == shiftStr)
                                              .id!
                                        };
                                      } else {
                                        setState(() {
                                          selectedShift = {
                                            shiftStr: shifts
                                                .firstWhere((element) =>
                                                    element.name == shiftStr)
                                                .id!
                                          };
                                        });
                                      }
                                    },
                              dpValWidth: 220.w,
                              items: availableShifts,
                              value:
                                  selectedShift.isNotEmpty && shiftStr != null
                                      ? shiftStr
                                      : null,
                              leftIcon: FontAwesomeIcons.userClock,
                              hintText:
                                  selectedShift.isEmpty && shiftStr == null
                                      ? 'select_shift'
                                      : shiftStr),
                          DefaultInput(
                              hintText: 'comment',
                              controller: commentContr,
                              focusNode: commentFocusNode,
                              prefixIcon: FontAwesomeIcons.solidComments),
                        ],
                      ),
                      SizedBox(height: 21.h),
                      if (statuslist != null && statuslist.isNotEmpty)
                        SpacedColumn(
                            verticalSpace: 11,
                            children: statuslist
                                .map<Widget>(
                                  (e) => DefaultButton(
                                      msg: e.name!,
                                      onTap: () => _onStatusTap(e, state),
                                      bgColor: _getBtnColor(e.colour!)),
                                )
                                .toList()),
                    ],
                  ),
                )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationWidget(AppState state) {
    final String locs = state.modelsState.locations.join(", ");
    final String long = state.initState.longitude.toString();
    final String lat = state.initState.latitude.toString();
    return RectangleWidget(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: SpacedColumn(
          verticalSpace: 2,
          children: [
            SizedText(
                text: "current_location".tr + ": $locs",
                maxLines: 10,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible),
            SizedText(
              text: "($lat, $long)",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  _onStatusTap(CustomList e, AppState state) async {
    // final locations = state.modelsState.locations;
    // String selectedLocName = selectedShift.keys.toList()[0];
    // selectedLocName = selectedLocName.split(" ").toSet().toList().join(" ");
    // if (locations.contains(selectedLocName)) {
    final unavshifts = state.modelsState.availableModel.inactiveshifts ?? [];
    logger(shiftStr);
    logger(selectedShift);
    // unavshifts contain show popup
    if (unavshifts.any((element) =>
        int.parse(element.id) == int.parse(selectedShift[shiftStr]))) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("unavailable_shift".tr),
                content: Text("unavailable_shift_msg".tr),
                actions: <Widget>[
                  FlatButton(
                    child: Text("ok".tr),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ));
    } else {
      await appStore.dispatch(GetPostCurrentStatusAction(
          comment: commentContr.text,
          shift_id: selectedShift[shiftStr],
          status_id: e.id,
          undo: false));
    }
    commentContr.clear();
    commentFocusNode.unfocus();
  }

  _getBtnColor(String? iconColor) {
    if (iconColor == null) return const Color(0xFF000000);
    final int colorCode = int.parse('0xFF$iconColor');
    return Color(colorCode);
  }
}

class _BreakTimerWidget extends StatelessWidget {
  const _BreakTimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) => GetX<TimerController>(
              builder: (c) => Visibility(
                visible: c.timerText.value.isNotEmpty,
                child: RectangleWidget(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                    child: SpacedColumn(verticalSpace: 11, children: [
                      SizedText(
                          text: 'timer', textStyle: ThemeTextRegular.base1),
                      SizedText(
                          text: c.timerText.value,
                          textStyle: ThemeTextRegular.lg2),
                    ]),
                  ),
                ),
              ),
            ));
  }
}
