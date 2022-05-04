import 'dart:convert';
import 'dart:typed_data';

import 'package:mca_new_design/template/base/template.dart';

class WelcomeUserWidget extends StatelessWidget {
  String username;
  String? imageBase64;
  WelcomeUserWidget({Key? key, required this.username, this.imageBase64})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpacedRow(
        horizontalSpace: 15,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (imageBase64 != null) SizedBox(width: 2.w),
          imageBase64 != null
              ? DecoratedBox(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        color: ThemeColors.black.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(0, 1))
                  ]),
                  child: CircleAvatar(
                    minRadius: 27.w,
                    foregroundImage: MemoryImage(fromBase64(imageBase64!)),
                  ))
              : const SizedBox(),
          SizedText(
            text: 'welcome_back',
            params: {"username": username},
            textStyle:
                ThemeTextSemibold.lg1.copyWith(color: ThemeColors.mainBlue),
          ),
        ]);
  }
}

Uint8List fromBase64(String imageBase64) {
  return base64Decode(imageBase64);
}
