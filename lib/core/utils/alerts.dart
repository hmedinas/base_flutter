import 'package:base_flutter/core/constants/app_contans.dart';
import 'package:base_flutter/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum typeAlert { mensaje, error, ok, confirm }

mostrarAlert(BuildContext context, String message, typeAlert type) {
  String titulo;
  Color ColorTitulo;
  switch (type) {
    case typeAlert.mensaje:
      titulo = 'MENSAJE';
      ColorTitulo = AppColors.background;
      break;
    case typeAlert.error:
      titulo = 'ERROR';
      ColorTitulo = Colors.red;
      break;
    case typeAlert.ok:
      titulo = 'SUCCESS';
      ColorTitulo = AppColors.background;;
      break;
    case typeAlert.confirm:
      titulo = 'CONFIRMAR';
      ColorTitulo = Colors.orange;
      break;
    default:
      titulo = 'MENSAJE';
      ColorTitulo = AppColors.background;;
  }

  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: true,
    descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
    animationDuration: Duration(milliseconds: 200),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(color: Colors.grey),
    ),
    titleStyle: TextStyle(
      color: ColorTitulo,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  );
  return Alert(
    context: context,
    //image: Image.asset("assets/images/talma_blue.png"),
    style: alertStyle,
    title: titulo,
    desc: message,
    buttons: [
      DialogButton(
        child: Text(
          "Aceptar",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: AppColors.titleGraphic,
        radius: BorderRadius.circular(10.0),
      ),
    ],
  ).show();
}

mostrarAlertToReditect(
  BuildContext context,
  String message,
  typeAlert type,
  String? redirect,
) {
  String titulo;
  switch (type) {
    case typeAlert.mensaje:
      {
        titulo = 'MENSAJE';
        break;
      }
    case typeAlert.error:
      {
        titulo = 'ERROR';
        break;
      }
    case typeAlert.ok:
      {
        titulo = 'SUCCESS';
        break;
      }
    case typeAlert.confirm:
      {
        titulo = 'CONFIRMAR';
        break;
      }
    default:
      titulo = 'MENSAJE';
  }

  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: true,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 200),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(color: Colors.grey),
    ),
    titleStyle: TextStyle(
      color: AppColors.background,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
  );
  return Alert(
    context: context,
    //image: Image.asset("assets/images/talma_blue.png"),
    style: alertStyle,
    title: titulo,
    desc: message,
    buttons: [
      DialogButton(
        child: Text(
          "Aceptar",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          if (redirect == null) {
            return Navigator.pop(context);
          } else {
            Navigator.pushReplacementNamed(context, redirect);
          }
        },
        color: AppColors.background,
        radius: BorderRadius.circular(10.0),
      ),
    ],
  ).show();
}
