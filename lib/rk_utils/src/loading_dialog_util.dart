import 'base_dependency.dart';

class LoadingDialogUtil {
  static Widget loadingDialogWidget({String str = ""}) {
    return Center(
      child: Container(
        height: 200.sp,
        width: 200.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.sp),
        ),
        child: CircleAvatar(
          backgroundImage: AssetImage(
            "assets/webp/robot_loading_dialog.webp",
          ),
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
              if (onClick != null) {
                onClick();
              }
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
              if (onClick != null) {
                onClick();
              }
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
