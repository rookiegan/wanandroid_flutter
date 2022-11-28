import 'package:dio_log/overlay_draggable_button.dart';
import 'package:wanandroid_flutter/modules/home/home_page.dart';

import '../../dependency.dart';
import 'float_widget.dart';

class MainPage extends StatefulWidget {
  static final routeName = "/MainPage";

  @override
  State<MainPage> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  static PageController _pageController = PageController();
  final List<Widget> _bottomNavPages = [
    HomePage(),
    Container(color: Colors.red),
    Container(color: Colors.yellow),
    Container(color: Colors.green),
  ];

  int _pageIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: "Tab2"),
    BottomNavigationBarItem(icon: Icon(Icons.refresh), label: "Tab3"),
    BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Tab4"),
  ];

  @override
  void initState() {
    super.initState();
    showDebugBtn(context, btnColor: Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _bottomNavPages.length,
        itemBuilder: (context, index) => _bottomNavPages[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomNavBarItems,
        currentIndex: _pageIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (_pageController.hasClients) {
            _pageIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
            setState(() {});
          }
        },
      ),
      floatingActionButton: _buildDebugFAB(),
    );
  }

  Widget _buildDebugFAB() {
    return FloatWidget(
      child: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          // Get.toNamed(TestPage.routeName);

          // final response = CommonResponse(data: "123", errorMsg: "AAA", errorCode: 200);
          // "response= $response".d();

          wanApi.getBannerArticles().asStream().delay(Duration(seconds: 2)).data().loadingDialog().commit((event) {
            "event=== ${event.length}".d();
          });
        },
        child: const Text("Debug"),
        tooltip: "Debug",
      ),
    );
  }
}
