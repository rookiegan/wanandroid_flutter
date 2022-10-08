import 'dart:developer';

import '../../toast_util.dart';



extension DynamicExt on dynamic {
  void successToast() {
    ToastUtil.showSuccessToast(this.toJson());
  }

  void errorToast() {
    ToastUtil.showErrorToast(this.toJson());
  }

  void infoToast() {
    ToastUtil.showInfoToast(this.toJson());
  }
}
