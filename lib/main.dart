import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractivity_app/core/app_routes/app_routes.dart';
import 'package:tractivity_app/core/dependency/dependency_injection.dart';
import 'utils/app_colors/app_colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 // DeviceUtils.lockDevicePortrait();
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  //SocketApi.init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark
  ));

  runApp(const MyApp());
/*   runApp(DevicePreview(
     enabled: !kReleaseMode,
     builder: (context) =>
         //====================
    const MyApp(), // Wrap your app
   ));*/
  //const MyApp();

}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..backgroundColor = AppColors.brinkPink
    ..indicatorColor = AppColors.brinkPink
    ..textColor = AppColors.brinkPink
    ..maskColor = Colors.white.withOpacity(0.8);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(393, 852),
      child: GetMaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.white,
            appBarTheme: const AppBarTheme(
              //surfaceTintColor: AppColors.brinkPink,
                toolbarHeight: 65,
                elevation: 0,
                centerTitle: true,
                backgroundColor: AppColors.white,
                iconTheme: IconThemeData(color: AppColors.white))),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: AppRoutes.friendScreen,
        navigatorKey: Get.key,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
