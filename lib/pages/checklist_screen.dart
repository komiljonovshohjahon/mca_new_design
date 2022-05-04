import 'dart:convert';
import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mca_new_design/manager/models/model_exporter.dart';
import 'package:mca_new_design/template/base/template.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
        showLeadingMenuBtn: true,
        shimmerLength: 8,
        showActionMsg: () {},
        onInit: () async {
          appStore.isLoading(true);
          await appStore.dispatch(GetChecklistAction());
          appStore.isLoading(false);
        },
        showActionBell: () async {},
        paddingTop: 20,
        paddingHorizontal: 0,
        child: (state) => SpacedColumn(
              children: [
                _ChecklistHeadWidget(state: state),
                Divider(color: ThemeColors.mainBlue.withOpacity(0.5)),
                _ChecklistBodyWidget(state: state),
              ],
            ));
  }
}

class _ChecklistHeadWidget extends StatelessWidget {
  final AppState state;
  const _ChecklistHeadWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checklistmodel = state.modelsState.checklistModel.checklist;
    final String? shiftName = checklistmodel.shiftName;
    final String? shiftDate = checklistmodel.date;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalSpace: 10,
          children: [
            _buildMainLabel('shift_and_date'),
            _buildIconAndText(FontAwesomeIcons.userClock, shiftName ?? ""),
            _buildIconAndText(
                FontAwesomeIcons.solidCalendarDays, shiftDate ?? ""),
          ]),
    );
  }

  _buildIconAndText(IconData icon, String msg) {
    return SpacedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        horizontalSpace: 10,
        children: [
          FaIcon(icon, size: 14.w, color: ThemeColors.mainBlue),
          SizedText(text: msg, textStyle: ThemeTextRegular.base),
        ]);
  }
}

class _ChecklistBodyWidget extends StatefulWidget {
  final AppState state;
  List<Map<Map, List<Map>>> jobMaps = List.empty(growable: true);
  _ChecklistBodyWidget({required this.state}) {
    final placesToClean = state.modelsState.checklistModel.rooms;
    for (var placeToClean in placesToClean) {
      final room = placeToClean['room'];
      room.putIfAbsent('comment', () => "");
      room.putIfAbsent(
          'images', () => {"old": placeToClean['photos'], "new": []});
      final List<Map> itemsList = [];
      room.putIfAbsent(
          'damages',
          () => Damages(
              damages: placeToClean['damages'],
              damagesBy: placeToClean['damagesBy'],
              damagesOn: placeToClean['damagesOn']));
      for (Map item in placeToClean['items']) {
        item.putIfAbsent(
            'defaultChecked', () => item['checkedBy'].runtimeType == int);
        item.putIfAbsent('isChecked', () => false);
        itemsList.add(item);
      }
      jobMaps.add({room: itemsList});
    }
  }

  @override
  State<_ChecklistBodyWidget> createState() => _ChecklistBodyWidgetState();
}

