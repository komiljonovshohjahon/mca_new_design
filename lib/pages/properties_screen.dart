import 'package:mca_new_design/manager/models/model_exporter.dart';
import 'package:mca_new_design/template/base/template.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({Key? key}) : super(key: key);

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  final TextEditingController searchController = TextEditingController();
  List<PropertyModel> properties = [];
  List<PropertyModel> propertiesTemp = [];
  bool isEmptyRes = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
        shimmerLength: 4,
        showLeadingBack: () {},
        showActionMsg: () {},
        showActionBell: () async {},
        onInit: () async {
          appStore.isLoading(true);
          final res = await appStore.dispatch(GetPropertiesAction());
          properties.addAll(res);
          propertiesTemp.addAll(res);
          searchController.addListener(() {
            if (searchController.text.isEmpty) {
              // On Input field empty do ...
              setState(() {
                properties.clear();
                isEmptyRes = false;
                properties.addAll(propertiesTemp);
              });
            }
          });
          appStore.isLoading(false);
        },
        paddingHorizontal: 0,
        paddingTop: 10,
        child: (state) {
          return SingleChildScrollView(
            child: SpacedColumn(
              verticalSpace: 8,
              children: [
                _buildSearchInput(state),
                _buildHeader(),
                isEmptyRes
                    ? Center(
                        child: SizedText(text: 'empty_list'),
                      )
                    : _buildBody(),
              ],
            ),
          );
        });
  }

  _onSearch(val, AppState state) async {
    if (val.isNotEmpty) {
      //Fetch items list
      List<PropertyModel> items = [];
      items.addAll(state.modelsState.properties);
      items = state.modelsState.properties.where((element) {
        return element.locationName!.toLowerCase().contains(RegExp(val));
      }).toList();
      setState(() {
        if (items.isNotEmpty) {
          isEmptyRes = false;
          properties = items;
        } else {
          // On Search result empty do ....
          isEmptyRes = true;
        }
      });
    }
  }

  Widget _buildSearchInput(AppState state) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 0.8,
      child: DefaultInput(
        hintText: 'search_for_property',
        controller: searchController,
        bgColor: ThemeColors.white,
        width: double.infinity,
        prefixIcon: FontAwesomeIcons.search,
        height: 45.h,
        onChanged: (value) => _onSearch(value.toString().toLowerCase(), state),
      ),
    );
  }

  Widget _buildHeader() {
    return RectangleWidget(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedText(text: 'properties'),
            SizedText(text: 'rooms'),
            SizedText(text: 'storages'),
          ],
        ));
  }

  Widget _buildBody() {
    return RectangleWidget(
      height: 350.h,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          itemBuilder: (BuildContext ctx, int index) => _buildListItem(index),
          itemCount: properties.length),
    );
  }

  Widget _buildListItem(int index) {
    return RectangleWidget(
        child: Padding(
      padding: EdgeInsets.all(10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: _buildLocationAddressShiftClient(properties[index])),
          Expanded(flex: 2, child: _buildBedBathSleepNote(properties[index])),
          Expanded(flex: 2, child: _buildStorageItems(properties[index])),
        ],
      ),
    ));
  }

  Widget _buildLocationAddressShiftClient(PropertyModel propertyModel) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: ThemeColors.gray.withOpacity(0.5), width: 1.w))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (propertyModel.locationName != null)
            SizedText(text: propertyModel.locationName, maxLines: 30),
          if (propertyModel.shiftName != null)
            SizedText(text: propertyModel.shiftName, maxLines: 30),
          if (propertyModel.addressLine1 != null)
            SizedText(text: propertyModel.addressLine1, maxLines: 30),
          if (propertyModel.addressCity != null)
            SizedText(text: propertyModel.addressCity, maxLines: 30),
          if (propertyModel.addressCounty != null)
            SizedText(text: propertyModel.addressCounty, maxLines: 30),
          if (propertyModel.addressCountry != null)
            SizedText(text: propertyModel.addressCountry, maxLines: 30),
          if (propertyModel.addressPostcode != null)
            SizedText(text: propertyModel.addressPostcode, maxLines: 30),
          if (propertyModel.clientName != null)
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: ThemeColors.gray.withOpacity(0.5),
                          width: 1.w))),
              margin: EdgeInsets.only(top: 10.h),
              child:
                  SizedText(text: 'client', textStyle: ThemeTextSemibold.base),
            ),
          SizedText(text: propertyModel.clientName, maxLines: 30),
        ],
      ),
    );
  }

  Widget _buildBedBathSleepNote(PropertyModel propertyModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: ThemeColors.gray.withOpacity(0.5), width: 1.w),
              right: BorderSide(
                  color: ThemeColors.gray.withOpacity(0.5), width: 1.w))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (propertyModel.bedrooms != null)
          SizedText(
              text: 'bedrooms'.tr + ": " + propertyModel.bedrooms.toString()),
        if (propertyModel.bathrooms != null)
          SizedText(
              text: 'bathrooms'.tr + ": " + propertyModel.bathrooms.toString()),
        if (propertyModel.sleeps_min != null &&
            propertyModel.sleeps_max != null)
          SizedText(
              text: 'sleeps'.tr +
                  ": " +
                  propertyModel.sleeps_min.toString() +
                  "-" +
                  propertyModel.sleeps_max.toString()),
        if (propertyModel.sleeps_min != null)
          SizedText(
              text: 'sleeps'.tr + ": " + propertyModel.sleeps_min.toString()),
        if (propertyModel.sleeps_max != null)
          SizedText(
              text:
                  'sleeps_max'.tr + ": " + propertyModel.sleeps_max.toString()),
        if (propertyModel.notes != null)
          SizedText(
              text: 'notes'.tr + ": " + propertyModel.notes.toString(),
              maxLines: 30),
      ]),
    );
  }

  Widget _buildStorageItems(PropertyModel propertyModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: ThemeColors.gray.withOpacity(0.5), width: 1.w))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (propertyModel.storageName != null)
          SizedText(text: propertyModel.storageName, maxLines: 20),
        if (propertyModel.items != null && propertyModel.items!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child:
                    SizedText(text: 'items', textStyle: ThemeTextSemibold.base),
              ),
              Container(
                // margin: EdgeInsets.only(top: 10.h),
                padding: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: ThemeColors.gray.withOpacity(0.5),
                            width: 1.w))),
                child: SpacedColumn(
                  verticalSpace: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: propertyModel.items!.map((item) {
                    return SizedText(
                        text: item.stock.toString() + " x " + item.name!,
                        maxLines: 1,
                        textStyle: ThemeTextRegular.xxs);
                  }).toList(),
                ),
              ),
            ],
          ),
      ]),
    );
  }
}
