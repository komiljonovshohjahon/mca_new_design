import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:mca_new_design/template/base/template.dart';

class DefaultShimmer extends StatelessWidget {
  final int length;
  final SHIMMER_TYPE type;
  DefaultShimmer({this.length = 1, this.type = SHIMMER_TYPE.LIST});
  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      children: [
        for (int i = 0; i < length; i++)
          ListTileShimmer(padding: EdgeInsets.zero, height: 10.h),
      ],
    );
  }
}

enum SHIMMER_TYPE {
  LIST,
  PROFILE,
  PLASYSTORE,
}
