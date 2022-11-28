import 'package:wanandroid_flutter/modules/routers.dart';

import 'dependency.dart';
import 'modules/_main/main_page.dart';
import 'modules/splash/splash_view.dart';

void main() {
  _initApp();

  runApp(MyApp());
}

void _initApp() {
  WidgetsFlutterBinding.ensureInitialized();
  if (isAndroid) {
    /// 设置android沉浸式状态栏
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  final _botToastBuilder = BotToastInit();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1080.0, 1960.0),
        builder: () {
          return GetMaterialApp(
            title: "WanAndroid",
            localizationsDelegates: [
              S.delegate,
              // GlobalMaterialLocalizations.delegate,
              // GlobalWidgetsLocalizations.delegate,
              // GlobalCupertinoLocalizations.delegate,
              // RefreshLocalizations.delegate,
            ],
            getPages: RouterManager.routers,
            builder: (context, child) {
              /// APP字体大小不随系统字体大小改变
              child = MediaQuery(
                child: _botToastBuilder(context, child),
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              );
              return child;
            },
            navigatorObservers: [BotToastNavigatorObserver()],
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            initialRoute: SplashPage.routeName,
          );
        });
  }
}
