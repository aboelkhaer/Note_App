import 'package:bianat_app/app/bindings/home_binding.dart';
import 'package:bianat_app/app/bindings/auth_binding.dart';
import 'package:bianat_app/view/screens.dart';
import 'package:bianat_app/view/auth_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/';
  static String goToHomeRoute() => home;

  static const String authScreen = '/authScreen';
  static String goToAuthRoute() => authScreen;

  static List<GetPage> routes = [
    GetPage(page: () => const HomeScreen(), name: home, binding: HomeBinding()),
    GetPage(
        page: () => const AuthScreen(),
        name: authScreen,
        binding: AuthBinding()),
  ];
}