class _ChecklistBodyWidgetState extends State<_ChecklistBodyWidget> {
  bool allChecked = false;
  List<Map<Map, List<Map>>> jobMaps = List.empty(growable: true);
  bool isEditedAny = false;
  bool allItemsChecked = true;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      bool stopLoop = false;
      setState(() {
        jobMaps.addAll(widget.jobMaps);
        for (var element in widget.jobMaps) {
          final item = element.values.first;
          for (var itemElement in item) {
            if (!stopLoop) {
              if (!itemElement['defaultChecked']) {
                allItemsChecked = false;
                stopLoop = true;
              }
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        child: SpacedColumn(
          verticalSpace: 24,
          children: [
            if (!allItemsChecked)
              _buildCheckSwitchWidget(allChecked, false, "select_all",
                  (bool? switched) {
                if (switched != null) {
                  setState(() {
                    for (var element in jobMaps) {
                      if (switched) {
                        final item = element.values.first;
                        for (var itemElement in item) {
                          if (itemElement['defaultChecked'] == false) {
                            itemElement['isChecked'] = switched;
                          }
                        }
                      } else {
                        for (var element in jobMaps) {
                          final item = element.values.first;
                          for (var itemElement in item) {
                            if (itemElement['defaultChecked'] == false) {
                              itemElement['isChecked'] = false;
                            }
                          }
                        }
                      }
                      if (!isEditedAny) {
                        isEditedAny = true;
                      }
                      allChecked = switched;
                    }
                  });
                }
              }, scaleCheckbox: 1.3),
            ..._buildPlace(),
            DefaultButton(
                msg: "save",
                bgColor: ThemeColors.mainBlue,
                width: Get.width,
                onTap: () async {
                  final int? checklistId =
                      widget.state.modelsState.checklistModel.checklist.id;
                  final List<int?> checked = [];
                  final Map<String, String> comments = {};
                  final Map<String, String> images = {};

                  for (var element in jobMaps) {
                    for (var e in element.values) {
                      for (var i in e) {
                        if (i['isChecked']) {
                          checked.add(i['id']);
                        }
                      }
                    }
                    for (var e in element.keys) {
                      if (e['comment'].toString().isNotEmpty) {
                        comments[e['name']] = e['comment'];
                      }
                    }
                    for (var e in element.keys) {
                      for (int i = 0; i < e['images']['new'].length; i++) {
                        images[e['name'] + "|" + i.toString()] =
                            e['images']['new'][i]['photo'];
                      }
                    }
                  }
                  // if (isEditedAny) {
                  await appStore.dispatch(GetPostChecklistAction(
                      checked: checked,
                      checklistId: checklistId!,
                      comments: comments,
                      images: images));
                  // } else {
                  //   appStore.snackbar('edit_first');
                  // }
                }),
          ],
          //
        ),
      ),
    );
  }

  List<Widget> _buildPlace() {
    List<Widget> list = [];
    for (var element in jobMaps) {
      final room = element.keys.first;
      final item = element.values.first;
      final Damages damages = room['damages'];
      final List? photos = [];
      if (room['images']['old'] != null) {
        photos!.addAll(room['images']['old']);
      }
      photos!.addAll(room['images']['new']);
      list.add(SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalSpace: 10,
          children: [
            _buildMainLabel(room['name']),
            _buildCheckSwitchWidget(
                !item.any((element) => !element['isChecked']),
                !item.any((element) => !element['defaultChecked']),
                'select_all', (bool? switched) {
              if (switched != null) {
                setState(() {
                  for (var i in item) {
                    i['isChecked'] = switched;
                  }
                });
                // if (switched) {
                //   final item = element.values.first;
                //   for (var itemElement in item) {
                //     if (itemElement['defaultChecked'] == false) {
                //       itemElement['isChecked'] = switched;
                //     }
                //   }
                // }
              }
            }, scaleCheckbox: 1.2),
            ...item
                .map((e) => _buildCheckSwitchWidget(
                      e['isChecked'],
                      e['defaultChecked'],
                      e['name'].toString(),
                      (bool? switched) {
                        if (switched != null) {
                          setState(() {
                            final before = e['isChecked'];
                            e['isChecked'] = switched;
                            if (!isEditedAny) {
                              before == switched
                                  ? isEditedAny = true
                                  : isEditedAny = false;
                            }
                          });
                        }
                      },
                    ))
                .toList(),
            if (damages.damages != null && damages.damages!.isNotEmpty)
              SizedText(
                  text: ">>>>>\t" + damages.damages!,
                  overflow: TextOverflow.visible,
                  maxLines: 100,
                  textStyle: ThemeTextRegular.sm),
            // if (damages.damagesBy != null)
            DefaultInput(
              onChanged: (value) {
                room['comment'] = value;
                if (!isEditedAny) {
                  isEditedAny = true;
                }
                if (value == null || value.isEmpty) {
                  isEditedAny = false;
                }
              },
              label: 'add'.tr + ' "${room['name']}" ' + "comment".tr,
            ),
            if (photos.isNotEmpty)
              Wrap(
                  spacing: 4.w,
                  runSpacing: 4.w,
                  children: photos.reversed
                      .map<Widget>((e) => ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Image(
                                width: 100.w,
                                height: 100.w,
                                image: MemoryImage(fromBase64(e['photo']))),
                          ))
                      .toList()
                    ..add(InkWell(
                        onTap: () => _pickImage(room),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: Container(
                              width: 100.w,
                              height: 100.w,
                              color: ThemeColors.grayish,
                              alignment: Alignment.center,
                              child: const FaIcon(FontAwesomeIcons.camera)),
                        ))))
            else if (photos.isEmpty && damages.damagesBy != null)
              InkWell(
                  onTap: () => _pickImage(room),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Container(
                        width: 100.w,
                        height: 100.w,
                        color: ThemeColors.grayish,
                        alignment: Alignment.center,
                        child: const FaIcon(FontAwesomeIcons.camera)),
                  ))
          ]));
    }
    return list;
  }

  _buildCheckSwitchWidget(bool isActive, bool isDefaultChecked, String msg,
      ValueChanged<bool?> onChanged,
      {double scaleCheckbox = 1.0}) {
    return SpacedRow(
      horizontalSpace: 8,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: scaleCheckbox,
          child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: ThemeColors.mainBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.r)),
              value: isActive,
              side: BorderSide(width: 1.5.w, color: ThemeColors.lightGray),
              onChanged: isDefaultChecked ? null : onChanged),
        ),
        SizedText(
            text: msg,
            maxLines: 2,
            softWrap: true,
            width: 250.w,
            overflow: TextOverflow.ellipsis,
            textStyle: ThemeTextRegular.sm.apply(
                color: isDefaultChecked
                    ? ThemeColors.lightGray
                    : ThemeColors.black))
      ],
    );
  }

  _pickImage(Map room) async {
    PickedFile? pickImage = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 800,
        maxWidth: 600);
    if (pickImage != null) {
      File image = File(pickImage.path);
      final value = base64Encode(image.readAsBytesSync());
      setState(() {
        room['images']['new'] = room['images']['new']..add({"photo": value});
      });
    } else {
      // Canceled
    }
  }
}

_buildMainLabel(dynamic msg) {
  return SizedText(
      text: msg,
      textStyle: ThemeTextBold.lg.copyWith(color: ThemeColors.mainBlue));
}
