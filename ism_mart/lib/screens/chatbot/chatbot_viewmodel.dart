import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/chatbot/message_model.dart';

class ChatBotViewModel extends GetxController {
  ScrollController scrollController = ScrollController();
  List<MessageModel> messagesList = <MessageModel>[
    MessageModel(
        msgBody: 'abc',
        msgAction: 'received',
        msgDate: '1/1/1',
        msgTime: '01:01 am'),
    MessageModel(
        msgBody: 'abc',
        msgAction: 'sent',
        msgDate: '1/1/1',
        msgTime: '01:01 am'),
    MessageModel(
        msgBody: 'abc',
        msgAction: 'received',
        msgDate: '1/1/1',
        msgTime: '01:01 am'),
    MessageModel(
        msgBody: 'abc',
        msgAction: 'received',
        msgDate: '1/1/1',
        msgTime: '01:01 am'),
    MessageModel(
        msgBody: 'abc',
        msgAction: 'sent',
        msgDate: '1/1/1',
        msgTime: '01:01 am'),
  ].obs;
  TextEditingController messageController = TextEditingController();
}
