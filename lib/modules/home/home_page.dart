import 'package:banner_carousel/banner_carousel.dart';
import 'package:wanandroid_flutter/dependency.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Banners
          _buildBanners(),

          /// Articles
          _buildArticleList(),
        ],
      ),
    );
  }

  Widget _buildBanners() {
    return Container(
      width: double.infinity,
      height: 700.sp,
      child: Obx(
        () => BannerCarousel(
          banners: logic.bannerModels.value,
          customizedIndicators: IndicatorModel.animation(
            width: 20,
            height: 5,
            spaceBetween: 2,
            widthAnimation: 50,
          ),
          height: 700.sp,
          activeColor: Colors.amberAccent,
          disableColor: Colors.white,
          animation: true,
          borderRadius: 23.sp,
          margin: EdgeInsets.all(0),
          width: double.infinity,
          indicatorBottom: false,
        ),
      ),
    );
  }

  Widget _buildArticleList() {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Obx(() {
          return ListView.builder(
            itemCount: logic.articleList.value.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(20.sp),
                padding: EdgeInsets.all(20.sp),
                width: double.infinity,
                height: 200.sp,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(23.sp)),
                ),
                child: Text(
                  logic.articleList[index].title,
                  maxLines: 1,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
