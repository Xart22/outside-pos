import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/data/database/isar_service.dart';
import 'package:pos_getx/app/service/global_state.dart';
import 'package:pos_getx/app/style/theme.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.init();
  await _initializeAppBindings();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<void> _initializeAppBindings() async {
  await Get.putAsync<GlobalState>(() async => GlobalState());
}
