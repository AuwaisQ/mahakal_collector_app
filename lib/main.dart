import 'package:collectorapp/features/login/controller/auth_controller.dart';
import 'package:collectorapp/features/sdm/home/controller/sdmdashboard_controller.dart';
import 'package:collectorapp/services/connectivity_service.dart';
import 'package:collectorapp/services/rolebasedproviders.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'features/collector/home/controller/collectoramountfilter_controller.dart';
import 'features/collector/home/controller/collectordashboard_controller.dart';
import 'features/collector/home/controller/collectordetails_controller.dart';
import 'features/collector/home/controller/collectorsdmlist_controller.dart';
import 'features/collector/home/controller/collectortemplelist_controller.dart';
import 'features/sdm/home/controller/sdmdetails_controller.dart';
import 'features/splash/controller/splash_controller.dart';
import 'features/splash/splashscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        /// Providers
        ChangeNotifierProvider(create: (_) => ConnectivityService(),),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => SplashController(),),

      ],
      child: RoleBasedProviders(
        child: GetMaterialApp(
          title: 'Collector App',
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
