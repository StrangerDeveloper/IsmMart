import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'chatbot_viewmodel.dart';

class ChatBotView extends StatelessWidget {
  ChatBotView({super.key});

  final ChatViewModel viewModel = Get.put(ChatViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: Obx(() => viewModel.tryAgain.value == true ? Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: ()async{
                            await viewModel.getCurrentLocation();
                        }, icon: Icon(Icons.refresh, size: 35, color: Colors.black,)
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Error establishing connection, Try Again.',
                    style: bodyText2,
                  )
                ],
              ),
            )
          ],
        ) : Stack(
          children: [
            Column(
              children: [
                messageBody(),
                writeMessage(context),
              ],
            ),
            LoaderView(),
          ],
        ),
      ),
    )
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: AppBar(
        title: Text(
          maxLines: 1,
          'ISMBot',
          overflow: TextOverflow.ellipsis,
          style: headline1,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 3,
        flexibleSpace: Row(
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(CupertinoIcons.chevron_back),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(height: 3),
                    // Text(
                    //   "Online",
                    //   style: TextStyle(
                    //     fontSize: 12.5,
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageBody() {
    return Obx(
      () => Expanded(
        child: Container(
          child: ListView.builder(
            // reverse: true,
            controller: viewModel.scrollController,
            itemCount: viewModel.messages.length,
            padding: EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              return messageListViewItem(index);
            },
          ),
        ),
      ),
    );
  }

  Widget messageListViewItem(int index) {
    return Container(
      padding: EdgeInsets.only(
        left: viewModel.messages[index].isUser ? 0 : 14,
        right: viewModel.messages[index].isUser ? 14 : 0,
        top: 12,
      ),
      child: Column(
        crossAxisAlignment: viewModel.messages[index].isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          viewModel.messageContainer(index),
          // dateTimeContainers(index),
        ],
      ),
    );
  }

  // Widget dateTimeContainers(int index) {
  //   return Text(
  //     (viewModel.messagesList[index].msgDate ?? '') +
  //         ' ' +
  //         (viewModel.messagesList[index].msgTime ?? ''),
  //     style: TextStyle(
  //       fontSize: 10.5,
  //       color: Colors.grey,
  //     ),
  //   );
  // }

  Widget writeMessage(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3),
      color: Colors.black12,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: viewModel.textController,
              textInputAction: TextInputAction.send,
              maxLines: 3,
              minLines: 1,
              onChanged: (value) {},
              onFieldSubmitted: (value) {},
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Write message .....",
                hintStyle: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          Container(
            width: 45,
            height: 45,
            margin: EdgeInsets.only(right: 5),
            child: FloatingActionButton(
              onPressed: () {
                viewModel.sendMessage(viewModel.textController.text);
              },
              child: Icon(
                Icons.send,
                color: Colors.grey.shade700,
                size: 30,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
