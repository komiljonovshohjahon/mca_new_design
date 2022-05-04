import 'package:mca_new_design/template/base/template.dart';

class DotWidget extends StatelessWidget {
  Color color;
  double? height;
  DotWidget({Key? key, this.color = ThemeColors.mainGreen, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 9.h,
      width: height ?? 9.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
