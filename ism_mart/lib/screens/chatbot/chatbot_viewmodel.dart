import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import 'chat_model.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class ChatViewModel extends GetxController with GetTickerProviderStateMixin{

  RxList<ChatModel> messages = <ChatModel>[].obs;
  ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();
  var dialogFlowtter;
  RxString currentAddress = ''.obs;
  Position? currentPosition;
  RxBool tryAgain = false.obs;

  @override
  void onReady() {
    locationPermission();
    super.onReady();
  }

  locationPermission()async{
    await getCurrentLocation();
  }

  Future<void> getCurrentLocation()async{
    GlobalVariable.showLoader.value = true;
    tryAgain.value = false;
    if(await Permission.location.serviceStatus.isEnabled){
      if (await Permission.location.request().isGranted) {
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
          currentPosition = position;
          getAddressFromPosition(currentPosition!);
        }).catchError((e) {
          GlobalVariable.showLoader.value = false;
          tryAgain.value = true;
          AppConstant.displaySnackBar(langKey.errorTitle.tr, e);
        });
      } else if(await Permission.location.isDenied){
        GlobalVariable.showLoader.value = false;
        tryAgain.value = true;
        AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.locationAccessDenied.tr);
        await Permission.location.request();
      } else if(await Permission.location.isPermanentlyDenied){
        GlobalVariable.showLoader.value = false;
        tryAgain.value = true;
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.locationAccessPermanentlyDenied.tr);
        tryAgain.value = false;
      } else{
        GlobalVariable.showLoader.value = false;
        return;
      }
    } else {
      GlobalVariable.showLoader.value = false;
      tryAgain.value = true;
      AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.enableLocation.tr);
      return ;
    }
  }

  getAddressFromPosition(Position position) async{
    await placemarkFromCoordinates(currentPosition!.latitude, currentPosition!.longitude).then((List<Placemark> placemarks) async {
      Placemark place = placemarks[0];
      currentAddress.value = "${place.locality}, " + "${place.country}";
      if(currentAddress.value.isNotEmpty) {
        await DialogFlowtter.fromFile().then((instance) {
          dialogFlowtter = instance;
        });
        DetectIntentResponse response = await dialogFlowtter.detectIntent(
            queryInput: QueryInput(
                text: TextInput(text: 'Location: ${currentAddress.value}')));
        if (response.message == null) {
          return;
        }
        else {
          GlobalVariable.showLoader.value = false;
          addMessage(response.message!, AnimationController(
              vsync: this, duration: Duration(milliseconds: 400)));
        }
      } else{
        GlobalVariable.showLoader.value = false;
        tryAgain.value = true;
        AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.couldNotGetLocation.tr);
      }
    }).catchError((e) {
      tryAgain.value = true;
      AppConstant.displaySnackBar(langKey.errorTitle.tr, e);
      GlobalVariable.showLoader.value = false;
    });
  }

  sendMessage(String text)async{
    if(text.isEmpty){
      return;
    } else{
      addMessage(Message(text: DialogText(text: [text])), AnimationController(vsync: this, duration: Duration(milliseconds: 400)), true);
      textController.clear();
      DetectIntentResponse response = await dialogFlowtter.detectIntent(queryInput: QueryInput(text: TextInput(text: text, languageCode: 'en')));
      if(response.message == null) return;
      addMessage(response.message!, AnimationController(vsync: this, duration: Duration(milliseconds: 400)));
    }
  }

  addMessage(Message message, AnimationController animationController, [bool isUserMessage = false]){
    messages.add(ChatModel(message: message, isUser: isUserMessage, animationController: animationController));
    messages.last.animationController?.forward();
    messages.refresh();
    Future.delayed(Duration(milliseconds: 400), (){
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  Widget messageContainer(int index) {
    return Container(
      padding: EdgeInsets.only(
        top: 12,
      ),
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: messages[index].animationController!, curve: Curves.easeInOut),
        child: Align(
          alignment: messages[index].isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 12),
            constraints: BoxConstraints(
              maxWidth: Get.width * 0.85,
              minWidth: Get.width * 0.03,
            ),
            decoration: BoxDecoration(
              color: (messages[index].isUser
                  ? Colors.black
                  : Colors.black.withOpacity(0.3)),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18),
                topLeft: Radius.circular(18),
                bottomRight: messages[index].isUser ? Radius.zero
                    : Radius.circular(18),
                bottomLeft: messages[index].isUser
                    ? Radius.circular(18)
                    : Radius.zero,
              ),
            ),
            child: messages[index].message?.text != null &&
                messages[index].message?.text?.text?[0] != ''
                ? Text(
              messages[index].message?.text?.text?.first ?? '',
              textAlign: messages[index].isUser ? TextAlign.end : TextAlign.start,
              style: TextStyle(
                color: Colors.white,
              ),
            ) : SizedBox(),
          ),
        ),
      ),
    );
  }
}