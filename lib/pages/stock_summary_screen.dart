import 'package:mca_new_design/template/base/template.dart';

class StockSummaryScreen extends StatelessWidget {
  const StockSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      paddingHorizontal: 0,
      shimmerLength: 8,
      showActionMsg: () {},
      showActionBell: () {},
      onInit: () async {
        appStore.isLoading(true);
        await appStore.dispatch(GetCurrentStockAction());
        appStore.isLoading(false);
      },
      showLeadingMenuBtn: true,
      child: (state) {
        return _IdleBody(state: state);
      },
    );
  }
}

class _IdleBody extends StatelessWidget {
  final AppState state;
  _IdleBody({required this.state});

  @override
  Widget build(BuildContext context) {
    final Map current = state.modelsState.currentStock['current'];
    final Map minimum = state.modelsState.currentStock['minimum'];
    final Map items = state.modelsState.currentStock['items'];
    final Map storages = state.modelsState.currentStock['storages'];
    logger(storages);
    final Map totals = state.modelsState.currentStock['totals'];
    final List itemsIds = items.keys.toList();
    final List minimumIds = minimum.keys.toList();
    final List minimumValues = minimum.values.toList();
    final List storagesIds = storages.keys.toList();
    final List storagesValues = storages.values.toList();
    // storagesValues.removeAt(0);
    // storagesIds.removeAt(0);
    // current.remove(current['6']['63']);
    List<String> _getStorageItem(itemId) {
      List<String> items = [];
      for (var e in storagesIds) {
        items.add(current[itemId][e] ?? "-");
      }
      return items;
    }

    bodyNames() {
      return itemsIds
          .map<List>((e) => [
                items[e] ?? "-",
                totals[e] ?? "-",
                ..._getStorageItem(e),
              ])
          .toList();
    }

    final List<String> _heads = ['items', 'total', ...storagesValues];
    final List<double> _bodyWdth = _heads.map<double>((e) => 70).toList();
    _bodyWdth.replaceRange(0, 2, [110.0, 70.0]);
    //List
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: DefaultDatatable(
              freezedColNumber: 1,
              bodyWidths: _bodyWdth,
              headNames: _heads,
              bodyNames: bodyNames()),
        )
      ],
    );
  }
}
