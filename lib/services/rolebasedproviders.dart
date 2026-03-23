// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
//
// import '../features/collector/home/controller/collectoramountfilter_controller.dart';
// import '../features/collector/home/controller/collectordashboard_controller.dart';
// import '../features/collector/home/controller/collectordetails_controller.dart';
// import '../features/collector/home/controller/collectorsdmlist_controller.dart';
// import '../features/collector/home/controller/collectortemplelist_controller.dart';
// import '../features/login/controller/auth_controller.dart';
// import '../features/sdm/home/controller/employeelist_controller.dart';
// import '../features/sdm/home/controller/sdmamount_controller.dart';
// import '../features/sdm/home/controller/sdmdashboard_controller.dart';
// import '../features/sdm/home/controller/sdmdetails_controller.dart';
//
// class RoleBasedProviders extends StatelessWidget {
//   final Widget child;
//
//   const RoleBasedProviders({required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthController>(context);
//
//     if (!auth.isLoggedIn) {
//       return child;
//     }
//
//     print("Role Based Type Login ${auth.type}");
//
//     if (auth.type == 'sdm') {
//       return MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (_) => SDMDashboardController()),
//           ChangeNotifierProvider(create: (_) => SDMDetailsController()),
//           ChangeNotifierProvider(create: (_) => SDMAmountFilterController()),
//           ChangeNotifierProvider(create: (_) => EmployeeListController()),
//         ],
//         child: child,
//       );
//     }
//
//     // collector
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => CollectorDashboardController()),
//         ChangeNotifierProvider(create: (_) => CollectorDetailsController()),
//         ChangeNotifierProvider(create: (_) => CollectorSDMListController()),
//         ChangeNotifierProvider(create: (_) => CollectorTempleListController()),
//         ChangeNotifierProvider(create: (_) => CollectorAmountFilterController()),
//       ],
//       child: child,
//     );
//   }
// }
