import 'package:mca_new_design/manager/models/model_exporter.dart';
import 'package:mca_new_design/template/base/template.dart';

class TimesheetScreen extends StatefulWidget {
  static DateTime fromDate = DateTime.now();
  static DateTime toDate = fromDate;
  const TimesheetScreen({Key? key}) : super(key: key);

  @override
  State<TimesheetScreen> createState() => _TimesheetScreenState();
}

class _TimesheetScreenState extends State<TimesheetScreen> {
  @override
  void dispose() {
    TimesheetScreen.fromDate = DateTime.now();
    TimesheetScreen.toDate = TimesheetScreen.fromDate;
    super.dispose();
  }

  void switcher() {
    DateTime fromDate = TimesheetScreen.fromDate;

    switch (fromDate.weekday) {
      case 1:
        fromDate = fromDate;
        break;
      case 2:
        fromDate = fromDate.subtract(1.days);
        break;
      case 3:
        fromDate = fromDate.subtract(2.days);
        break;
      case 4:
        fromDate = fromDate.subtract(3.days);
        break;
      case 5:
        fromDate = fromDate.subtract(4.days);
        break;
      case 6:
        fromDate = fromDate.subtract(5.days);
        break;
      case 7:
        fromDate = fromDate.subtract(6.days);
        break;
    }
    TimesheetScreen.fromDate = fromDate;
    TimesheetScreen.toDate = fromDate.add(6.days);
  }

  @override
  Widget build(BuildContext context) {
    switcher();

    return DefaultBody(
      shimmerLength: 10,
      paddingTop: 10,
      showArrowRight: () async {
        TimesheetScreen.fromDate = TimesheetScreen.toDate.add(1.days);
        TimesheetScreen.toDate = TimesheetScreen.toDate.add(7.days);
        appStore.isLoading(true);
        await appStore.dispatch(GetTimesheetAction());
        appStore.isLoading(false);
      },
      showArrowLeft: () async {
        TimesheetScreen.toDate = TimesheetScreen.fromDate.subtract(1.days);
        TimesheetScreen.fromDate = TimesheetScreen.fromDate.subtract(7.days);
        appStore.isLoading(true);
        await appStore.dispatch(GetTimesheetAction());
        appStore.isLoading(false);
      },
      showActionMenu: () {},
      onInit: () async {
        appStore.isLoading(true);
        await appStore.dispatch(GetTimesheetAction());
        appStore.isLoading(false);
      },
      showLeadingMenuBtn: true,
      paddingHorizontal: 0,
      child: (state) {
        return SpacedColumn(
          verticalSpace: 6,
          children: [
            _buildHeader(),
            _TimeSheetListWidget(state: state),
          ],
        );
      },
    );
  }

  _buildHeader() {
    return RectangleWidget(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: SpacedRow(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedText(text: 'date', textStyle: ThemeTextSemibold.base),
            SizedText(text: 'details', textStyle: ThemeTextSemibold.base),
            SizedText(text: 'hours', textStyle: ThemeTextSemibold.base),
          ],
        ),
      ),
    );
  }
}

class _TimeSheetListWidget extends StatefulWidget {
  AppState state;
  List<String> dates = [];
  Map timesheetModel = {};
  _TimeSheetListWidget({Key? key, required this.state}) : super(key: key) {
    timesheetModel = state.modelsState.timesheet;
  }

  @override
  State<_TimeSheetListWidget> createState() => _TimeSheetListWidgetState();
}

class _TimeSheetListWidgetState extends State<_TimeSheetListWidget> {
  int openedIndex = -1;

