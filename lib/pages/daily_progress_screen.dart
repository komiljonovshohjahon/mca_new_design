import 'package:mca_new_design/template/base/template.dart';

class DailyProgressScreen extends StatefulWidget {
  const DailyProgressScreen({Key? key}) : super(key: key);

  @override
  State<DailyProgressScreen> createState() => _DailyProgressScreenState();
}

class _DailyProgressScreenState extends State<DailyProgressScreen> {
  _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      shimmerLength: 4,
      paddingTop: 10,
      showActionMsg: () {},
      showActionBell: () {},
      onInit: () async {
        appStore.isLoading(true);
        await appStore.dispatch(GetDailyProgressAction());
        appStore.isLoading(false);
      },
      showLeadingMenuBtn: true,
      paddingHorizontal: 0,
      child: (state) {
        List? process;
        if (state.modelsState.dailyProgress['process'] != null) {
          process = state
              .modelsState.dailyProgress['process']?.values.first.values
              .toList();
        }
        return Column(
          children: [
            if (process != null) _IdleBody(state: state, rebuild: _rebuild),
            Flexible(
              child: SingleChildScrollView(
                  child: SpacedColumn(
                verticalSpace: 10,
                children: [
                  if (process == null)
                    Align(
                        alignment: Alignment.center,
                        child: SizedText(text: 'no_daily_progress')),
                  if (process != null)
                    _BottomBody(
                        progress: process,
                        currentUsername:
                            state.modelsState.detailsModel.firstName! +
                                ' ' +
                                state.modelsState.detailsModel.lastName!)
                ],
              )),
            ),
          ],
        );
      },
    );
  }
}

class _IdleBody extends StatelessWidget {
  final AppState state;
  final VoidCallback rebuild;
  _IdleBody({required this.state, required this.rebuild});
  static Map<Color, bool> staticColrs = {
    Colors.red: true,
    Colors.green: true,
    Colors.orangeAccent: true
  };
  static String? selectedClient;

  @override
  Widget build(BuildContext context) {
    final List process = state
            .modelsState.dailyProgress['process'].values.first.values
            .toList() ??
        [];
    final issues = state.modelsState.dailyProgress['issues'] ?? [];
    List clients = process.map((e) => e['client']).toList().toSet().toList();
    clients.removeWhere((element) => element == null);
    clients.add('1');
    clients.sort();
    return _ProgressHead(clients: clients, rebuild: rebuild);
  }
}

class _ProgressHead extends StatefulWidget {
  final List? clients;
  final VoidCallback rebuild;
  _ProgressHead({Key? key, required this.clients, required this.rebuild})
      : super(key: key);

  @override
  State<_ProgressHead> createState() => _ProgressHeadState();
}

