import 'package:mca_new_design/template/base/template.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? bgColor;
  final String msg;
  final bool isDisabled;
  final double? width;
  final double? height;
  final double radius;
  final bottomRadius;
  DefaultButton(
      {Key? key,
      required this.msg,
      this.onTap,
      this.radius = 4,
      this.height,
      this.width,
      this.bgColor,
      this.bottomRadius = true,
      this.isDisabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(ThemeColors.white.withOpacity(0.2)),
          fixedSize:
              MaterialStateProperty.all(Size(width ?? 203.w, height ?? 48.h)),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return ThemeColors.grayish;
            }
            if (isDisabled) {
              return ThemeColors.grayish;
            }

            if (bgColor != null) return bgColor;

            return ThemeColors.mainGreen;
          }),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft:
                      bottomRadius ? Radius.circular(radius.h) : Radius.zero,
                  bottomRight:
                      bottomRadius ? Radius.circular(radius.h) : Radius.zero,
                  topRight: Radius.circular(radius.h),
                  topLeft: Radius.circular(radius.h)))),
          textStyle: MaterialStateProperty.all(ThemeTextRegular.base),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return ThemeColors.c505050;
            }
            if (isDisabled) {
              return ThemeColors.c505050;
            }
            return ThemeColors.white;
          }),
        ),
        onPressed: onTap,
        child: SizedText(text: msg));
  }
}
