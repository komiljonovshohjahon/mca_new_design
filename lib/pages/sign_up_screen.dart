import 'package:flutter/foundation.dart';
import 'package:mca_new_design/manager/periodic_actions.dart';
import 'package:mca_new_design/template/base/template.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
        onInit: () {},
        showLeadingMenuBtn: true,
        paddingHorizontal: 0,
        bgColor: ThemeColors.white,
        child: (state) => SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset('assets/images/shape_blue.svg')),
                  SpacedColumn(
                    verticalSpace: 40,
                    children: [
                      SvgPicture.asset('assets/images/mca_icon.svg'),
                      _SignUpInputsWidget(state),
                    ],
                  ),
                ],
              ),
            ));
  }
}

class _SignUpInputsWidget extends StatefulWidget {
  AppState state;
  _SignUpInputsWidget(this.state, {Key? key}) : super(key: key);

  @override
  State<_SignUpInputsWidget> createState() => _SignUpInputsWidgetState();
}

class _SignUpInputsWidgetState extends State<_SignUpInputsWidget> {
  final TextEditingController domainContr =
      TextEditingController(text: kDebugMode ? Constants.domain : "");
  final TextEditingController usernameContr =
      TextEditingController(text: kDebugMode ? '38195839' : "");
  final TextEditingController pwdContr =
      TextEditingController(text: kDebugMode ? 'F00tba11' : "");

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    domainContr.dispose();
    usernameContr.dispose();
    pwdContr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppState state = widget.state;
    final String? error = state.initState.apiError.error_description;
    return WillPopScope(
      onWillPop: () => quitAppPopup(),
      child: Form(
        key: formKey,
        child: SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalSpace: 10,
          children: [
            if (error != null) SizedText(text: error),
            SpacedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalSpace: 8,
                children: [
                  InputLabelWidget('domain'),
                  DefaultInput(
                      textInputAction: TextInputAction.next,
                      validator: Validator.validateDomain,
                      controller: domainContr,
                      hintText: 'www.kamal.info')
                ]),
            SpacedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalSpace: 8,
                children: [
                  InputLabelWidget('username'),
                  DefaultInput(
                      textInputAction: TextInputAction.next,
                      validator: Validator.validateUsername,
                      controller: usernameContr,
                      hintText: 'kamal')
                ]),
            SpacedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalSpace: 8,
                children: [
                  InputLabelWidget('password'),
                  DefaultInput(
                      textInputAction: TextInputAction.done,
                      validator: Validator.validatePwd,
                      controller: pwdContr,
                      hintText: '********',
                      isObscured: true)
                ]),
            SizedBox(height: 10.h),
            DefaultButton(
                width: 323.w,
                height: 44.h,
                msg: "register_now".tr +
                    (state.initState.isTest ? " " + "_test".tr : ""),
                onTap: _onLogin,
                bgColor: ThemeColors.mainBlue),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  _onLogin() {
    if (formKey.currentState!.validate()) {
      appStore.dispatch(GetTokenAction(
          pwd: pwdContr.text,
          username: usernameContr.text,
          domain: domainContr.text));
    }
  }
}
