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
  int type_id = 1;
  String holidayTypeComment = "";
  String start_time = "";
  String end_time = "";
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

              setState(() {
                reqType = _name;
                holidayTypeComment = _comment;
                type_id = _type_id;
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
                start_time = formatTime(picked);
              });
            }
          },
          child: DefaultInput(
              enabled: false,
              hintText: 'start_date',
              label: 'start_date',
              controller: startDateContr),
        ),
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
                  end_time = formatTime(picked);
                });
              }
            },
            child: DefaultInput(
                enabled: false,
                label: 'end_date',
                hintText: 'end_date',
                controller: endDateContr)),
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
                await appStore.dispatch(GetPostHolidayAction(
                  type_id: type_id,
                  end_date: endDateContr.text,
                  start_date: startDateContr.text,
                  end_time: end_time,
                  start_time: start_time,
                  comment: commentContr.text,
                ));
              }
            }),
      ],
    );
  }
}
