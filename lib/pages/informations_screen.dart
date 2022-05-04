import 'package:mca_new_design/template/base/template.dart';
import '../manager/models/model_exporter.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      shimmerLength: 4,
      showActionMsg: () {},
      showActionBell: () {},
      onInit: () async {
        appStore.isLoading(true);
        await appStore.dispatch(GetInfosAction());
        appStore.isLoading(false);
      },
      paddingHorizontal: 0,
      showLeadingMenuBtn: true,
      child: (state) {
        return SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 26.h),
            _IdleBody(state: state),
            SizedBox(height: 26.h),
          ],
        ));
      },
    );
  }
}

class _IdleBody extends StatelessWidget {
  final AppState state;
  _IdleBody({required this.state});

  @override
  Widget build(BuildContext context) {
    final List<Today>? todaysList = state.modelsState.infosModel.today;
    final List<Next>? nextList = state.modelsState.infosModel.next;
    final List<Current>? currentList = state.modelsState.infosModel.current;
    final List<Completed>? completedList =
        state.modelsState.infosModel.completed;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SpacedColumn(
        verticalSpace: 26,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (todaysList != null && todaysList.isNotEmpty)
            _buildTodayList(todaysList)
          else
            _buildEmptyText("todays_activity", 'no_activity_today'),
          if (currentList != null && currentList.isNotEmpty)
            _buildCurrentList(currentList)
          else
            _buildEmptyText("current_shifts", 'no_shifts_today'),
          if (completedList != null && completedList.isNotEmpty)
            _buildCompletedList(completedList)
          else
            _buildEmptyText("completed_shifts", 'no_completed_shifts'),
          if (nextList != null && nextList.isNotEmpty)
            _buildNextList(nextList)
          else
            _buildEmptyText("next_shifts", 'no_next_shifts'),
        ],
      ),
    );
  }

  _buildTodayList(List<Today> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainLabel('todays_activity'),
        SizedBox(height: 14.h),
        SpacedColumn(
          verticalSpace: 12,
          children: list.map<Widget>((e) {
            final String topMsg =
                e.start != null ? '${e.name} at ${e.start!.location}' : "";
            final String bottomMsg =
                e.start != null ? e.start!.displayTime.toString() : "";
            return _buildMainFrame(
                topMsg: topMsg,
                bottomMsg: bottomMsg,
                icon: _getIcon(e.image.toString()),
                iconColor: _getIconColor(e.color));
          }).toList(),
        ),
      ],
    );
  }

  _buildNextList(List<Next> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainLabel('next_shifts'),
        SizedBox(height: 14.h),
        SpacedColumn(
          verticalSpace: 12,
          children: list.map<Widget>((e) {
            final String topMsg = e.start != null ? '${e.shift}' : "";
            final String bottomMsg =
                "${"from".tr} ${e.start} ${"to".tr} ${e.finish}";
            return _buildMainFrame(
                topMsg: topMsg,
                bottomMsg: bottomMsg,
                icon: FontAwesomeIcons.userClock,
                iconColor: ThemeColors.mainBlue);
          }).toList(),
        ),
      ],
    );
  }

  _buildCurrentList(List<Current> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainLabel('current_shifts'),
        SizedBox(height: 14.h),
        SpacedColumn(
          verticalSpace: 12,
          children: list.map<Widget>((e) {
            final String topMsg = e.start != null ? '${e.shift}' : "";
            final String bottomMsg =
                "${"from".tr} ${e.start} ${"to".tr} ${e.finish}";
            return _buildMainFrame(
                topMsg: topMsg,
                bottomMsg: bottomMsg,
                icon: FontAwesomeIcons.userClock,
                iconColor: ThemeColors.mainBlue);
          }).toList(),
        ),
      ],
    );
  }

  _buildCompletedList(List<Completed> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainLabel('next_shifts'),
        SizedBox(height: 14.h),
        SpacedColumn(
          verticalSpace: 12,
          children: list.map<Widget>((e) {
            final String topMsg = e.start != null ? '${e.shift}' : "";
            final String bottomMsg =
                "${"from".tr} ${e.start} ${"to".tr} ${e.finish}";
            return _buildMainFrame(
                topMsg: topMsg,
                bottomMsg: bottomMsg,
                icon: FontAwesomeIcons.userClock,
                iconColor: ThemeColors.mainBlue);
          }).toList(),
        ),
      ],
    );
  }

  _buildEmptyText(String title, String msg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainLabel(title),
        SizedBox(height: 8.h),
        SizedText(text: msg, textStyle: ThemeTextSemibold.lg1),
      ],
    );
  }

  _getIcon(String iconName) {
    switch (iconName) {
      case "signedin":
        return FontAwesomeIcons.signIn;
      case "signedout":
        return FontAwesomeIcons.signOut;
      default:
        return FontAwesomeIcons.xmarkCircle;
    }
  }

  _getIconColor(String? iconColor) {
    if (iconColor == null) return const Color(0xFF000000);
    final int colorCode = int.parse('0xFF$iconColor');
    return Color(colorCode);
  }

  _buildMainLabel(dynamic msg) {
    return SizedText(
        text: msg,
        textStyle: ThemeTextBold.lg.copyWith(color: ThemeColors.mainBlue));
  }

  _buildMainFrame(
      {required dynamic topMsg,
      required dynamic bottomMsg,
      required IconData icon,
      required Color iconColor,
      VoidCallback? onTap}) {
    return RectangleWidget(
        // height: 71,
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 16.w),
      child: SpacedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        horizontalSpace: 23,
        children: [
          FaIcon(icon, size: 30.w, color: iconColor),
          SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            verticalSpace: 3,
            children: [
              SizedText(
                  width: 203.w,
                  text: topMsg,
                  textStyle: ThemeTextRegular.base1
                      .copyWith(color: ThemeColors.c484848)),
              SizedText(
                  text: bottomMsg,
                  textStyle: ThemeTextRegular.base1
                      .copyWith(color: ThemeColors.c484848)),
            ],
          ),
        ],
      ),
    ));
  }
}
