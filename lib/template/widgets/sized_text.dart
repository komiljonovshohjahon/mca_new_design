import 'package:mca_new_design/template/base/template.dart';

class SizedText extends StatelessWidget {
  final double? width;
  final double? height;
  final dynamic text;
  final TextStyle? textStyle;
  final bool softWrap;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final int maxLines;
  Map<String, String>? params;

  SizedText({
    this.width,
    this.height,
    required this.text,
    this.textStyle,
    this.softWrap = true,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.left,
    this.maxLines = 2,
    this.params,
  }) {
    params ??= {};
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Text(
        text.toString().trParams(params!),
        style: textStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
      ),
    );
  }
}
