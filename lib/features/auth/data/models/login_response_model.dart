import 'package:base_flutter/core/common/domain/entities/user_models.dart';
import 'package:flutter/material.dart';

class LoginResponseModel {
  final bool isAuthenticated;
  final String message;
  final String? accessToken;
  final UserModels? user;

  LoginResponseModel({
    required this.isAuthenticated,
    required this.message,
    this.accessToken,
    this.user,
  });

  factory LoginResponseModel.fromApi(
    Map<String, dynamic> json,
    String userAuth,
    String passAuth,
  ) {

    final bool isSuccess = json["isAuthenticated"] ?? false;
    final String msg = json["message"] ?? '';
    final String? token = json["accessToken"];

    UserModels? userData;
    if (isSuccess && json["user"] != null) {
        userData = UserModels.fromJson(json["user"]);
        userData.password = passAuth;
        userData.userName = userAuth;   
    }

    return LoginResponseModel(
      isAuthenticated: isSuccess,
      message: msg,
      accessToken: token,
      user: userData,
    );
  }
}
