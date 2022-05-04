import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mca_new_design/template/base/template.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Widget? html;

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
        onInit: () => _loadHtml(),
        showLeadingMenuBtn: true,
        paddingHorizontal: 10,
        paddingTop: 5,
        footer: (state) => _buildFooter(state),
        bgColor: ThemeColors.white,
        child: (_) => html != null
            ? RawScrollbar(child: SingleChildScrollView(child: html!))
            : Container());
  }

  _loadHtml() async {
    String fileText =
        await rootBundle.loadString('assets/files/termsAndCond.html');
    setState(() {
      html = Html(data: fileText);
    });
  }

  Widget _buildFooter(AppState state) {
    final bool isTest = state.initState.isTest;
    return DefaultButtonListener(
        radius: 0,
        msg: '${Constants.testVerCode} ${isTest ? "(test)".tr : ""}',
        bgColor: ThemeColors.fillGray,
        onTap: () {
          appStore.dispatch(GetEnableTestModeAction());
        });
  }
}
