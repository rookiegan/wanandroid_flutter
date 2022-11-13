import 'package:wanandroid_flutter/dependency.dart';

class GetxTestPage extends StatelessWidget {
  const GetxTestPage({Key? key}) : super(key: key);

  static final routeName = "/GetxTestPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetxTestPage"),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Times:'),
          ],
        ),
      ),
    );
  }
}
