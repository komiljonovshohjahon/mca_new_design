import 'package:mca_new_design/template/base/template.dart';

class DefaultButtonListener extends StatefulWidget {
  final VoidCallback? onTap;
  final Color? bgColor;
  final String msg;
  final bool isDisabled;
  final double? width;
  final double? height;
  final double radius;
  DefaultButtonListener(
      {Key? key,
      required this.msg,
      this.onTap,
      this.radius = 4,
      this.height,
      this.width,
      this.bgColor,
      this.isDisabled = false})
      : super(key: key);

  @override
  State<DefaultButtonListener> createState() => _DefaultButtonListenerState();
}

class _DefaultButtonListenerState extends State<DefaultButtonListener> {
  DateTime timeBackPressed = DateTime.now();
  int timesPressed = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      msg: widget.msg,
      bgColor: widget.bgColor,
      width: widget.width,
      key: widget.key,
      isDisabled: widget.isDisabled,
      height: widget.height,
      radius: widget.radius,
      onTap: () {
        final difference = DateTime.now().difference(timeBackPressed);
        final isReset = difference <= const Duration(milliseconds: 400);

        timeBackPressed = DateTime.now();

        if (isReset) {
          setState(() {
            timesPressed++;
          });
        } else {
          setState(() {
            timesPressed = 1;
          });
        }
        if (timesPressed == 5) {
          if (widget.onTap != null) widget.onTap!();
        }
      },
    );
  }
}
