import 'package:get/get.dart';

import '../modules/casier/bindings/casier_binding.dart';
import '../modules/casier/views/casier_view.dart';
import '../modules/casier_form/bindings/casier_form_binding.dart';
import '../modules/casier_form/views/casier_form_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/history_detail/bindings/history_detail_binding.dart';
import '../modules/history_detail/views/history_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/menu_form/bindings/menu_form_binding.dart';
import '../modules/menu_form/views/menu_form_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/views/products_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/variant_form/bindings/variant_form_binding.dart';
import '../modules/variant_form/views/variant_form_view.dart';
import '../modules/variants/bindings/variants_binding.dart';
import '../modules/variants/views/variants_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      bindings: [
        HomeBinding(),
        ProductsBinding(),
        CasierBinding(),
        VariantsBinding(),
        SettingsBinding(),
        HistoryBinding(),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CASIER,
      page: () => const CasierView(),
      binding: CasierBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.VARIANTS,
      page: () => const VariantsView(),
      binding: VariantsBinding(),
    ),
    GetPage(
      name: _Paths.VARIANT_FORM,
      page: () => const VariantFormView(),
      binding: VariantFormBinding(),
    ),
    GetPage(
      name: _Paths.MENU_FORM,
      page: () => const MenuFormView(),
      binding: MenuFormBinding(),
    ),
    GetPage(
      name: _Paths.CASIER_FORM,
      page: () => const CasierFormView(),
      binding: CasierFormBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_DETAIL,
      page: () => const HistoryDetailView(),
      binding: HistoryDetailBinding(),
    ),
  ];
}
