import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'chat_model.dart';

class ChatViewModel extends GetxController{

  RxList<ChatModel> messages = <ChatModel>[].obs;
  ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();
  var dialogFlowtter;

  @override
  void onInit() async{
    await DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    DetectIntentResponse response = await dialogFlowtter.detectIntent(queryInput: QueryInput(text: TextInput(text: 'Location: ${Get.arguments['location']}')));
    if(response.message == null) return;
    else{
      addMessage(response.message!);
    }
    super.onInit();
  }

  sendMessage(String text)async{
    if(text.isEmpty){
      return;
    } else{
      addMessage(Message(text: DialogText(text: [text])), true);
      textController.clear();
      DetectIntentResponse response = await dialogFlowtter.detectIntent(queryInput: QueryInput(text: TextInput(text: text, languageCode: 'en')));
      if(response.message == null) return;
      addMessage(response.message!);
    }
  }

  addMessage(Message message, [bool isUserMessage = false]){
    messages.add(ChatModel(message: message, isUser: isUserMessage));
    messages.refresh();
    Future.delayed(Duration(milliseconds: 300), (){
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }
}