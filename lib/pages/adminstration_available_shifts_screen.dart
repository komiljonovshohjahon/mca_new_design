import 'dart:developer';

import 'package:mca_new_design/template/base/template.dart';

import '../manager/redux/states/ui_state.dart';

class AdministrationAvailableShiftsScreen extends StatefulWidget {
  const AdministrationAvailableShiftsScreen({Key? key}) : super(key: key);

  @override
  State<AdministrationAvailableShiftsScreen> createState() =>
      _AdministrationAvailableShiftsScreenState();
}

class _AdministrationAvailableShiftsScreenState
    extends State<AdministrationAvailableShiftsScreen> {
  static List _availableShifts = [];
  static List _availableAllocations = [];

  _resetLocs() {
    setState(() {});
  }

  @override
  void dispose() {
    _availableShifts.clear();
    _availableAllocations.clear();
    appStore.dispatch(UpdateUIAction(isPublished: false, isUnPublished: false));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      shimmerLength: 10,
      onInit: () {
        bool isPub = false;
        bool isUnPub = false;
        Map? res = GETSTATE(context).modelsState.mobileAdmin;
        final int _oldLocId = int.parse(
            AdministrationLocationScreen.selectedLocation['location']!['key']!);
        final int _oldUserId = int.parse(
            AdministrationLocationScreen.selectedLocation['user']!['key']!);
        for (var shift in res['shifts']) {
          if (shift['location']['id'] == _oldLocId) {
            // int olduserId = int.parse(shift['shifts'].keys.first);
            _availableShifts.add(shift);
            List<bool> _allocpublished = [];
            if (res['allocations'] != null) {
              for (var alloc in res['allocations']) {
                if (int.parse(alloc['locationId']) == shift['location']['id']) {
                  _allocpublished.add(alloc['published']);
                  //CHECK PUB/UNPUB START
                  int _shiftshiftId = shift['shifts'].values.first['shiftId'];
                  int _allocshiftId = int.parse(alloc['shiftId']);
                  if (_shiftshiftId == _allocshiftId) {
                    if (alloc.containsKey('userId')) {
                      if (int.parse(alloc['userId']) == _oldUserId) {
                        isPub = true;
                      }
                    }
                  }
                }
                //CHECK PUB/UNPUB END
                _availableAllocations.add(alloc);
              }
            }
            isUnPub = _allocpublished.contains(true);
            isPub = _allocpublished.contains(false);
          }
        }

        appStore.dispatch(
            UpdateUIAction(isPublished: isPub, isUnPublished: isUnPub));
        setState(() {});
      },
      showLeadingMenuBtn: true,
      showActionBell: () {},
      showActionMsg: () {},
      paddingHorizontal: 0,
      paddingTop: 23,
      footer: (state) => Row(
        children: [
          Visibility(
              visible: state.uiState.isPublished,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: DefaultButton(
                  width: 150.w,
                  msg: 'publish',
                  onTap: () async {
                    await appStore
                        .dispatch(GetPostMobileAdminAction(action: "publish"));
                  },
                ),
              )),
          Visibility(
              visible: state.uiState.isUnPublished,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: DefaultButton(
                  width: 150.w,
                  msg: 'unpublish',
                  bgColor: ThemeColors.mainRed,
                  onTap: () async {
                    await appStore.dispatch(
                        GetPostMobileAdminAction(action: "unpublish"));
                  },
                ),
              )),
        ],
      ),
      child: (state) {
        return _IdleBody(state: state, reset: _resetLocs);
      },
    );
  }
}

