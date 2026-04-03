import 'package:base_flutter/core/common/domain/entities/user_models.dart';
import 'package:flutter/material.dart';

class LoginResponseModel{
    final int statusCode;
    final String message;
    UserModels ? user;

    LoginResponseModel({
        required this.statusCode,
        required this.message,
        this.user
    });

    factory LoginResponseModel.fromApi(Map<String, dynamic> json, String userAuth, String passAuth) {

        final bool isSuccess = json["state"] ?? false;
        final String msg = json["message"] ?? '';
        UserModels? user;
    
        int code = isSuccess ? 200 : 400;
  
        // ... mapeo del usuario ...
        if (msg == "Se debe cambiar la clave." && code == 400) {
            user = UserModels(
            UserName: userAuth,
            Session: '0000-0000-0000-0000-0000-0000',
            Nombre: 'xxx',
            Apellido: 'xxx',
            Password: passAuth,
            FullName: 'xxx',
            Email: 'xxx',
            Rol: "Usuario",
            );

            return LoginResponseModel(statusCode: 300, message: msg, user: user);
        }

        if (code == 200) {
            final data = json["list"][0];

            user = UserModels(
            UserName: userAuth,
            Session: data["USERTOKEN"],
            Nombre: data["NOMBRE"],
            Apellido: data["APELLIDO"],
            Password: passAuth,
            FullName: data["FULLNAME"],
            Email: data["EMAIL"],
            Rol: "Usuario",
            );

            if (data["CHANGEPASS"] > 0) {
            code = 300; // requiere cambio de contraseña
            }
        }

    
   return LoginResponseModel(
        statusCode: code,
        message: msg,
        user: code != 200 ? (code != 300 ? null : user) : user,
      );
  
  }
}
    
