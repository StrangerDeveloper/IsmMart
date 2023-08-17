import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/widgets/no_internet_view.dart';

import 'chatbot_viewmodel.dart';

class ChatBotView extends StatelessWidget {
  ChatBotView({super.key});

  final ChatViewModel viewModel = Get.put(ChatViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: Stack(
          children: [
            Column(
              children: [
                messageBody(),
                writeMessage(context),
              ],
            ),
            NoInternetView(
              onPressed: () {
                // GlobalVariable.showNoInternet.value = false;
                //viewModel.loadInitialData();
              },
            ),
            LoaderView(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: AppBar(
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
            // CachedNetworkImage(
            //   height: 45,
            //   width: 45,
            //   imageUrl: '',
            //   imageBuilder: (context, imageProvider) {
            //     return CircleAvatar(radius: 20, backgroundImage: imageProvider);
            //   },
            //   errorWidget: (context, url, error) {
            //     return CircleAvatar(
            //       radius: 20,
            //       backgroundImage: AssetImage(
            //         'assets/images/profile.png',
            //       ),
            //     );
            //   },
            //   placeholder: (context, url) {
            //     return const Center(
            //       child: CircularProgressIndicator(strokeWidth: 2.0),
            //     );
            //   },
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      maxLines: 1,
                      'Muhammad Hayat',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Online",
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.black,
                      ),
                    ),
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
      () => Flexible(
        child: ListView.builder(
          // reverse: true,
          controller: viewModel.scrollController,
          itemCount: viewModel.messages.length,
          padding: EdgeInsets.only(top: 8, bottom: 8),
          itemBuilder: (context, index) {
            return messageListViewItem(index);
          },
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
        crossAxisAlignment:
            viewModel.messages[index].isUser ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        children: [
          messageContainer(index),
          // dateTimeContainers(index),
        ],
      ),
    );
  }

  Widget messageContainer(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 12),
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.85,
        minWidth: Get.width * 0.03,
      ),
      decoration: BoxDecoration(
        color: (viewModel.messages[index].isUser
            ? Colors.black
            : Colors.black.withOpacity(0.3)),
        borderRadius: BorderRadius.only(
          topRight: viewModel.messages[index].isUser ? Radius.zero
              : Radius.circular(18),
          topLeft: viewModel.messages[index].isUser
              ? Radius.circular(18)
              : Radius.zero,
          bottomRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
        ),
      ),
      child: viewModel.messages[index].message?.text != null &&
          viewModel.messages[index].message?.text?.text?[0] != ''
        ? Text(
      viewModel.messages[index].message?.text?.text?.first ?? '',
      textAlign: viewModel.messages[index].isUser ? TextAlign.end : TextAlign.start,
      style: TextStyle(
        color: Colors.white,
      ),
    )
        : SizedBox(),
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
