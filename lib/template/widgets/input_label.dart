import 'package:mca_new_design/template/base/template.dart';

class InputLabelWidget extends StatelessWidget {
  String msg;
  InputLabelWidget(this.msg, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedText(
      width: 250.w,
      text: msg,
      textStyle: ThemeTextSemibold.lg,
    );
  }
}