class _ProgressHeadState extends State<_ProgressHead> {
  @override
  void dispose() {
    _IdleBody.selectedClient = null;
    _IdleBody.staticColrs = {
      Colors.red: true,
      Colors.green: true,
      Colors.orangeAccent: true
    };
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List _l = [];
    if (widget.clients != null) {
      _l = [...widget.clients!];
    }

    _l.replaceRange(0, 0, ['all']);
    _l.removeAt(1);
    return PhysicalModel(
      color: ThemeColors.transparent,
      elevation: 4,
      child: RectangleWidget(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 1.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: SpacedRow(horizontalSpace: 25, children: [
              SpacedColumn(
                  verticalSpace: 12,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedText(text: 'client', textStyle: ThemeTextRegular.base),
                    SizedBox(
                      width: 200.w,
                      height: 42.h,
                      child: DropdownWidget(
                        dpValWidth: 140.w,
                        onChanged: (value) {
                          if (value.toString().tr == 'all'.tr) {
                            setState(() {
                              _IdleBody.selectedClient = null;
                            });
                          } else {
                            _IdleBody.selectedClient = null;
                            setState(() {
                              _IdleBody.selectedClient = value;
                            });
                          }
                        },
                        value: _IdleBody.selectedClient,
                        leftIcon: FontAwesomeIcons.userTie,
                        hintText: 'select_client',
                        items: _l,
                      ),
                    ),
                  ]),
              SpacedColumn(
                  verticalSpace: 12,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedText(text: 'status', textStyle: ThemeTextRegular.base),
                    SpacedRow(
                      horizontalSpace: 10,
                      children: [
                        _buildCheckbox(
                          _IdleBody.staticColrs[Colors.green]!,
                          (value) {
                            setState(() {
                              _IdleBody.staticColrs
                                  .update(Colors.green, (_) => value!);
                            });
                          },
                          activeColor: Colors.green,
                        ),
                        _buildCheckbox(
                          _IdleBody.staticColrs[Colors.orangeAccent]!,
                          (value) {
                            setState(() {
                              _IdleBody.staticColrs
                                  .update(Colors.orangeAccent, (_) => value!);
                            });
                          },
                          activeColor: Colors.orangeAccent,
                        ),
                        _buildCheckbox(
                          _IdleBody.staticColrs[Colors.red]!,
                          (value) {
                            setState(() {
                              _IdleBody.staticColrs
                                  .update(Colors.red, (_) => value!);
                            });
                          },
                          activeColor: Colors.red,
                        ),
                      ],
                    ),
                  ]),
            ]),
          ),
          _buildStack(),
        ],
      )),
    );
  }

  _buildStack() {
    return Column(
      children: [
        RectangleWidget(
            height: 43,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedText(text: 'details', textStyle: ThemeTextRegular.sm),
                  SizedText(text: 'timing', textStyle: ThemeTextRegular.sm),
                ],
              ),
            )),
        Row(
          children: [
            Container(
              width: 120.w,
              height: 3.h,
              decoration: BoxDecoration(
                  color: _IdleBody.staticColrs[Colors.green]!
                      ? Colors.green
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4.r),
                      bottomRight: Radius.circular(4.r))),
            ),
            Container(
              width: 120.w,
              height: 3.h,
              decoration: BoxDecoration(
                  color: _IdleBody.staticColrs[Colors.orangeAccent]!
                      ? Colors.orangeAccent
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4.r),
                      bottomRight: Radius.circular(4.r))),
            ),
            Container(
              width: 120.w,
              height: 3.h,
              decoration: BoxDecoration(
                  color: _IdleBody.staticColrs[Colors.red]!
                      ? Colors.red
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4.r),
                      bottomRight: Radius.circular(4.r))),
            )
          ],
        ),
      ],
    );
  }

  _buildCheckbox(bool val, ValueChanged<bool?>? onChanged,
      {required Color activeColor}) {
    return Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeColor: activeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.r)),
        value: val,
        side: BorderSide(width: 1.5.w, color: activeColor),
        onChanged: (_) {
          onChanged!(_);
          widget.rebuild();
        });
  }
}

class _BottomBody extends StatefulWidget {
  final List? progress;
  List<Map> deepCleaning = [];
  final String currentUsername;
  _BottomBody({required this.progress, required this.currentUsername}) {
    if (progress != null) {
      deepCleaning =
          progress != null ? progress!.map((e) => e as Map).toList() : [];
    }
  }

  @override
  State<_BottomBody> createState() => _BottomBodyState();
}

