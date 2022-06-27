import 'package:mca_new_design/template/base/template.dart';
import 'package:url_launcher/url_launcher.dart';

const String _email = 'apperror@mycleaningapp.com';

class ErrorScreen extends StatelessWidget {
  FlutterErrorDetails errorDetails;

  ErrorScreen({Key? key, required this.errorDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
        hasDrawer: false,
        titleText: 'error',
        centerTitle: true,
        paddingHorizontal: 10,
        paddingTop: 5,
        bgColor: ThemeColors.white,
        child: (_) => SpacedColumn(
              children: [
                Image.asset('assets/images/error.png', height: 200, width: 200),
                SizedText(
                  text: "oops",
                  textStyle: ThemeTextBold.lg2,
                ),
                const SizedBox(height: 20),
                SizedText(
                  text: "error_screen_msg",
                  params: const {"email": _email},
                  textStyle: ThemeTextRegular.base,
                  maxLines: 10,
                  textAlign: TextAlign.center,
                ),
                // const SizedBox(height: 20),
                // SelectableText(
                //   _email,
                //   style:
                //       ThemeTextRegular.lg.apply(color: ThemeColors.mainBlue2),
                // ),
                const SizedBox(height: 20),
                TextButton.icon(
                  icon: const Icon(Icons.email),
                  onPressed: _send,
                  label: SizedText(
                      text: "openEmailApp", textStyle: ThemeTextRegular.base),
                )
              ],
            ));
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _send() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: _email,
      query: encodeQueryParameters(<String, String>{
        "body":
            "error: ${errorDetails.exception.toString()}\nstack_trace: ${errorDetails.stack.toString()}",
        'subject':
            "${errorDetails.summary.toDescription()} - Date/Time: ${formatDate(DateTime.now(), [
              "yyyy",
              "mm",
              "dd",
              "HH",
              "mm",
              "ss"
            ])}",
      }),
    );

    launchUrl(emailLaunchUri);
  }
}
