import 'package:hm_flutter_base/core/common/domain/entities/business_models.dart';

class UserModels {
  final String title;
  final String fullName;
  String userName;
  final String email;
  String? password;
  String? userHash;
  final bool isActive;
  final int department;
  final String departmentDesc;
  final int idUser;
  final List<String> roles;
  List<BusinessModels>? businessModels;
  

  UserModels({
    required this.title,
    required this.fullName,
    required this.userName,
    required this.email,
    this.password,
    this.userHash,
    required this.isActive,
    required this.department,
    required this.departmentDesc,
    required this.idUser,
    required this.roles,
    this.businessModels
  });

  factory UserModels.fromJson(Map<String, dynamic> json) => UserModels(
    title: json["title"],
    fullName: json["fullName"],
    userName: json["userName"],
    email: json["email"],
    userHash: json["userHash"],
    isActive: json["isActive"],
    department: json["department"],
    departmentDesc: json["departmentDesc"],
    idUser: json["idUser"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    businessModels: json["businessModels"] == null
        ? null
        : List<BusinessModels>.from(
            json["businessModels"].map((x) => BusinessModels.fromJson(x)),
          ),

  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "fullName": fullName,
    "userName": userName,
    "email": email,
    "userHash": userHash, 
    "isActive": isActive,
    "department": department,
    "departmentDesc": departmentDesc,
    "idUser": idUser,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "businessModels": businessModels == null 
        ? null 
        : List<dynamic>.from(businessModels!.map((x) => x.toJson())),
  };
}
