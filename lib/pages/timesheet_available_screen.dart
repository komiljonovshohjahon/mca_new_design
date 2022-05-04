import 'package:mca_new_design/manager/models/model_exporter.dart';
import 'package:mca_new_design/template/base/template.dart';

class TimesheetAvailableScreen extends StatelessWidget {
  const TimesheetAvailableScreen({Key? key}) : super(key: key);

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
  final List<String> reqTypeNames = [];
  List<ReqTypeModel> list = [];
  _ReqBody({Key? key, required this.state}) : super(key: key) {
    list.addAll(state.modelsState.reqTypes);
    if (list.isNotEmpty) {
      reqTypeNames.addAll(list.map<String>((e) => e.name ?? "").toList());
    }
  }

  @override
  State<_ReqBody> createState() => _ReqBodyState();
}

class _ReqBodyState extends State<_ReqBody> {
  final TextEditingController startDateContr = TextEditingController();
  final TextEditingController endDateContr = TextEditingController();
  final TextEditingController commentContr = TextEditingController();
  String start_time = "";
  String end_time = "";
  bool fullday = true;
  @override
  void dispose() {
    startDateContr.dispose();
    endDateContr.dispose();
    commentContr.dispose();
    super.dispose();
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
        SizedText(text: 'unav_to_work'),
        SpacedRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedText(text: 'fullday'),
            Switch.adaptive(
                value: fullday,
                onChanged: (fd) => setState(() {
                      fullday = fd;
                    })),
          ],
        )
      ],
    );
  }

  Widget _buildDateWidget() {
    return SpacedColumn(
      verticalSpace: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpacedRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: SizedBox(
                width: 150.w,
                child: DefaultInput(
                    enabled: false,
                    hintText: 'start_date',
                    label: 'start_date',
                    controller: startDateContr),
              ),
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
                child: SizedBox(
                  width: 150.w,
                  child: DefaultInput(
                      enabled: false,
                      label: 'end_date',
                      hintText: 'end_date',
                      controller: endDateContr),
                )),
          ],
        ),
        DefaultInput(
            label: 'comment', hintText: 'comment', controller: commentContr),
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
              if (startDateContr.text.isEmpty && endDateContr.text.isEmpty) {
                appStore.snackbar('start_and_end_dates_must_be_selected');
              } else {
                await appStore.dispatch(GetPostUnavAction(
                  date_from: startDateContr.text,
                  date_to: endDateContr.text,
                  time_from: start_time,
                  time_to: end_time,
                  fullday: fullday,
                  comment: commentContr.text,
                ));
              }
            }),
      ],
    );
  }
}
