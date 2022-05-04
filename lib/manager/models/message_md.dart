class MsgTypes {
  MessageSummaryModel? messageSummary;
  List<MessageModel> message;
  MsgTypes({required this.message, this.messageSummary});
}

class MessageModel {
  int? messageId;
  String? createdOn;
  String? createdBy;
  String? subject;
  String? content;
  String? readOn;

  MessageModel(
      {this.messageId,
      this.createdOn,
      this.createdBy,
      this.subject,
      this.content,
      this.readOn});

  MessageModel.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    subject = json['subject'];
    content = json['content'];
    readOn = json['readOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message_id'] = this.messageId;
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['subject'] = this.subject;
    data['content'] = this.content;
    data['readOn'] = this.readOn;
    return data;
  }
}

class MessageSummaryModel {
  int? all;
  int? unread;

  MessageSummaryModel({this.all, this.unread});

  MessageSummaryModel.fromJson(Map<String, dynamic> json) {
    all = json['all'];
    unread = json['unread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    data['unread'] = this.unread;
    return data;
  }
}
