import 'package:flutter/scheduler.dart';
import 'package:mca_new_design/template/base/template.dart';

class LayoutWrapper extends StatefulWidget {
  VoidCallback? onInit;
  VoidCallback? onDispose;
  Widget child;
  LayoutWrapper({Key? key, this.onInit, this.onDispose, required this.child})
      : super(key: key);

  @override
  State<LayoutWrapper> createState() => _LayoutWrapperState();
}

class _LayoutWrapperState extends State<LayoutWrapper> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback(
      (timeStamp) async {
        if (widget.onInit != null) widget.onInit!();
      },
    );
  }

  @override
  void dispose() {
    if (widget.onDispose != null) widget.onDispose!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
