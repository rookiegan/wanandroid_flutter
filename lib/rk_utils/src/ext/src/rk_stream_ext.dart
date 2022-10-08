import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'package:wanandroid_flutter/generated/l10n.dart' as l10n;
import '../../loading_dialog_util.dart';
import 'rk_string_ext.dart';

extension StreamExt<S, T> on Stream<T> {
  ///
  /// 在Stream流中显示和取消loading，这个loading在流listen的时候显示，
  /// 在流结束时（doOnCancel、doOnDone、doOnError）隐藏
  ///
  /// exemple:
  ///
  /// ```
  /// Api.getRobotList()
  ///    .loadingDialog(
  ///         dismissOnTap: true,
  ///         loadingWidget: Container(
  ///           width: 200.sp,
  ///           height: 200.sp,
  ///           color: GsColors.blue,
  ///           child: Text("这是一个Loading"),
  ///         ),
  ///         onClick: () {
  ///           "User cancel the loading".d();
  ///         })
  ///     .commit((event) {
  ///    "event: $event".d();
  ///  });
  /// ```
  /// [tips], loadingDialog 的提示信息, 在 V0.4.5 换用小loading之后废弃.
  /// [dismissOnTap], 点击界面是否取消loading显示， 默认为 false.
  /// [loadingWidget, 自定义loadingDialog
  /// [onClick]，点击界面后的回调
  ///
  Stream<T> loadingDialog({
    String? tips,
    dismissOnTap = false,
    Widget? loadingWidget,
    crossPage = false,
    Function? onClick,
  }) {
    late CancelFunc cancelLoading;

    void showLoadingDialog() {
      if (loadingWidget != null) {
        cancelLoading = LoadingDialogUtil.showCustomDialog(
          widget: loadingWidget,
          crossPage: crossPage,
          clickClose: dismissOnTap,
          onClick: onClick,
        );
      } else {
        cancelLoading = LoadingDialogUtil.showLoadingDialog(
          crossPage: crossPage,
          clickClose: dismissOnTap,
          onClick: onClick,
        );
      }
    }

    void dismissLoading() {
      LoadingDialogUtil.dismissTheLoadingDialog(cancelLoading);
    }

    return this
        .doOnListen(showLoadingDialog)
        .doOnCancel(dismissLoading)
        .doOnDone(dismissLoading)
        .doOnError((obj, s) => dismissLoading());
  }

  defaultLoadingDialog() {
    LoadingDialogUtil.showLoadingDialog(crossPage: false);
  }

  Stream<T> timeoutMs(int ms) {
    return this.timeoutCloseStream(Duration(milliseconds: ms));
  }

  Stream<T> timeoutSeconds(int seconds) {
    return this.timeoutCloseStream(Duration(seconds: seconds));
  }

  Stream<T> takeUtil(bool test(T event)) {
    return this.where(test).take(1);
  }

  /// 与原生的 Stream#timeout(Duration duration)不同
  /// timeoutCloseStream在达到超时时间后会将整个流断掉
  Stream<T> timeoutCloseStream(Duration timeLimit) {
    final controller = StreamController<T>();
    late StreamSubscription<T> subscription;
    final timeoutCallback = () {
      controller.addError(Exception('timeout'));
      subscription.cancel();
    };

    controller.onListen = () {
      Zone zone = Zone.current;
      Timer timer = zone.createTimer(timeLimit, timeoutCallback);
      subscription = this.listen(null);
      subscription
        ..onData((T event) {
          controller.add(event);
        })
        ..onError((Object error, StackTrace stackTrace) {
          timer.cancel();
          controller.addError(error, stackTrace);
          controller.close();
          subscription.cancel();
        })
        ..onDone(() {
          timer.cancel();
          controller.close();
        });

      controller.onCancel = () {
        timer.cancel();
        return subscription.cancel();
      };
    };

    return controller.stream;
  }

  /// 后续完善
  StreamSubscription<T> commit(void onData(T event), {Function? onError, void onDone()?, bool cancelOnError = true}) {
    if (onError == null) {
      onError = _defaultHandleError;
    }
    return this.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  void _defaultHandleError(Object error, StackTrace stacktrace) {
    "_defaultHandleError error ===> $error ".d();
    if (error is DioError) {
      _handleDioError(error, stacktrace);
    }
  }

  void _handleDioError(DioError error, StackTrace stacktrace) {
    "_handleDioError error ===> $error ".d();

    if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      l10n.S.current.common_network_anomaly.errorToast();
    } else {
      /// 手机断网的情况下抛的异常是：
      /// DioError [DioErrorType.DEFAULT]: SocketException: Failed host lookup: 'api-gateway.staging.gs-robot.com'
      if (error.message.contains("Failed host lookup")) {
        l10n.S.current.common_network_anomaly.errorToast();
      } else {
        l10n.S.current.common_server_exception.errorToast();
      }
    }
  }
}
