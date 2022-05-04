import 'package:mca_new_design/template/base/template.dart';

class AdministrationUserScreen extends StatefulWidget {
  const AdministrationUserScreen({Key? key}) : super(key: key);

  @override
  State<AdministrationUserScreen> createState() =>
      _AdministrationUserScreenState();
}

class _AdministrationUserScreenState extends State<AdministrationUserScreen> {
  Map locations = {};
  Map locationsBack = {};

  static ValueNotifier<String> sortKeyLetter = ValueNotifier<String>('ALL');

  _resetLocs(bool withLoc) {
    setState(() {
      if (withLoc) {
        locations.addAll(locationsBack);
      }
    });
  }

  @override
  void dispose() {
    AdministrationLocationScreen.selectedLocation['user'] = {
      "key": '',
      'value': ''
    };
    _AdministrationUserScreenState.sortKeyLetter.value = 'ALL';
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _AdministrationUserScreenState.sortKeyLetter.addListener(() {
      setState(() {
        String val =
            _AdministrationUserScreenState.sortKeyLetter.value.toLowerCase();
        switch (val.contains('all')) {
          case true:
            //ALL
            locations.clear();
            locations.addAll(locationsBack);
            break;
          // case "#":
          //   //#
          //   locations.removeWhere((key, value) =>
          //       int.tryParse(value['firstname'].toString().substring(0, 1)) == null);
          //   break;
          default:
            //LETTER
            locations.removeWhere((key, value) =>
                !value['firstName'].toString().toLowerCase().startsWith(val));
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      shimmerLength: 10,
      onInit: () async {
        Map? res = GETSTATE(context).modelsState.mobileAdmin;
        setState(() {
          locations.addAll(res['users']);
          locationsBack.addAll(res['users']);
        });
      },
      showLeadingMenuBtn: true,
      showActionBell: () {},
      showActionMsg: () {},
      paddingTop: 10,
      child: (state) {
        return _IdleBody(state: state, locations: locations, reset: _resetLocs);
      },
    );
  }
}

class _IdleBody extends StatelessWidget {
  final AppState state;
  final Map locations;
  final Function(bool) reset;
  _IdleBody(
      {required this.state, required this.locations, required this.reset});
  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalSpace: 4,
      children: [
        _buildTitle(),
        Flexible(
          child: SpacedRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItemList(locations),
              _buildAlphabetSelect(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTitle() {
    return SpacedRow(
      horizontalSpace: 10,
      children: [
        SizedText(
            text: 'select_user',
            textStyle: ThemeTextBold.lg.copyWith(color: ThemeColors.mainBlue)),
        ValueListenableBuilder(
            valueListenable: _AdministrationUserScreenState.sortKeyLetter,
            builder: (_, str, child) => Visibility(
                  visible: str.toString() != 'ALL',
                  child: DefaultButton(
                      onTap: () {
                        reset(true);
                        _AdministrationUserScreenState.sortKeyLetter.value =
                            'ALL';
                      },
                      isDisabled: true,
                      width: 20.w,
                      height: 10.h,
                      msg: 'all'),
                )),
      ],
    );
  }

  Widget _buildItemList(Map locs) {
    final ids = locs.keys.toList();
    final vals = locs.values.toList();

    return SizedBox(
      width: 280.w,
      child: RectangleWidget(
        child: ids.isEmpty
            ? SizedText(
                textAlign: TextAlign.center,
                width: 200.w,
                text: 'empty_list',
                textStyle: ThemeTextRegular.base)
            : Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: RawScrollbar(
                  thickness: 4.w,
                  radius: Radius.circular(4.r),
                  thumbColor: ThemeColors.mainBlue.withOpacity(0.4),
                  child: ListView.builder(
                    itemCount: locs.length,
                    itemBuilder: (context, index) {
                      return _buildLocationItem(ids[index], vals[index]);
                    },
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLocationItem(String key, Map value) {
    final fullname = '${value['firstName']} ${value['lastName']}';
    return ListTile(
      onTap: () {
        AdministrationLocationScreen.selectedLocation['user']!['key'] = key;
        AdministrationLocationScreen.selectedLocation['user']!['value'] =
            fullname;
        reset(false);
        appStore.to(AppRoutes.RouteToAdministrationAvailableShifts);
      },
      title: Container(
        color:
            AdministrationLocationScreen.selectedLocation['user']!['value'] ==
                    fullname
                ? ThemeColors.mainBlue.withOpacity(0.2)
                : ThemeColors.transparent,
        // padding: EdgeInsets.symmetric(horizontal: 10.w),
        height: 48.h,
        child: SpacedRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          horizontalSpace: 10,
          children: [
            const FaIcon(FontAwesomeIcons.userAlt, color: ThemeColors.mainBlue),
            SizedText(
                width: 200.w, text: fullname, textStyle: ThemeTextRegular.base)
          ],
        ),
      ),
    );
  }

  _buildAlphabetSelect() {
    List<String> alphabet = [...Constants.alphabet];
    return SizedBox(
      width: 40.w,
      child: RectangleWidget(
          // height: 30,
          child: SpacedColumn(
        verticalSpace: 6,
        mainAxisAlignment: MainAxisAlignment.center,
        children: alphabet
            .map<Widget>((e) => InkWell(
                onTap: () {
                  reset(true);
                  _AdministrationUserScreenState.sortKeyLetter.value = e;
                },
                child: SizedText(
                    text: e,
                    textStyle: ThemeTextRegular.xs.copyWith(
                        color: _AdministrationUserScreenState
                                    .sortKeyLetter.value ==
                                e
                            ? ThemeColors.mainBlue
                            : ThemeColors.black))))
            .toList(),
      )),
    );
  }
}
