import 'package:aquila_news_app/constants/ui_constants.dart';
import 'package:aquila_news_app/contollers/news_controller.dart';
import 'package:aquila_news_app/pages/web_view_news.dart';
import 'package:aquila_news_app/widgets/appbar.dart';
import 'package:aquila_news_app/widgets/news_card.dart';
import 'package:aquila_news_app/widgets/side_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsController newsController = Get.put(NewsController());
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "AQUILA News App",
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                newsController.country.value = '';
                newsController.category.value = '';
                newsController.searchNews.value = '';
                newsController.channel.value = '';
                newsController.cName.value = '';
                newsController.getAllNews(reload: true);
                newsController.getBreakingNews(reload: true);
                newsController.update();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
      drawer: sideDrawer(newsController),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: TextField(
                          controller: searchController,
                          textInputAction: TextInputAction.search,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search News"),
                          onChanged: (val) {
                            newsController.searchNews.value = val;
                            newsController.update();
                          },
                          onSubmitted: (value) async {
                            newsController.searchNews.value = value;
                            newsController.getAllNews(
                                searchKey: newsController.searchNews.value);
                            searchController.clear();
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            newsController.getAllNews(
                                searchKey: newsController.searchNews.value);
                            searchController.clear();
                          },
                          icon: const Icon(Icons.search_sharp)),
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder<NewsController>(
                init: NewsController(),
                builder: (controller) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200, autoPlay: true, enlargeCenterPage: true),
                    items: controller.breakingNews.map((instance) {
                      return controller.articleNotFound.value
                          ? const Center(
                              child: Text("Not Found",
                                  style: TextStyle(fontSize: 30)))
                          : controller.breakingNews.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : Builder(builder: (BuildContext context) {
                                  try {
                                    return Banner(
                                      location: BannerLocation.topStart,
                                      message: 'Top Headlines',
                                      child: InkWell(
                                        onTap: () => Get.to(() =>
                                            WebViewNews(newsUrl: instance.url)),
                                        child: Stack(children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              instance.urlToImage ?? " ",
                                              fit: BoxFit.fill,
                                              height: double.infinity,
                                              width: double.infinity,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const SizedBox(
                                                    height: 200,
                                                    width: double.infinity,
                                                    child: Icon(Icons
                                                        .broken_image_outlined),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Positioned(
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 10),
                                                        child: Text(
                                                          instance.title,
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ))),
                                              )),
                                        ]),
                                      ),
                                    );
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print(e);
                                    }
                                    return Container();
                                  }
                                });
                    }).toList(),
                  );
                }),
            vertical10,
            const Divider(),
            vertical10,
            newsController.cName.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Obx(() {
                      return Text(
                        newsController.cName.value.toUpperCase(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    }),
                  )
                : const SizedBox.shrink(),
            vertical10,
            GetBuilder<NewsController>(
                init: NewsController(),
                builder: (controller) {
                  return controller.articleNotFound.value
                      ? const Center(
                          child: Text('Nothing Found'),
                        )
                      : controller.allNews.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              controller: controller.scrollController,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.allNews.length,
                              itemBuilder: (context, index) {
                                index == controller.allNews.length - 1 &&
                                        controller.isLoading.isTrue
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const SizedBox();
                                return InkWell(
                                  onTap: () => Get.to(() => WebViewNews(
                                      newsUrl: controller.allNews[index].url)),
                                  child: NewsCard(
                                      imgUrl: controller
                                              .allNews[index].urlToImage ??
                                          '',
                                      desc: controller
                                              .allNews[index].description ??
                                          '',
                                      title: controller.allNews[index].title,
                                      content:
                                          controller.allNews[index].content ??
                                              '',
                                      postUrl: controller.allNews[index].url),
                                );
                              });
                }),
          ],
        ),
      ),
    );
  }
}
