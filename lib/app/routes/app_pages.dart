import 'package:get/get.dart';

import '../modules/authpage/bindings/authpage_binding.dart';
import '../modules/authpage/views/authpage_view.dart';
import '../modules/menu/bindings/menu_binding.dart';
import '../modules/menu/views/menu_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/resetpass/bindings/resetpass_binding.dart';
import '../modules/resetpass/views/resetpass_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.AUTHPAGE,
      page: () => AuthpageView(),
      binding: AuthpageBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => MenuView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.RESETPASS,
      page: () => ResetpassView(),
      binding: ResetpassBinding(),
    ),
  ];
}