class _IdleBody extends StatelessWidget {
  final AppState state;
  final Function() reset;
  _IdleBody({required this.state, required this.reset});
  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfo(),
        SizedBox(height: 23.h),
        _buildTitle(),
        SizedBox(height: 14.h),
        if (_AdministrationAvailableShiftsScreenState
            ._availableShifts.isNotEmpty)
          _buildShiftsList(),
      ],
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SpacedColumn(
        verticalSpace: 13,
        children: [
          SpacedRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            horizontalSpace: 10,
            children: [
              const FaIcon(FontAwesomeIcons.mapMarkerAlt,
                  color: ThemeColors.mainBlue),
              SizedText(
                  width: 240.w,
                  text: AdministrationLocationScreen
                      .selectedLocation['location']!['value'],
                  textStyle: ThemeTextRegular.base1)
            ],
          ),
          SpacedRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            horizontalSpace: 10,
            children: [
              const FaIcon(FontAwesomeIcons.userAlt,
                  color: ThemeColors.mainBlue),
              SizedText(
                  width: 240.w,
                  text: AdministrationLocationScreen
                      .selectedLocation['user']!['value'],
                  textStyle: ThemeTextRegular.base1)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedText(
          text: 'available_shifts',
          textStyle: ThemeTextBold.lg.copyWith(color: ThemeColors.mainBlue)),
    );
  }

  Widget _buildShiftsList() {
    final shiftsVals = _AdministrationAvailableShiftsScreenState
        ._availableShifts.first['shifts'].values
        .toList();

    return Flexible(
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemCount: shiftsVals.length,
          itemBuilder: (_, index) {
            return _buildListItem(shiftsVals[index]);
          }),
    );
  }

  Widget _buildListItem(Map shift) {
    final int _oldUserId = int.parse(
        AdministrationLocationScreen.selectedLocation['user']!['key']!);
    final String _oldUserName =
        AdministrationLocationScreen.selectedLocation['user']!['value']!;
    final int shiftshiftId = shift['shiftId'];
    Map? alloc = _AdministrationAvailableShiftsScreenState._availableAllocations
        .firstWhereOrNull((element) =>
            element.containsKey('shiftId') &&
            int.parse(element['shiftId']) == shiftshiftId);

    final int allocshiftId = alloc != null ? int.parse(alloc['shiftId']) : -1;
    bool isPublished = alloc != null ? alloc['published'] : false;
    bool isAdded = false;
    if (alloc != null) {
      if (int.parse(alloc['userId']) == _oldUserId) {
        isAdded = shiftshiftId == allocshiftId;
      }
    }
    List<String> addedUsers = [];

    for (var element
        in _AdministrationAvailableShiftsScreenState._availableAllocations) {
      if (shift['shiftId'] == int.parse(element['shiftId'])) {
        addedUsers.add(element['userFullname']);
        // alloc = element;
      }
    }

    final int? currentG = shift['guests']['current'];
    final int? maxG = shift['guests']['maximum'];
    final int? minG = shift['guests']['minimum'];
    return RectangleWidget(
        child: Padding(
      padding:
          EdgeInsets.only(right: 28.w, left: 13.w, top: 12.h, bottom: 13.h),
      child: SpacedColumn(
        verticalSpace: 20,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpacedColumn(verticalSpace: 10, children: [
                _buildIcText(shift['title'], FontAwesomeIcons.userClock),
                _buildIcText(shift['timings'], FontAwesomeIcons.solidClock),
                if (shift['minWorkTime'] != null)
                  _buildIcText(
                      shift['minWorkTime'], FontAwesomeIcons.hourglass),
                if (shift['paidTime'] != null)
                  _buildIcText(shift['paidTime'], FontAwesomeIcons.moneyBill),
                ...addedUsers
                    .map<Widget>(
                      (e) => _buildIcText(e, FontAwesomeIcons.users,
                          additionIconColor: addedUsers.indexOf(e) != 0
                              ? ThemeColors.transparent
                              : ThemeColors.mainBlue,
                          color: _oldUserName == e
                              ? ThemeColors.mainBlue
                              : ThemeColors.black),
                    )
                    .toList(),
              ]),
              if (!isPublished)
                DecoratedBox(
                  decoration: BoxDecoration(
                      color:
                          isAdded ? ThemeColors.mainRed : ThemeColors.mainGreen,
                      borderRadius: BorderRadius.circular(4.r)),
                  child: IconButton(
                      padding: EdgeInsets.all(15.w),
                      color: ThemeColors.white,
                      icon: FaIcon(isAdded
                          ? FontAwesomeIcons.minus
                          : FontAwesomeIcons.plus),
                      onPressed: () async {
                        if (isAdded) {
                          await appStore.dispatch(GetPostMobileAdminAction(
                              action: "remove", shiftId: shiftshiftId));
                        } else {
                          await appStore.dispatch(GetPostMobileAdminAction(
                              action: "add", shiftId: shiftshiftId));
                        }
                      }),
                ),
            ],
          ),
          if (currentG != null && maxG != null && minG != null)
            _buildGuestsWidget(currentG, maxG, minG, shiftshiftId),
        ],
      ),
    ));
  }

  _buildIcText(String msg, IconData icon,
      {Color color = ThemeColors.black, Color? additionIconColor}) {
    return SpacedRow(
      crossAxisAlignment: CrossAxisAlignment.center,
      horizontalSpace: 10,
      children: [
        FaIcon(icon,
            color: additionIconColor ?? ThemeColors.mainBlue, size: 10.h),
        SizedText(
            width: 163.w,
            text: msg,
            textStyle: ThemeTextRegular.sm.copyWith(color: color))
      ],
    );
  }

  _buildGuestsWidget(int current, int max, int min, int shiftshiftId) {
    return SpacedRow(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Opacity(
          opacity: current == min ? 0 : 1,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: ThemeColors.mainRed,
                  borderRadius: BorderRadius.circular(4.r)),
              child: IconButton(
                  alignment: Alignment.center,
                  iconSize: 15.h,
                  constraints: BoxConstraints.tight(Size(30.w, 30.w)),
                  color: ThemeColors.white,
                  icon: const FaIcon(FontAwesomeIcons.minus),
                  onPressed: () async {
                    await appStore.dispatch(GetPostMobileAdminAction(
                        action: "less", shiftId: shiftshiftId));
                  })),
        ),
        SizedText(
            width: 163.w,
            textAlign: TextAlign.center,
            text: 'guests'.tr + ": " + current.toString(),
            textStyle: ThemeTextRegular.sm),
        Opacity(
          opacity: current == max ? 0 : 1,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: ThemeColors.mainGreen,
                  borderRadius: BorderRadius.circular(4.r)),
              child: IconButton(
                  alignment: Alignment.center,
                  iconSize: 15.h,
                  constraints: BoxConstraints.tight(Size(30.w, 30.w)),
                  color: ThemeColors.white,
                  icon: const FaIcon(FontAwesomeIcons.plus),
                  onPressed: () async {
                    await appStore.dispatch(GetPostMobileAdminAction(
                        action: "more", shiftId: shiftshiftId));
                  })),
        ),
      ],
    );
  }
}
