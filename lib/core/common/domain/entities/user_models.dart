import 'package:base_flutter/core/common/domain/entities/access_user_models.dart';

class UserModels
{
    String UserName;
    String Session;
    String Nombre;
    String Apellido;
    String Password;
    String Rol;
    String? Email;
    String? FullName;
    AccessUserModels? Acceso; 

    UserModels({
        required this.UserName,
        required this.Session,
        required this.Nombre,
        required this.Apellido,
        required this.Password,
        required this.Rol,
        this.Email,
        this.FullName,
        this.Acceso,
    });

    factory UserModels.fromJson(Map<String, dynamic> json) => UserModels(
        UserName: json["UserName"],
        Session: json["Session"],
        Nombre: json["Nombre"],
        Apellido: json["Apellido"],
        Password: json["Password"],
        Rol: json["Rol"],
        Email: json["Email"],
        FullName: json["FullName"],
        Acceso: json["Acceso"]==null?null: AccessUserModels.fromJson(json["Acceso"]),
    );
    
    Map<String, dynamic> toJson() => {
        "UserName": UserName,
        "Session": Session,
        "Nombre": Nombre,
        "Apellido":Apellido,
        "Password":Password,
        "Rol": Rol,
        "Email": Email,
        "FullName": FullName,
        "Acceso":Acceso==null?null :Acceso!.toJson()
    };
    
}