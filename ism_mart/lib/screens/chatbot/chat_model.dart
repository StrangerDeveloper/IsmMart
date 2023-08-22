// class MessageModel {
//   int? msgId;
//   String? msgBody;
//   // String? msgAction;
//   // String? msgDate;
//   // String? msgTime;
//
//   MessageModel({
//     this.msgId, this.msgBody, this.msgAction, this.msgDate, this.msgTime});
//
//   MessageModel.fromJson(Map<String, dynamic> json) {
//     msgId = json['msg_id'];
//     msgBody = json['msg_body'];
//     msgAction = json['msg_action'];
//     msgDate = json['msg_date'];
//     msgTime = json['msg_time'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['msg_id'] = this.msgId;
//     data['msg_body'] = this.msgBody;
//     data['msg_action'] = this.msgAction;
//
//     data['msg_date'] = this.msgDate;
//     data['msg_time'] = this.msgTime;
//     return data;
//   }
// }
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/animation.dart';

class ChatModel {

  Message? message;
  bool isUser;
  late AnimationController? animationController;

  ChatModel({this.message, this.isUser = false, this.animationController});

}