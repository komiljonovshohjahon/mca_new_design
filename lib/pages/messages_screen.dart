import 'package:flutter_html/flutter_html.dart';
import 'package:mca_new_design/manager/models/model_exporter.dart';
import 'package:mca_new_design/template/base/template.dart';

class MessagesScreen extends StatefulWidget {
  static int msgLimit = 10;
  static int msgFrom = 0; // next => msgFrom + 10; previous => msgFrom - 10;
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int currentPage = 1;
  int totalPages = 0;
  @override
  void dispose() {
    MessagesScreen.msgLimit = 10;
    MessagesScreen.msgFrom = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      showLeadingMenuBtn: true,
      shimmerLength: 6,
      onInit: () async {
        appStore.isLoading(true);
        final res = await appStore.dispatch(GetMessagesAction(type: 'summary'));

        await appStore.dispatch(GetMessagesAction(
            type: 'all',
            limit: MessagesScreen.msgLimit.toString(),
            from: MessagesScreen.msgFrom.toString()));
        if (res != null) {
          setState(() {
            totalPages = (res.all / 10).round() < (res.all / 10)
                ? (res.all / 10).ceil()
                : (res.all / 10).round();
          });
        }
        appStore.isLoading(false);
      },
      paddingTop: 10,
      showArrowRight: () async {
        if (currentPage < totalPages) {
          appStore.isLoading(true);
          await appStore.dispatch(GetMessagesAction(
              type: 'all',
              limit: MessagesScreen.msgLimit.toString(),
              from: (MessagesScreen.msgFrom + 10).toString()));
          MessagesScreen.msgFrom += 10;
          setState(() {
            currentPage += 1;
          });
          appStore.isLoading(false);
        } else {
          appStore.snackbar('last_page');
        }
      },
      showArrowLeft: () async {
        if (currentPage != 1) {
          appStore.isLoading(true);
          await appStore.dispatch(GetMessagesAction(
              type: 'all',
              limit: MessagesScreen.msgLimit.toString(),
              from: (MessagesScreen.msgFrom - 10).toString()));
          MessagesScreen.msgFrom -= 10;
          setState(() {
            currentPage -= 1;
          });
          appStore.isLoading(false);
        } else {
          appStore.snackbar('first_page');
        }
      },
      child: (state) {
        return _MessagesWidget(
            state: state, currentPage: currentPage, totalPages: totalPages);
      },
    );
  }
}

class _MessagesWidget extends StatefulWidget {
  final AppState state;
  bool isEmpty = true;
  List<MessageModel> msgs = [];
  MessageSummaryModel? msgSmry;
  int currentPage;
  int totalPages;
  _MessagesWidget(
      {Key? key,
      required this.state,
      required this.totalPages,
      required this.currentPage})
      : super(key: key) {
    msgs = state.modelsState.messages.message;
    msgSmry = state.modelsState.messages.messageSummary;
    isEmpty = msgs.isEmpty;
  }

  @override
  State<_MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<_MessagesWidget> {
  int selectedMsg = -1;
  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      verticalSpace: 10,
      children: [
        RectangleWidget(
          height: 220.h,
          child: widget.isEmpty
              ? SizedText(text: 'no_messages')
              : SpacedColumn(
                  verticalSpace: 10,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: SpacedRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedText(
                              text: 'date', textStyle: ThemeTextRegular.lg1),
                          SizedText(
                              text: 'sender', textStyle: ThemeTextRegular.lg1),
                          SizedText(
                              text: 'subject', textStyle: ThemeTextRegular.lg1),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        itemCount: widget.msgs.length,
                        itemBuilder: (_, i) => _buildListItem(i),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: 5.h, left: 5.w, right: 5.w),
                      child: DefaultButton(
                          height: 40.h,
                          width: double.maxFinite,
                          msg: "${widget.currentPage}/${widget.totalPages}",
                          bgColor: ThemeColors.mainBlue,
                          onTap: () {}),
                    ),
                  ],
                ),
        ),
        RectangleWidget(
          height: 180.h,
          child: selectedMsg.isNegative
              ? SizedText(text: 'no_content_selected')
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  child: Column(
                    children: [
                      SpacedColumn(
                        verticalSpace: 2,
                        children: [
                          SpacedRow(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedText(
                                    text: 'date',
                                    textStyle: ThemeTextRegular.lg),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedText(
                                    text: widget.msgs[selectedMsg].createdOn,
                                    textStyle: ThemeTextRegular.lg),
                              )
                            ],
                          ),
                          SpacedRow(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedText(
                                    text: 'sender',
                                    textStyle: ThemeTextRegular.lg),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedText(
                                    text: widget.msgs[selectedMsg].createdBy,
                                    textStyle: ThemeTextRegular.lg),
                              )
                            ],
                          ),
                          SpacedRow(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedText(
                                    text: 'subject',
                                    textStyle: ThemeTextRegular.lg),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedText(
                                    text: widget.msgs[selectedMsg].subject,
                                    textStyle: ThemeTextRegular.lg),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      Flexible(
                          child: SingleChildScrollView(
                              child:
                                  Html(data: widget.msgs[selectedMsg].content)))
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildListItem(int i) {
    final item = widget.msgs[i];
    return DecoratedBox(
      decoration: BoxDecoration(
          color:
              i == selectedMsg ? ThemeColors.grayish : ThemeColors.transparent),
      child: GestureDetector(
        onTap: () => setState(() {
          selectedMsg = i;
        }),
        child: SpacedRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedText(
                width: 90.w,
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.fade,
                text: item.createdOn,
                textStyle: ThemeTextSemibold.xs),
            SizedText(
                width: 120.w,
                softWrap: false,
                maxLines: 1,
                text: item.createdBy,
                overflow: TextOverflow.fade,
                textStyle: ThemeTextSemibold.xs),
            SizedText(
                width: 80.w,
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.fade,
                text: item.subject,
                textStyle: ThemeTextSemibold.xs),
          ],
        ),
      ),
    );
  }
}
