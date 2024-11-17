import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:toastification/toastification.dart';

class ToastificationUtil {

  static void toast(String message, ToastificationType type, Alignment alignment) {
    toastification.show(// optional if you use ToastificationWrapper
      type: type,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(milliseconds: 2500),
      title: Text("$message",
      style: const TextStyle(
        color: Color(0xfffff5de)
      ),),
      // you can also use RichText widget for title and description parameters
      alignment: alignment,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 500),
      icon: Icon(getToastIcon(type), color: const Color(0xffffffff),),
      showIcon: true, // show or hide the icon
      primaryColor: getToastColor(type),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  static Color getToastColor(ToastificationType type) {
    switch(type) {
      case ToastificationType.success:
        return const Color(0xff18bb9c);
      case ToastificationType.error:
        return const Color(0xffe84c3d);
      case ToastificationType.warning:
        return const Color(0xfff39c11);
      case ToastificationType.info:
        return const Color(0xff3598db);
    }

  }

  static IconData getToastIcon(ToastificationType type) {
    switch(type) {
      case ToastificationType.success:
        return Boxicons.bx_check;
      case ToastificationType.error:
        return Boxicons.bx_no_entry;
      case ToastificationType.warning:
        return Boxicons.bx_error;
      case ToastificationType.info:
        return Boxicons.bx_info_circle;
    }

  }

}