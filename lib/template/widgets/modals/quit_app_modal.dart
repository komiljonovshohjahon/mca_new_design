import 'package:flutter/services.dart';
import 'package:mca_new_design/template/base/template.dart';

quitAppPopup({bool hasReset = true}) {
  showDialog(
    context: Get.context!,
    builder: (_) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
        title: SizedText(text: 'leave_the_app'),
        content: SizedText(text: "leave_the_app_warning"),
        actions: [
          if (hasReset)
            SpacedRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultButton(
                    height: 40,
                    width: 80,
                    bgColor: ThemeColors.mainRed,
                    onTap: () {
                      //1.Clear cache
                      //2. Quit app
                      appStore.dispatch(GetResetAction());
                    },
                    msg: 'reset'.tr.toUpperCase()),
                SpacedRow(
                  horizontalSpace: 10,
                  children: [
                    DefaultButton(
                        height: 40,
                        width: 80,
                        isDisabled: true,
                        onTap: () {
                          appStore.popupPop();
                        },
                        msg: 'stay'.tr.toUpperCase()),
                    DefaultButton(
                        height: 40,
                        width: 80,
                        bgColor: ThemeColors.mainBlue,
                        onTap: () {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        },
                        msg: 'leave'.tr.toUpperCase()),
                  ],
                ),
              ],
            )
          else
            SpacedRow(
              mainAxisAlignment: MainAxisAlignment.end,
              horizontalSpace: 10,
              children: [
                DefaultButton(
                    height: 40,
                    width: 80,
                    bgColor: ThemeColors.mainBlue,
                    onTap: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    msg: 'leave'.tr.toUpperCase()),
                DefaultButton(
                    height: 40,
                    width: 80,
                    isDisabled: true,
                    onTap: () {
                      appStore.popupPop();
                    },
                    msg: 'stay'.tr.toUpperCase()),
              ],
            ),
        ],
      );
    },
  );
}
