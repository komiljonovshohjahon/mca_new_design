import 'package:flutter/scheduler.dart';
import 'package:mca_new_design/manager/models/storage_md.dart';
import 'package:mca_new_design/template/base/template.dart';

class StockTransferItemScreen extends StatefulWidget {
  StockTransferItemScreen({Key? key}) : super(key: key) {}

  @override
  State<StockTransferItemScreen> createState() =>
      _StockTransferItemScreenState();
}

class _StockTransferItemScreenState extends State<StockTransferItemScreen> {
  late String locId;
  late String locName;
  final commentContr = TextEditingController();
  final docNumContr = TextEditingController();
  List<TextEditingController> contrs = [];
  Map locs = {};
  String? transferToLocName;
  String? transferToLocId;

  _resetLocs() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    locId = StockTransferScreen.selectedLocation['location']!['key']!;
    locName = StockTransferScreen.selectedLocation['location']!['value']!;
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      Map loccs = {};
      for (var element
          in GETSTATE(context).modelsState.storageModel.storages!) {
        final el = {
          element.id.toString(): {"name": element.name, "items": element.items}
        };
        loccs.addAll(el);
      }
      setState(() {
        locs = loccs;
      });
      if (locs[locId]['items'] != null) {
        contrs = List.generate(
            locs[locId]['items'].length, (index) => TextEditingController());
      }
    });
  }

  @override
  void dispose() {
    for (var element in contrs) {
      element.dispose();
    }
    commentContr.dispose();
    docNumContr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      paddingTop: 10,
      showLeadingMenuBtn: true,
      child: (state) {
        return SingleChildScrollView(
          child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalSpace: 14,
            children: [
              _buildTitle(),
              _buildItemsList(locs),
              _buildTransferTo(state),
              SizedBox(height: 5.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalSpace: 3,
      children: [
        SizedText(
            text: locName,
            maxLines: 2,
            softWrap: true,
            width: 230.w,
            textStyle: ThemeTextBold.lg.copyWith(color: ThemeColors.mainBlue)),
        SizedText(text: 'please_set_items', textStyle: ThemeTextRegular.base),
      ],
    );
  }

  Widget _buildItemsList(Map locs) {
    // final s = locs[locId]['items'];
    // print(s.map((e) => e.name).toList());
    if (locs[locId] != null) {
      if (locs[locId]['items'] != null) {
        final items = locs[locId]['items'];
        return RectangleWidget(
          // height: 382,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 11.h),
            child: SpacedColumn(
              // verticalSpace: 4,
              children: [
                for (int i = 0; i < contrs.length; i++)
                  Column(
                    children: [
                      if (i == 0)
                        SpacedRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedText(
                                width: 140.w,
                                text: 'items',
                                textStyle: ThemeTextRegular.base
                                    .apply(color: ThemeColors.c9E9FA5)),
                            SizedText(
                                width: 80.w,
                                text: 'in_stock',
                                textStyle: ThemeTextRegular.base
                                    .apply(color: ThemeColors.c9E9FA5)),
                            SizedText(
                                text: 'amount',
                                textStyle: ThemeTextRegular.base
                                    .apply(color: ThemeColors.c9E9FA5)),
                          ],
                        ),
                      if (i == 0) const Divider(),
                      if (items[i].current != null)
                        _itemBuilder(items[i], contrs[i]),
                      if (items[i].current != null) const Divider(),
                    ],
                  ),
              ],
            ),
          ),
          // child: Padding(
          //   padding: EdgeInsets.only(right: 2.w),
          //   child: RawScrollbar(
          //     thickness: 4.w,
          //     isAlwaysShown: true,
          //     radius: Radius.circular(4.r),
          //     thumbColor: ThemeColors.mainBlue.withOpacity(0.4),
          //     child: ListView.separated(
          //         shrinkWrap: true,
          //         separatorBuilder: (context, index) => const Divider(),
          //         padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 11.h),
          //         itemBuilder: (context, index) {
          //           if (index == 0) {
          //             return SpacedRow(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 SizedText(
          //                     width: 140.w,
          //                     text: 'items',
          //                     textStyle: ThemeTextRegular.base
          //                         .apply(color: ThemeColors.c9E9FA5)),
          //                 SizedText(
          //                     width: 80.w,
          //                     text: 'in_stock',
          //                     textStyle: ThemeTextRegular.base
          //                         .apply(color: ThemeColors.c9E9FA5)),
          //                 SizedText(
          //                     text: 'amount',
          //                     textStyle: ThemeTextRegular.base
          //                         .apply(color: ThemeColors.c9E9FA5)),
          //               ],
          //             );
          //           }
          //           return _itemBuilder(items[index], contrs[index]);
          //         },
          //         itemCount: contrs.length),
          //   ),
          // ),
        );
      }
      return const SizedBox();
    }
    return Container();
  }

  Widget _itemBuilder(Items items, TextEditingController contr) {
    return SpacedRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedText(width: 140.w, text: items.name),
        SizedText(
            width: 80.w,
            textAlign: TextAlign.center,
            textStyle: ThemeTextRegular.sm.apply(
                color: int.parse(items.current ?? "0") < 0
                    ? ThemeColors.mainRed
                    : ThemeColors.black),
            text: items.current),
        DefaultInput(
            onSubmit: () {
              if (double.parse(contr.text) > double.parse(items.current!)) {
                alert('amount_cannot_be_larger_than'.tr +
                    " " +
                    items.current.toString());
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            textInputType: TextInputType.number,
            width: 62.w,
            height: 32.h,
            hintText: "0",
            controller: contr),
      ],
    );
  }

  Widget _buildTransferTo(AppState state) {
    final warehouses = state.modelsState.storageModel.storages!
        .map<String>((e) => e.name!)
        .toList()
      ..sort((e1, e2) => e1.compareTo(e2));

    return RectangleWidget(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 11.h),
      child: SpacedColumn(
        verticalSpace: 10,
        children: [
          SizedText(text: 'transfer_to', textStyle: ThemeTextRegular.base),
          DropdownWidget(
            dpValWidth: 220.w,
            items: warehouses,
            onChanged: (name) {
              setState(() {
                transferToLocName = name;
                transferToLocId = state.modelsState.storageModel.storages!
                    .firstWhere((element) => element.name!.contains(name))
                    .id
                    .toString();
              });
            },
            value: transferToLocName,
            leftIcon: FontAwesomeIcons.warehouse,
          ),
          DefaultInput(
              textInputType: TextInputType.number,
              controller: docNumContr,
              hintText: 'doc_num',
              prefixIcon: FontAwesomeIcons.solidFileAlt),
          DefaultInput(
              controller: commentContr,
              hintText: 'comment',
              prefixIcon: FontAwesomeIcons.solidMessage),
          DefaultButton(
              msg: 'transfer',
              onTap: () async {
                if (transferToLocId != null) {
                  showLoadingDialog();
                  final storageid = int.parse(locId);
                  final targetid = int.parse(transferToLocId!);
                  Map<String, String> items = {};
                  final docno = docNumContr.text;
                  final comment = commentContr.text;
                  for (var element in contrs) {
                    if (element.text.isNotEmpty) {
                      final indexOfContr = contrs.indexOf(element);
                      final Items item = locs[locId]["items"][indexOfContr];
                      items.addAll({"${item.id}": contrs[indexOfContr].text});
                    }
                  }
                  //post
                  await appStore.dispatch(GetPostStoragesAction(
                      items: items,
                      storageid: storageid,
                      targetid: targetid,
                      comment: comment,
                      docno: docno));
                  await appStore.dispatch(GetStorageAction());
                  closeLoading();
                  appStore.to('up');
                  appStore.to(AppRoutes.RouteToStockTransferItem);
                } else {
                  alert('select_warehouse', 'warning');
                }
              },
              width: 304.w,
              bgColor: ThemeColors.mainBlue),
        ],
      ),
    ));
  }
}
