import 'base_dependency.dart';
import 'constant/index.dart';

class ToastUtil {
  static void showErrorToast(String tips, {bool crossPage: false}) {
    _showToast(tips, crossPage: crossPage, toastColor: RkColors.toastColorError);
  }

  static void showSuccessToast(String tips, {bool crossPage: false}) {
    _showToast(tips, crossPage: crossPage, toastColor: RkColors.toastColorTips);
  }

  static void showInfoToast(String tips, {bool crossPage: false}) {
    _showToast(tips, crossPage: crossPage);
  }

  static void showBottomToast(String tips, {bool crossPage: false}) {
    _showBottomToast(tips, crossPage: crossPage);
  }

  static void _showToast(String tips, {bool crossPage: false, Color toastColor: RkColors.toastColorInfo}) {
    BotToast.showCustomText(
      crossPage: crossPage,
      onlyOne: true,
      align: Alignment.center,
      duration: Duration(seconds: 3),
      toastBuilder: (textCancel) => Container(
        margin: EdgeInsets.symmetric(horizontal: 140.sp),
        decoration: BoxDecoration(
            color: toastColor,
            borderRadius: BorderRadius.all(
              Radius.circular(RkSize.borderRadius),
            )),
        constraints: BoxConstraints(maxHeight: 750.sp),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 66.sp, horizontal: 90.sp),
          child: Text(tips, style: TextStyle(color: Colors.white, fontSize: RkFontSize.sp_48)),
        ),
      ),
    );
  }

  static void _showBottomToast(String tips, {bool crossPage: false, Color toastColor: RkColors.toastColorInfo}) {
    BotToast.showCustomText(
      crossPage: crossPage,
      onlyOne: true,
      duration: Duration(seconds: 3),
      align: Alignment(0, 0.75),
      toastBuilder: (textCancel) => Container(
        margin: EdgeInsets.only(right: 43.sp, left: 43.sp),
        decoration: BoxDecoration(
            color: toastColor,
            borderRadius: BorderRadius.all(
              Radius.circular(RkSize.borderRadius),
            )),
        constraints: BoxConstraints(maxHeight: 750.sp),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 66.sp, horizontal: 90.sp),
          child: Text(tips, style: TextStyle(color: Colors.white, fontSize: RkFontSize.sp_48)),
        ),
      ),
    );
  }
}