  _setOpenItem(int i) {
    setState(() {
      if (openedIndex == i) {
        openedIndex = -1;
      } else {
        openedIndex = i;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.separated(
          itemBuilder: (context, index) {
            final date = widget.timesheetModel.keys.toList()[index];
            final timeSheetData =
                widget.timesheetModel.values.toList()[index].isEmpty
                    ? null
                    : widget.timesheetModel.values.toList()[index]['timesheet'];
            final holidayData =
                widget.timesheetModel.values.toList()[index].isEmpty
                    ? null
                    : widget.timesheetModel.values.toList()[index]['holidays'];
            final unavaiData = widget.timesheetModel.values
                    .toList()[index]
                    .isEmpty
                ? null
                : widget.timesheetModel.values.toList()[index]['unavailable'];

            return _listItem(
                date, timeSheetData, holidayData, unavaiData, index);
          },
          separatorBuilder: (_, __) => SizedBox(height: 6.h),
          itemCount: widget.timesheetModel.keys.length),
    );
  }

  Widget _listItem(String timeSheetData, List? timesheet, List? holidays,
      Map<String, dynamic>? unav, int index) {
    final String date =
        getDateWithWeekday(DateTime.parse(timeSheetData), subDay: 3);
    //Timesheet
    final bool isTimesheet = timesheet != null;
    final List<TimesheetModel?> timesheetModelList = !isTimesheet
        ? []
        : timesheet
            .map<TimesheetModel?>(
                (e) => e == null ? null : TimesheetModel.fromJson(e))
            .toList();
    double totalTime = 0.0;
    for (TimesheetModel? model in timesheetModelList) {
      totalTime += model != null
          ? model.worktime == null
              ? 0.0
              : model.worktime! / 60
          : 0.0;
    }
    //Timesheet
    //////////////////////////////
    //Holdays
    final bool isHoliday = holidays != null;
    final List<HolidayModel?> holidayModelList = !isHoliday
        ? []
        : holidays
            .map<HolidayModel?>(
                (e) => e == null ? null : HolidayModel.fromJson(e))
            .toList();
    //Holdays
    /////////////////////////////////
    //Unavailable
    final bool isDayoff = unav != null;
    final UnavailableModel? unavModel =
        !isDayoff ? null : UnavailableModel.fromJson(unav);
    //Unavailable

    Color color1 = ThemeColors.mainBlue;
    Color color2 = ThemeColors.transparent;
    Color color3 = ThemeColors.mainRed;

    if (isHoliday) {
      if (holidayModelList.first != null) {
        color2 =
            Constants.timesheetColorMapper[holidayModelList.first!.status] ??
                ThemeColors.transparent;
      }
    }
    return SpacedColumn(
      verticalSpace: 4,
      children: [
        RectangleWidget(
            height: isTimesheet
                ? timesheetModelList.length > 1
                    ? null
                    : 59
                : 59,
            onTap: () => _setOpenItem(index),
            child: SpacedRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedText(
                      textAlign: TextAlign.center,
                      text: date,
                      textStyle: int.tryParse(date.substring(0, 2)) != null &&
                              int.tryParse(date.substring(0, 2)) ==
                                  DateTime.now().day
                          ? ThemeTextSemibold.base
                          : null),
                ),
                Expanded(
                  flex: 3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                width: 1.w, color: ThemeColors.grayish),
                            left: BorderSide(
                                width: 1.w, color: ThemeColors.grayish))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 14.h),
                      child: SpacedRow(
                        horizontalSpace: 8,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20.w,
                            child: SpacedColumn(
                              verticalSpace: 1,
                              children: [
                                if (isTimesheet)
                                  DotWidget(height: 6.h, color: color1),
                                SpacedRow(
                                  horizontalSpace: 1,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (isHoliday)
                                      DotWidget(height: 6.h, color: color2),
                                    if (isDayoff)
                                      DotWidget(height: 6.h, color: color3),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isTimesheet)
                            SpacedColumn(
                              verticalSpace: 2,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: timesheetModelList
                                  .map<Widget>((e) => e == null
                                      ? const SizedBox()
                                      : SpacedRow(
                                          horizontalSpace: 4,
                                          children: [
                                            SizedText(
                                                width: 120.w,
                                                softWrap: false,
                                                maxLines: 1,
                                                text: e.shift),
                                            SizedText(
                                                softWrap: false,
                                                maxLines: 1,
                                                text: ((e.worktime ?? 0) / 60)
                                                    .toStringAsFixed(2)),
                                          ],
                                        ))
                                  .toList(),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedText(
                      width: 45.w,
                      textAlign: TextAlign.center,
                      text: totalTime.toStringAsFixed(2)),
                ),
              ],
            )),
        Visibility(
          visible: index == openedIndex,
          child: SpacedColumn(
            verticalSpace: 6,
            children: [
              ...holidayModelList
                  .map<Widget>((e) => e == null
                      ? const SizedBox()
                      : RectangleWidget(
                          child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 14.h),
                          child: SpacedColumn(
                            verticalSpace: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SpacedRow(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                horizontalSpace: 14,
                                children: [
                                  DotWidget(height: 6.h, color: color2),
                                  SizedText(
                                    text: e.type!.capitalize ?? " ",
                                    textStyle: ThemeTextRegular.lg
                                        .copyWith(color: ThemeColors.mainBlue),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 18.w),
                                child: SpacedColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  verticalSpace: 13,
                                  children: [
                                    SpacedRow(
                                      horizontalSpace: 10,
                                      children: [
                                        FaIcon(FontAwesomeIcons.mapMarkerAlt,
                                            size: 15.h,
                                            color: ThemeColors.mainBlue),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedText(
                                              text: "req_type",
                                              textStyle: ThemeTextRegular.sm
                                                  .copyWith(
                                                      color:
                                                          ThemeColors.mainBlue),
                                            ),
                                            SizedText(text: (e.name ?? " ")),
                                          ],
                                        )
                                      ],
                                    ),
                                    SpacedRow(
                                      horizontalSpace: 10,
                                      children: [
                                        FaIcon(FontAwesomeIcons.toggleOn,
                                            size: 10.h,
                                            color: ThemeColors.mainBlue),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedText(
                                              text: "status",
                                              textStyle: ThemeTextRegular.sm
                                                  .copyWith(
                                                      color:
                                                          ThemeColors.mainBlue),
                                            ),
                                            SizedText(text: (e.status ?? " ")),
                                          ],
                                        )
                                      ],
                                    ),
                                    SpacedRow(
                                      horizontalSpace: 10,
                                      children: [
                                        FaIcon(FontAwesomeIcons.solidClock,
                                            size: 10.h,
                                            color: ThemeColors.mainBlue),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedText(
                                              text:
                                                  "date".tr + " / " + "time".tr,
                                              textStyle: ThemeTextRegular.sm
                                                  .copyWith(
                                                      color:
                                                          ThemeColors.mainBlue),
                                            ),
                                            SizedText(
                                                text: (e.startDate ?? " ") +
                                                    " - " +
                                                    (e.endDate ?? " ")),
                                          ],
                                        )
                                      ],
                                    ),
                                    if (e.comment != null)
                                      SpacedRow(
                                        horizontalSpace: 10,
                                        children: [
                                          FaIcon(FontAwesomeIcons.toggleOn,
                                              size: 10.h,
                                              color: ThemeColors.mainBlue),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedText(
                                                text: "comment",
                                                textStyle: ThemeTextRegular.sm
                                                    .copyWith(
                                                        color: ThemeColors
                                                            .mainBlue),
                                              ),
                                              SizedText(text: (e.comment)),
                                            ],
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )))
                  .toList(),
              ...timesheetModelList
                  .map<Widget>((e) => e == null
                      ? const SizedBox()
                      : RectangleWidget(
                          child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 14.h),
                          child: SpacedRow(
                            horizontalSpace: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DotWidget(height: 6.h, color: color1),
                              SpacedColumn(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                verticalSpace: 13,
                                children: [
                                  SpacedRow(
                                    horizontalSpace: 30,
                                    children: [
                                      FaIcon(FontAwesomeIcons.mapMarkerAlt,
                                          size: 15.h,
                                          color: ThemeColors.mainBlue),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedText(
                                            text: "location".tr +
                                                " / " +
                                                "shift".tr,
                                            textStyle: ThemeTextRegular.sm
                                                .copyWith(
                                                    color:
                                                        ThemeColors.mainBlue),
                                          ),
                                          SizedText(
                                              text: (e.location ?? " ") +
                                                  " " +
                                                  (e.shift ?? " ")),
                                        ],
                                      )
                                    ],
                                  ),
                                  SpacedRow(
                                    horizontalSpace: 30,
                                    children: [
                                      FaIcon(FontAwesomeIcons.userClock,
                                          size: 10.h,
                                          color: ThemeColors.mainBlue),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedText(
                                            text: "agreed_time",
                                            textStyle: ThemeTextRegular.sm
                                                .copyWith(
                                                    color:
                                                        ThemeColors.mainBlue),
                                          ),
                                          SizedText(
                                              text: (e.agreedStartTime ?? " ") +
                                                  " - " +
                                                  (e.agreedFinishTime ?? " ")),
                                        ],
                                      )
                                    ],
                                  ),
                                  SpacedRow(
                                    horizontalSpace: 30,
                                    children: [
                                      FaIcon(FontAwesomeIcons.solidClock,
                                          size: 15.h,
                                          color: ThemeColors.mainBlue),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedText(
                                            text: 'actual_time',
                                            textStyle: ThemeTextRegular.sm
                                                .copyWith(
                                                    color:
                                                        ThemeColors.mainBlue),
                                          ),
                                          SizedText(
                                              text: (e.actualStartTime ?? " ") +
                                                  " - " +
                                                  (e.actualFinishTime ?? " ")),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )))
                  .toList(),
              if (isDayoff)
                RectangleWidget(
                    child: Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 14.h),
                  child: SpacedColumn(
                    verticalSpace: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SpacedRow(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        horizontalSpace: 14,
                        children: [
                          DotWidget(height: 6.h, color: color3),
                          SizedText(
                            text: "unav_to_work",
                            textStyle: ThemeTextRegular.lg
                                .copyWith(color: ThemeColors.mainBlue),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18.w),
                        child: SpacedColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          verticalSpace: 13,
                          children: [
                            SpacedRow(
                              horizontalSpace: 10,
                              children: [
                                FaIcon(FontAwesomeIcons.hourglass,
                                    size: 10.h, color: ThemeColors.mainBlue),
                                SizedText(
                                    text: (unavModel!.dateFrom ?? " ") +
                                        " - " +
                                        (unavModel.timeUntil ?? " "))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: DefaultButton(
                              height: 40.h,
                              bottomRadius: false,
                              radius: 20,
                              msg: 'revoke',
                              width: 300.w,
                              bgColor: ThemeColors.mainBlue,
                              onTap: () =>
                                  _onRevoke(unavModel.availabilityId))),
                    ],
                  ),
                )),
            ],
          ),
        ),
      ],
    );
  }

  _onRevoke(int? id) async {
    //onRevoke
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: SizedText(text: 'information'),
          content: SizedText(text: 'want_to_revoke'),
          actions: [
            ElevatedButton(
              onPressed: () => appStore.popupPop(),
              child: SizedText(text: 'no'),
            ),
            ElevatedButton(
              onPressed: () async {
                appStore.popupPop();
                await appStore
                    .dispatch(GetPostUnavAction(revoke: true, id: id));
              },
              child: SizedText(text: 'yes'),
            ),
          ],
        );
      },
    );
  }
}
