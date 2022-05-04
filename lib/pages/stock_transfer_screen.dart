import 'package:mca_new_design/manager/models/model_exporter.dart';
import 'package:mca_new_design/template/base/template.dart';

class StockTransferScreen extends StatefulWidget {
  const StockTransferScreen({Key? key}) : super(key: key);

  static Map<String, Map<String, String>> selectedLocation = {
    'location': {"key": '', 'value': ''}
  };

  @override
  State<StockTransferScreen> createState() => _StockTransferScreenState();
}

class _StockTransferScreenState extends State<StockTransferScreen> {
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
    StockTransferScreen.selectedLocation['location'] = {"key": '', 'value': ''};
    _StockTransferScreenState.sortKeyLetter.value = 'ALL';
    super.dispose();
  }

  void initState() {
    super.initState();
    _StockTransferScreenState.sortKeyLetter.addListener(() {
      String val = _StockTransferScreenState.sortKeyLetter.value.toLowerCase();
      switch (val) {
        case "all":
          //ALL
          locations.clear();
          locations.addAll(locationsBack);
          break;
        case "#":
          //#
          locations.removeWhere((key, value) =>
              int.tryParse(value.toString().substring(0, 1)) == null);
          break;
        default:
          //LETTER
          locations.removeWhere(
              (key, value) => !value.toString().toLowerCase().startsWith(val));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      shimmerLength: 8,
      onInit: () async {
        appStore.isLoading(true);
        StorageModel? res = await appStore.dispatch(GetStorageAction());
        if (res != null) {
          Map locccs = {};
          for (var element in res.storages!) {
            final el = {element.id.toString(): element.name};
            locccs.addAll(el);
          }
          var sortMapByValue = Map.fromEntries(locccs.entries.toList()
            ..sort((e1, e2) => e1.value.compareTo(e2.value)));
          setState(() {
            locations.addAll(sortMapByValue);
            locationsBack.addAll(locations);
          });
        }
        appStore.isLoading(false);
      },
      paddingTop: 10,
      showLeadingMenuBtn: true,
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
            text: 'select_warehouse',
            textStyle: ThemeTextBold.lg.copyWith(color: ThemeColors.mainBlue)),
        ValueListenableBuilder(
            valueListenable: _StockTransferScreenState.sortKeyLetter,
            builder: (_, str, child) => Visibility(
                  visible: str.toString() != 'ALL',
                  child: DefaultButton(
                      onTap: () {
                        reset(true);
                        _StockTransferScreenState.sortKeyLetter.value = 'ALL';
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

  Widget _buildLocationItem(String key, String value) {
    return ListTile(
      onTap: () {
        StockTransferScreen.selectedLocation['location']!['key'] = key;
        StockTransferScreen.selectedLocation['location']!['value'] = value;
        reset(false);
        appStore.to(AppRoutes.RouteToStockTransferItem);
      },
      title: Container(
        color:
            StockTransferScreen.selectedLocation['location']!['value'] == value
                ? ThemeColors.mainBlue.withOpacity(0.2)
                : ThemeColors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        height: 48.h,
        child: SpacedRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          horizontalSpace: 10,
          children: [
            const FaIcon(FontAwesomeIcons.mapMarkerAlt,
                color: ThemeColors.mainBlue),
            SizedText(
                width: 200.w, text: value, textStyle: ThemeTextRegular.base)
          ],
        ),
      ),
    );
  }

  _buildAlphabetSelect() {
    List<String> alphabet = ['#', ...Constants.alphabet];
    return SizedBox(
      width: 40.w,
      child: RectangleWidget(
          child: SpacedColumn(
        verticalSpace: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        children: alphabet
            .map<Widget>((e) => InkWell(
                onTap: () {
                  reset(true);
                  _StockTransferScreenState.sortKeyLetter.value = e;
                },
                child: SizedText(
                    text: e,
                    textStyle: ThemeTextRegular.xs.copyWith(
                        color:
                            _StockTransferScreenState.sortKeyLetter.value == e
                                ? ThemeColors.mainBlue
                                : ThemeColors.black))))
            .toList(),
      )),
    );
  }
}
