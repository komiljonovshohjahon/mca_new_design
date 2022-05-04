import 'package:mca_new_design/template/base/template.dart';

class RectangleWidget extends StatelessWidget {
  final Widget child;
  final double? height;
  final VoidCallback? onTap;
  RectangleWidget({Key? key, required this.child, this.onTap, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height != null ? height!.h : null,
        child: child,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ThemeColors.white,
            borderRadius: BorderRadius.circular(4.r),
            boxShadow: [
              BoxShadow(
                  color: ThemeColors.black.withOpacity(0.16),
                  offset: const Offset(0, 1),
                  blurRadius: 4)
            ]),
      ),
    );
  }
}