class _BottomBodyState extends State<_BottomBody> {
  int? openedTile;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: SpacedColumn(
        verticalSpace: 4,
        children: [
          if (widget.deepCleaning.isNotEmpty) ..._buildListTiles(),
        ],
      ),
    );
  }

  _buildListTiles() {
    int index = 0;
    List<Widget> list = [];

    _addToList(Color color, Map element) {
      final String? start = element['start'];
      final String? finish = element['finish'];
      final Map users = element['users'] ?? {};
      final name = element['location'] + " " + element['shift'];
      final String status = element['status'] ?? "unknown";
      final String paymentRate = element['specialRate'] != null
          ? element['specialRate'].toString()
          : 'normal_rate';
      final Map? property = element['property'];
      final Map? bedrooms = property != null
          ? {
              'icon': Constants.propertyIcons['bedrooms'],
              'count': property['bedrooms']
            }
          : null;
      final Map? bathrooms = property != null
          ? {
              'icon': Constants.propertyIcons['bathrooms'],
              'count': property['bathrooms']
            }
          : null;
      final Map? sleeps = property != null
          ? {
              'icon': Constants.propertyIcons['sleeps'],
              'count': "${property['min_sleeps']}-${property['sleeps']}"
            }
          : null;
      list.add(_buildTile(color, name, users,
          start: start,
          finish: finish,
          index: index,
          status: status,
          paymentRate: paymentRate,
          property: property,
          bathrooms: bathrooms,
          bedrooms: bedrooms,
          sleeps: sleeps));
      index += 1;
    }

    if (_IdleBody.staticColrs[Colors.green]!) {
      for (var element in widget.deepCleaning) {
        if (element['status'] == 'done') {
          if (_IdleBody.selectedClient == null) {
            if (element['status'] == 'done') {
              _addToList(Colors.green, element);
            }
          } else if (_IdleBody.selectedClient != null &&
              element['client']
                  .toString()
                  .contains(_IdleBody.selectedClient!)) {
            _addToList(Colors.green, element);
          }
        }
      }
    }
    if (_IdleBody.staticColrs[Colors.red]!) {
      for (var element in widget.deepCleaning) {
        if (element['status'] == 'queue') {
          if (_IdleBody.selectedClient == null) {
            if (element['status'] == 'queue') {
              _addToList(Colors.red, element);
            }
          } else if (_IdleBody.selectedClient != null &&
              element['client']
                  .toString()
                  .contains(_IdleBody.selectedClient!)) {
            _addToList(Colors.red, element);
          }
        }
      }
    }
    if (_IdleBody.staticColrs[Colors.orangeAccent]!) {
      for (var element in widget.deepCleaning) {
        if (element['status'] == 'progress') {
          if (_IdleBody.selectedClient == null) {
            if (element['status'] == 'progress') {
              _addToList(Colors.orangeAccent, element);
            }
          } else if (_IdleBody.selectedClient != null &&
              element['client']
                  .toString()
                  .contains(_IdleBody.selectedClient!)) {
            _addToList(Colors.orangeAccent, element);
          }
        }
      }
    }
    return list;
  }

  _buildTile(Color color, String shift, Map users,
      {String? start,
      String? finish,
      required int index,
      Map? property,
      required String status,
      required String paymentRate,
      Map? bedrooms,
      Map? bathrooms,
      Map? sleeps}) {
    String startTime = start != null
        ? "${DateTime.parse(start).hour}:${DateTime.parse(start).minute}"
        : "";
    String endTime = finish != null
        ? "${DateTime.parse(finish).hour}:${DateTime.parse(finish).minute}"
        : "";
    final List usernames = users.isNotEmpty ? users.values.toList() : [];
    final List usernameStartTimes = [];
    final List usernameFinishTimes = [];
    final String? notes = property != null
        ? (property['notes'].toString().isNotEmpty
            ? property['notes'].toString()
            : null)
        : null;

    if (usernames.isNotEmpty) {
      final tempList = [];
      for (var element in usernames) {
        if (element.containsKey("start") && element["start"] != null) {
          usernameStartTimes.add(DateTime.tryParse(element["start"]));
        } else {
          usernameStartTimes.add(null);
        }
        if (element.containsKey("finish") && element["finish"] != null) {
          usernameFinishTimes.add(DateTime.tryParse(element["finish"]));
        } else {
          usernameFinishTimes.add(null);
        }
        if (element['fullname'] != null) {
          tempList.add(element['fullname']);
        } else {
          tempList.add(" ");
        }
      }

      usernames.clear();
      usernames.addAll(tempList);
    }

    double _getHeight() {
      final int usersCount = usernames.length;
      double height = 70.h;
      height += (usersCount * 40);
      if (notes != null) {
        height += 30;
      }

      if (bedrooms != null || bathrooms != null || sleeps != null) {
        height += 30;
      }
      return height.h;
    }

    return SpacedColumn(
      verticalSpace: 1,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: RectangleWidget(
              onTap: () {
                setState(() {
                  if (openedTile == index) {
                    openedTile = null;
                  } else {
                    openedTile = index;
                  }
                });
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10.w, bottom: 10.h, top: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 6.w,
                        height: 40.h,
                        margin: EdgeInsets.only(right: 10.w),
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(4.r))),
                    Expanded(
                      flex: 5,
                      child: SpacedColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        verticalSpace: 8,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: SizedText(
                                      text: shift, width: 150.w, maxLines: 3)),
                              Expanded(
                                  flex: 2,
                                  child:
                                      SizedText(text: '$startTime - $endTime')),
                            ],
                          ),
                          SpacedColumn(
                            verticalSpace: 4,
                            children: [
                              for (int i = 0; i < usernames.length; i++)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: SizedText(
                                            text: usernames[i],
                                            width: 150.w,
                                            maxLines: 3)),
                                    Expanded(
                                      flex: 2,
                                      child: SizedText(
                                        text: (usernameStartTimes[i] != null
                                                ? "${usernameStartTimes[i].hour}:${usernameStartTimes[i].minute}"
                                                : "") +
                                            (" - " +
                                                (usernameFinishTimes[i] != null
                                                    ? "${usernameFinishTimes[i].hour}:${usernameFinishTimes[i].minute}"
                                                    : "")),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      duration: 300.milliseconds,
                      turns: openedTile != index ? 0.5 : 0,
                      child: FaIcon(FontAwesomeIcons.arrowDown, size: 15.h),
                    ),
                  ],
                ),
              )),
        ),
        AnimatedContainer(
            height:
                openedTile != null && openedTile == index ? _getHeight() : 0,
            duration: 200.milliseconds,
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            width: double.infinity,
            child: RectangleWidget(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                child: SpacedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalSpace: 6,
                  children: [
                    _buildIcText(
                      'status',
                      Constants.dailyProgressStatusMapper[status]
                          .toString()
                          .tr
                          .capitalizeFirst!,
                      icon: FontAwesomeIcons.toggleOn,
                    ),
                    if (bedrooms != null || bathrooms != null || sleeps != null)
                      _buildIcText(
                        'details',
                        "",
                        child: SpacedRow(
                          horizontalSpace: 4,
                          children: [
                            if (bedrooms != null)
                              SpacedRow(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                horizontalSpace: 6,
                                children: [
                                  FaIcon(bedrooms['icon'], size: 10.h),
                                  SizedText(
                                      text:
                                          bedrooms['count'].toString() + ", "),
                                ],
                              ),
                            if (bathrooms != null)
                              SpacedRow(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                horizontalSpace: 6,
                                children: [
                                  FaIcon(bathrooms['icon'], size: 10.h),
                                  SizedText(
                                      text:
                                          bathrooms['count'].toString() + ", "),
                                ],
                              ),
                            if (sleeps != null)
                              SpacedRow(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                horizontalSpace: 6,
                                children: [
                                  FaIcon(sleeps['icon'], size: 10.h),
                                  SizedText(text: sleeps['count'].toString()),
                                ],
                              ),
                          ],
                        ),
                        icon: FontAwesomeIcons.infoCircle,
                      ),
                    if (notes != null)
                      _buildIcText(
                        'notes',
                        notes,
                        icon: FontAwesomeIcons.infoCircle,
                      ),
                    _buildIcText(
                      'payment_rate',
                      paymentRate,
                      icon: FontAwesomeIcons.moneyBill,
                    ),
                    _buildIcText(
                      'timing',
                      '$startTime - $endTime',
                      icon: FontAwesomeIcons.solidClock,
                    ),
                    for (int i = 0; i < usernames.length; i++)
                      _buildIcText(
                        i == 0 ? 'users' : "",
                        (usernames[i]).toString() +
                            "\n" +
                            (usernameStartTimes[i] != null
                                ? "${usernameStartTimes[i].hour}:${usernameStartTimes[i].minute}"
                                : "") +
                            (" - " +
                                (usernameFinishTimes[i] != null
                                    ? "${usernameFinishTimes[i].hour}:${usernameFinishTimes[i].minute}"
                                    : "")),
                        icon: i == 0 ? FontAwesomeIcons.users : null,
                        textColor: widget.currentUsername
                                .contains(usernames[i].toString())
                            ? Colors.green
                            : ThemeColors.black,
                      ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  _buildIcText(String title, String msg,
      {Color textColor = ThemeColors.black,
      IconData? icon,
      Color? iconColor = ThemeColors.mainBlue,
      Widget? child}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SpacedRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            horizontalSpace: 6,
            children: [
              if (icon != null)
                FaIcon(icon,
                    color: iconColor ?? ThemeColors.mainBlue, size: 15.h),
              SizedText(
                  maxLines: 2,
                  width: 130.w,
                  text: title,
                  textStyle:
                      ThemeTextRegular.base.apply(color: ThemeColors.mainBlue)),
            ],
          ),
        ),
        if (child != null)
          Expanded(flex: 2, child: child)
        else
          Expanded(
            flex: 2,
            child: SizedText(
                width: 130.w,
                maxLines: 2,
                text: msg,
                textStyle: ThemeTextRegular.base.copyWith(color: textColor)),
          ),
      ],
    );
  }
}
