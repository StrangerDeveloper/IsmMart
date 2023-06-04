import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController{
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}