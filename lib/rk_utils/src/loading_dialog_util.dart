import 'package:wanandroid_flutter/rk_utils/src/constant/index.dart';

import 'base_dependency.dart';

class LoadingDialogUtil {
  static Widget loadingDialogWidget({String str = "加载中..."}) {
    return Center(
      child: Container(
        height: 220.sp,
        width: 220.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(250.sp),
        ),
        child: CircleAvatar(
          backgroundColor: RkColors.gray,
          child: Text(str),
        ),
      ),
    );
  }

  static CancelFunc showLoadingDialog({
    bool crossPage = false,
    bool clickClose = false,
    Function? onClick,
  }) {
    return BotToast.showCustomLoading(
        crossPage: false,
        clickClose: clickClose,
        toastBuilder: (cancelFunc) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: loadingDialogWidget(),
            onTap: () {
              onClick?.call();
              if (clickClose) {
                cancelFunc();
              }
            },
          );
        });
  }

  static CancelFunc showCustomDialog({
    Widget? widget,
    bool crossPage = false,
    bool clickClose = false,
    Function? onClick,
  }) {
    return BotToast.showCustomLoading(
        crossPage: false,
        clickClose: clickClose,
        toastBuilder: (cancelFunc) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: widget ?? loadingDialogWidget(),
            onTap: () {
              onClick?.call();
              if (clickClose) {
                cancelFunc();
              }
            },
          );
        });
  }

  static void closeAllLoading() {
    BotToast.closeAllLoading();
  }

  static void dismissTheLoadingDialog(CancelFunc? cancelFunc) {
    if (cancelFunc == null) {
      throw Exception("cancelFunc 不能为空");
    }
    cancelFunc();
  }
}
