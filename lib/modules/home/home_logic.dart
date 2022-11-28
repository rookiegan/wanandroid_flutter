import 'package:banner_carousel/banner_carousel.dart';
import 'package:wanandroid_flutter/dependency.dart';

import '../../net/http/wan/model/model.dart';

class HomeLogic extends GetxController {
  final bannerModels = RxList<BannerModel>();
  final articleList = RxList<ArticleData>();

  @override
  void onReady() {
    super.onReady();

    wanApi.getBannerArticles().asStream().loadingDialog().data().map((event) {
      return event.map((e) => BannerModel(imagePath: e.imagePath, id: e.url)).toList();
    }).commit((event) {
      bannerModels.assignAll(event);
      "Banners Model $event".d();
    });

    wanApi.getArticleList().asStream().loadingDialog().data().commit((event) {
      articleList.addAll(event.datas);
      "article List $event".d();
    });
  }
}
