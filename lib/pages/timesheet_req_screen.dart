import 'package:mca_new_design/manager/models/model_exporter.dart';
import 'package:mca_new_design/template/base/template.dart';

class TimesheetReqScreen extends StatelessWidget {
  const TimesheetReqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
        paddingTop: 20,
        shimmerLength: 4,
        showLeadingBack: () {},
        onInit: () async {
          final reqTypes = GETSTATE(context).modelsState.reqTypes;
          if (reqTypes.isEmpty) {
            appStore.isLoading(true);
            await appStore.dispatch(GetReqTypesAction());
            appStore.isLoading(false);
          }
        },
        child: (state) => _ReqBody(state: state));
  }
}

class _ReqBody extends StatefulWidget {
  AppState state;
  String holidayTypeComment = "";
  String selectedHolType = "";
  final List<String> reqTypeNames = [];
  List<ReqTypeModel> list = [];
  _ReqBody({Key? key, required this.state}) : super(key: key) {
    list.addAll(state.modelsState.reqTypes);
    if (list.isNotEmpty) {
      holidayTypeComment = list.first.comment ?? "";
      selectedHolType = list.first.name ?? "";
      reqTypeNames.addAll(list.map<String>((e) => e.name ?? "").toList());
    }
  }

  @override
  State<_ReqBody> createState() => _ReqBodyState();
}

class _ReqBodyState extends State<_ReqBody> {
  dynamic reqType;
  final TextEditingController startDateContr = TextEditingController();
  final TextEditingController endDateContr = TextEditingController();
  final TextEditingController commentContr = TextEditingController();
  final TextEditingController startTimeContr = TextEditingController();
  final TextEditingController endTimeContr = TextEditingController();
  //isTimeoff:
  // startDate - startTime - endTime
  // isLate:
  // startDate - startTime
  // isLeaveEarly:
  // startDate - endTime
  // isOvertime:
  // startDate - startTime - endTime
  // isDefault:
  // startDate - endDate
  bool isDefault = true;
  bool isTimeoff = false;
  bool isLate = false;
  bool isLeaveEarly = false;
  bool isOvertime = false;
  int type_id = 1;
  String holidayTypeComment = "";
  @override
  void dispose() {
    startDateContr.dispose();
    endDateContr.dispose();
    commentContr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      holidayTypeComment = widget.holidayTypeComment;
      reqType = widget.selectedHolType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SpacedColumn(
        verticalSpace: 20,
        children: [
          _buildTypeWidget(),
          _buildDateWidget(),
          _buildBtnsWidget(),
        ],
      ),
    );
  }

  Widget _buildTypeWidget() {
    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalSpace: 4,
      children: [
        SizedText(text: 'new_req'),
        DropdownWidget(
            hintText: 'holiday',
            onChanged: (value) {
              final String _name = value;
              String _comment = "";
              int _type_id = 1;
              for (var element in widget.list) {
                if (element.name == _name) {
                  _comment = element.comment ?? "";
                  _type_id = element.typeId!;
                }
              }
              isTimeoff = false;
              isLate = false;
              isLeaveEarly = false;
              isOvertime = false;
              isDefault = false;
              startDateContr.text = "";
              endDateContr.text = "";
              startTimeContr.text = "";
              endTimeContr.text = "";

              setState(() {
                reqType = _name;
                holidayTypeComment = _comment;
                type_id = _type_id;
                if (type_id == 4) {
                  isTimeoff = true;
                  isDefault = false;
                }
                if (type_id == 7) {
                  isLate = true;
                  isDefault = false;
                } else if (type_id == 8) {
                  isLeaveEarly = true;
                  isDefault = false;
                } else if (type_id == 9) {
                  isOvertime = true;
                  isDefault = false;
                }
                if (type_id == 1 || type_id == 2 || type_id == 3) {
                  isDefault = true;
                }
              });
            },
            value: reqType,
            items: widget.reqTypeNames),
        SizedText(text: holidayTypeComment),
      ],
    );
  }

  Widget _buildDateWidget() {
    return SpacedColumn(
      verticalSpace: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now().add(1.days),
                firstDate: DateTime.now().add(1.days),
                lastDate: DateTime(2030));

            if (picked != null) {
              setState(() {
                startDateContr.text = getDateFormat(picked);
              });
            }
          },
          child: DefaultInput(
              enabled: false,
              hintText: 'start_date',
              label: 'start_date',
              controller: startDateContr),
        ),
        if (isDefault)
          GestureDetector(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(2.days),
                    firstDate: DateTime.now().add(1.days),
                    lastDate: DateTime(2030));

                if (picked != null) {
                  setState(() {
                    endDateContr.text = getDateFormat(picked);
                  });
                }
              },
              child: DefaultInput(
                  enabled: false,
                  label: 'end_date',
                  hintText: 'end_date',
                  controller: endDateContr)),
        if (isTimeoff || isLate || isOvertime)
          GestureDetector(
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 00, minute: 00),
                );

                if (picked != null) {
                  logger('picked: ${picked.toString()}');
                  setState(() {
                    startTimeContr.text = getTimeFormat(picked);
                  });
                }
              },
              child: DefaultInput(
                  enabled: false,
                  label: 'start_time',
                  hintText: 'start_time',
                  controller: startTimeContr)),
        if (isTimeoff || isOvertime || isLeaveEarly)
          GestureDetector(
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 00, minute: 00),
                );

                if (picked != null) {
                  logger('picked: ${picked.toString()}');
                  setState(() {
                    endTimeContr.text = getTimeFormat(picked);
                  });
                }
              },
              child: DefaultInput(
                  enabled: false,
                  label: 'end_time',
                  hintText: 'end_time',
                  controller: endTimeContr)),
        DefaultInput(
            label: 'comment', hintText: 'comment', controller: commentContr)
      ],
    );
  }

  Widget _buildBtnsWidget() {
    return SpacedRow(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DefaultButton(
            width: 120.w,
            height: 40.h,
            msg: 'cancel',
            bgColor: ThemeColors.mainRed,
            onTap: () {
              appStore.pop();
            }),
        DefaultButton(
            width: 120.w,
            height: 40.h,
            msg: 'submit',
            bgColor: ThemeColors.mainBlue,
            onTap: () async {
              if (startDateContr.text.isEmpty) {
                appStore.snackbar('start_date_must_be_selected');
              } else {
                if (isTimeoff || isLate || isOvertime) {
                  if (startTimeContr.text.isEmpty) {
                    appStore.snackbar('start_time_must_be_selected');
                    return;
                  }
                }
                if (isTimeoff || isLeaveEarly || isOvertime) {
                  if (endTimeContr.text.isEmpty) {
                    appStore.snackbar('end_time_must_be_selected');
                    return;
                  }
                }

                await appStore.dispatch(GetPostHolidayAction(
                  type_id: type_id,
                  end_date: endDateContr.text,
                  start_date: startDateContr.text,
                  end_time: endTimeContr.text,
                  start_time: startTimeContr.text,
                  comment: commentContr.text,
                ));
              }
            }),
      ],
    );
  }
}
