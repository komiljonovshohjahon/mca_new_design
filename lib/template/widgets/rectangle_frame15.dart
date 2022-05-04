import 'package:mca_new_design/template/base/template.dart';

class RectangleFrame15 extends StatelessWidget {
  final VoidCallback? onTap;
  final Color bgColor;
  final Widget child;
  final int borderRadius;
  final bool withBottomBorder;
  final double height;

  RectangleFrame15({
    this.onTap,
    required this.child,
    this.height = 45,
    this.bgColor = ThemeColors.white,
    this.borderRadius = 5,
    this.withBottomBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 16.w),
        height: height.h,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius.r))),
        child: child,
      ),
    );
  }
}
