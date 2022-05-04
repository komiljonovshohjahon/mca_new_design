import 'package:mca_new_design/template/base/template.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropdownWidget extends StatefulWidget {
  final ValueChanged? onChanged;
  final dynamic value;
  final List items;
  List? completedList;
  List? inactiveList;
  final IconData? leftIcon;
  final String? hintText;
  bool isValueNull = false;
  final double? dpValWidth;
  DropdownWidget(
      {required this.items,
      this.onChanged,
      this.dpValWidth,
      this.value,
      this.completedList,
      this.inactiveList,
      this.leftIcon,
      this.hintText}) {
    if (value == null) isValueNull = true;
    completedList ??= [];
    inactiveList ??= [];
  }

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  bool showUnderline = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      // buttonPadding: EdgeInsets.symmetric(horizontal: 15.w),
      dropdownPadding: EdgeInsets.zero,
      itemPadding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      iconSize: 0,
      underline: showUnderline
          ? Container(height: 2.h, color: ThemeColors.mainBlue)
          : Container(),
      onChanged: widget.onChanged,
      isExpanded: true,
      selectedItemHighlightColor: ThemeColors.mainBlue.withOpacity(0.1),
      onMenuStateChange: (bool changed) {
        setState(() {
          showUnderline = changed;
        });
      },
      style: ThemeTextRegular.base1.copyWith(color: ThemeColors.black),
      dropdownDecoration: BoxDecoration(
        // color: _getBgColor(),
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: [
          BoxShadow(
              color: ThemeColors.black.withOpacity(0.2),
              offset: const Offset(0, 1),
              blurRadius: 4)
        ],
      ),
      value: widget.value,
      customButton: Container(
        height: 56.h,
        padding: EdgeInsets.only(left: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: ThemeColors.black.withOpacity(0.07),
        ),
        // child: (!widget.isValueNull
        //     ? SizedText(text: widget.value.toString())
        //     : Container()),
        child: SpacedRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          horizontalSpace: 15,
          children: [
            if (widget.isValueNull)
              ..._buildHint()
            else
              ..._buildSelectedItem(context)
          ],
        ),
      ),
      // itemHeight: 56.h,
      items: _getItems(),
    );
  }

  Color? _getBgColor(String name) {
    final List completed = widget.completedList!;
    final List inactive = widget.inactiveList!;
    if (completed.any((element) => element == name)) {
      return ThemeColors.mainGreen;
    }
    if (inactive.any((element) => element == name)) {
      return ThemeColors.mainRed;
    }
  }

  Color? _getTextColor(String name) {
    final List completed = widget.completedList!;
    final List inactive = widget.inactiveList!;
    if (completed.any((element) => element == name) ||
        inactive.any((element) => element == name)) {
      return ThemeColors.white;
    }
  }

  List<Widget> _buildHint() {
    return [
      if (widget.leftIcon != null)
        FaIcon(widget.leftIcon!,
            color: showUnderline ? ThemeColors.mainBlue : ThemeColors.fillGray),
      if (widget.isValueNull)
        SizedText(
            width: widget.dpValWidth,
            text: widget.hintText?.tr ?? 'select_value'.tr,
            textStyle: ThemeTextRegular.base1
                .copyWith(color: ThemeColors.black.withOpacity(0.31))),
    ];
  }

  List<Widget> _buildSelectedItem(BuildContext ctx) {
    return [
      if (widget.leftIcon != null)
        FaIcon(widget.leftIcon!,
            color: showUnderline ? ThemeColors.mainBlue : ThemeColors.fillGray),
      if (!widget.isValueNull)
        SizedText(width: widget.dpValWidth, text: widget.value.toString()),
    ];
  }

  List<DropdownMenuItem<String>> _getItems() {
    List listValues = widget.items;
    final List completed = widget.completedList!;
    final List inactive = widget.inactiveList!;
    List<DropdownMenuItem<String>> _menuItems = [];
    for (int i = 0; i < listValues.length; i++) {
      _menuItems.add(
        DropdownMenuItem<String>(
          value: listValues[i].toString(),
          child: Container(
            decoration: BoxDecoration(
                color: _getBgColor(listValues[i]),
                border: Border(
                    bottom: BorderSide(
                        width: 1.w,
                        color: listValues.length - 1 == i
                            ? ThemeColors.transparent
                            : ThemeColors.grayish.withOpacity(0.5)))),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            width: double.infinity,
            height: double.infinity,
            child: SizedText(
              text: listValues[i].toString(),
              textStyle: ThemeTextRegular.base1
                  .copyWith(color: _getTextColor(listValues[i])),
            ),
          ),
        ),
      );
    }

    return _menuItems;
  }
}
