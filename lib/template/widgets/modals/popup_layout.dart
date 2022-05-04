import 'package:mca_new_design/template/base/template.dart';

class PopupLayout extends StatelessWidget {
  List<Widget> children;
  Widget? title;
  double? horizontalPadding;
  double borderRadius;
  double paddingTop;
  double paddingBottom;
  AlignmentGeometry? alignment;
  PopupLayout(
      {required this.children,
      this.title,
      this.alignment,
      this.borderRadius = 0,
      this.paddingTop = 32,
      this.paddingBottom = 32,
      this.horizontalPadding = 64});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      alignment: alignment,
      contentPadding: EdgeInsets.only(
          bottom: paddingBottom.h,
          left: horizontalPadding!.w,
          right: horizontalPadding!.w,
          top: paddingTop.h),
      titlePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r)),
      elevation: 0,
      titleTextStyle: ThemeTextSemibold.xl.copyWith(color: ThemeColors.grayish),
      children: children,
      insetPadding: EdgeInsets.symmetric(horizontal: 25.w),
      title: title,
    );
  }
}
