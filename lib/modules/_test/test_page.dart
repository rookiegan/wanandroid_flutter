import 'package:wanandroid_flutter/dependency.dart';
import 'package:wanandroid_flutter/modules/_test/getx/getx_test_page.dart';

import 'media_query/media_query_test_page.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  static final routeName = "/TestPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TestPage"),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              title: Text("GetX"),
              subtitle: Text("GetX测试代码"),
              onTap: () {
                Get.toNamed(GetxTestPage.routeName);
              },
            ),
            ListTile(
              title: Text("MediaQuery"),
              subtitle: Text("MediaQuery测试代码"),
              onTap: () {
                Get.toNamed(MediaQueryTestPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
