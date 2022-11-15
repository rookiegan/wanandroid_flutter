import 'package:wanandroid_flutter/dependency.dart';
import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  static final routeName = "/SplashPage";

  final logic = Get.put(SplashLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 800.sp),
                  _buildAppLogoWidget(),
                  SizedBox(height: 40.sp),
                  _buildAppNameWidget(),
                ],
              ),
            ),
            _buildCopyRightWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogoWidget() {
    return Obx(() {
      return Container(
        width: 120,
        height: 120,
        child: Container(
          width: 100.0 * logic.logoOpacity.value,
          height: 100.0 * logic.logoOpacity.value,
          child: FlutterLogo(),
        ).center(),
      );
    });
  }

  Widget _buildAppNameWidget() {
    return Text(
      "WanAndroid",
      style: TextStyle(
        fontSize: 70.sp,
      ),
    );
  }

  Widget _buildCopyRightWidget() {
    final currYear = DateTime.now().year;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Text(
            "Copyright©2019-$currYear Rookiegan",
            style: TextStyle(color: RkColors.commonTvMajor, fontSize: RkFontSize.sp_25),
            textAlign: TextAlign.center,
          ),
          Text(
            "All Rights Reserved",
            style: TextStyle(color: RkColors.commonTvMajor, fontSize: RkFontSize.sp_25),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
