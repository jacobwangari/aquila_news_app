import 'package:aquila_news_app/pages/homepage.dart';
import 'package:aquila_news_app/pages/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class AppRoutes {
  AppRoutes._();
  static const initial = '/splashScreen';
  static final routes = [
    GetPage(
        name: '/splashScreen',
        page: () => const SplashScreen(),
        transition: Transition.zoom),
    GetPage(
        name: '/homePage',
        page: () => HomePage(),
        transition: Transition.fadeIn),
  ];
}
