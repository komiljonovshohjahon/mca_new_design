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

class _IdleBody extends StatefulWidget {
  final AppState state;
  _IdleBody({required this.state});

  @override
  State<_IdleBody> createState() => _IdleBodyState();
}

class _IdleBodyState extends State<_IdleBody> {
  final TextEditingController searchController = TextEditingController();
  final List<String> visibleName = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map current = widget.state.modelsState.currentStock['current'];
    final Map minimum = widget.state.modelsState.currentStock['minimum'];
    final Map items = widget.state.modelsState.currentStock['items'];
    final Map storages = widget.state.modelsState.currentStock['storages'];
    logger(storages);
    final Map totals = widget.state.modelsState.currentStock['totals'];
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
    final List<double> _bodyWdth = _heads.map<double>((e) => 80).toList();
    _bodyWdth.replaceRange(0, 2, [110.0, 70.0]);
    //List
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSearchInput(),
        Flexible(
          child: DefaultDatatable(
              freezedColNumber: 1,
              bodyWidths: _bodyWdth,
              visibleNames: visibleName,
              headNames: _heads,
              bodyNames: bodyNames()),
        )
      ],
    );
  }

  Widget _buildSearchInput() {
    return PhysicalModel(
      color: Colors.white,
      elevation: 0.8,
      child: DefaultInput(
        hintText: 'filter_warehouse',
        controller: searchController,
        bgColor: ThemeColors.white,
        width: double.infinity,
        prefixIcon: FontAwesomeIcons.search,
        height: 45.h,
        onChanged: (val) {
          if (val.isEmpty) {
            setState(() {
              visibleName.clear();
            });
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        onSubmit: () {
          if (searchController.text.isNotEmpty) {
            print(searchController.text);
            //Fetch items list
            setState(() {
              visibleName.clear();
              visibleName.add(searchController.text);
            });
          } else {
            setState(() {
              visibleName.clear();
            });
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
      ),
    );
  }
}
